import XCTest
@testable import variable

final class variableTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(variable().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
