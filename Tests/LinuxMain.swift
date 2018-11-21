import XCTest

import variableTests

var tests = [XCTestCaseEntry]()
tests += variableTests.allTests()
XCTMain(tests)