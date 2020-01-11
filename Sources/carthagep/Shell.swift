import Foundation


@discardableResult
func shell(_ args: [String]) -> Process {
    let p = Process()
    p.launchPath = "/usr/bin/env"
    p.arguments = args
    return p
}

@discardableResult
func shell(_ cmds: String...) -> Process {
    shell(cmds)
}

@discardableResult
func shell(_ cmd: String) -> Process {
    shell(cmd.components(separatedBy: .whitespaces))
}
