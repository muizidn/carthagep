import Foundation

let fm = FileManager.default
let cwd = fm.currentDirectoryPath

let cartfilePath = cwd + "/Cartfile"
let cartfile = try String.init(contentsOfFile: cartfilePath)

let regex = #"github .*\/(.*?)".*"#
let re = try NSRegularExpression(pattern: regex, options: [])

let deps = cartfile
    .components(separatedBy: .newlines)
    .filter({ !$0.hasPrefix("#") })
    .compactMap({ line in
        re.firstMatch(
            in: line,
            options: [],
            range: NSRange.init(location: 0, length: line.count))
            .map({ Range($0.range(at: 1), in: line).map({ line[$0] }) })
    })
    .compactMap({ $0 })

let args = CommandLine.arguments.dropFirst()

if args.count == 0 {
    print("Cartfile Dependencies: \(deps.count)")
    print(deps.joined(separator: "\n"))
    exit(0)
}

var processes = [String:Process]()

signal(SIGINT, { s in
    processes.forEach({ $0.value.interrupt() })
})
signal(SIGTERM, { s in
    processes.forEach({ $0.value.terminate() })
})
signal(SIGKILL, { s in
    processes.forEach({ kill($0.value.processIdentifier, SIGKILL) })
})

for dep in deps {
    let cmd = ["carthage"] + args  + [String(dep)]
    let name = "\(dep)"
    let p = shell(cmd)
    processes[name] = p
    p.launch()
    print("Running \(name) at \(p.processIdentifier): \(cmd.joined(separator: " "))")
}

print("Subprocess spawned : \(processes.count)")
while processes.contains(where: { $0.value.isRunning }) {}

let info = processes
    .map({ ($0.key, status: $0.value.terminationStatus) })
    .map({ "\($0.0) exit status: \($0.status)"})
    .joined(separator:"\n")

print(
    """
    Finished
    \(info)
    Done
    """
)
