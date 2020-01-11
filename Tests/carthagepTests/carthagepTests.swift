import XCTest
@testable import carthagep

final class carthagepTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(carthagep().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
