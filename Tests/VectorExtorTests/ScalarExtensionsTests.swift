
import XCTest
@testable import VectorExtor

class ScalarExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testDoubleAndCGFloat() {
		let valueCG: CGFloat = 12.34
		let valueDouble = 12.34

		XCTAssertEqual(valueCG.double, valueDouble)
		XCTAssertEqual(valueDouble.cgFloat, valueCG)
	}
}
