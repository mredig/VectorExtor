
import XCTest
import VectorExtor

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

	func testRangeClipping() {
		let range: ClosedRange<CGFloat> = 0...1
		let range2: ClosedRange<CGFloat> = 5...42.3

		var value: CGFloat = 0.23
		XCTAssertEqual(0.23, value.clipped(to: range))
		XCTAssertEqual(5, value.clipped(to: range2))
		value = 50
		XCTAssertEqual(1, value.clipped(to: range))
		XCTAssertEqual(42.3, value.clipped(to: range2))
		XCTAssertEqual(60, value.clipped(to: 60...100))
	}
}
