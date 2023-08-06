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
		XCTAssertEqual(0.23, value.clipped())
		XCTAssertEqual(5, value.clipped(to: range2))
		value = 50
		XCTAssertEqual(1, value.clipped(to: range))
		XCTAssertEqual(1, value.clipped())
		XCTAssertEqual(42.3, value.clipped(to: range2))
		XCTAssertEqual(60, value.clipped(to: 60...100))
		value = -50
		XCTAssertEqual(0, value.clipped(to: range))
		XCTAssertEqual(0, CGFloat(-50).clipped(to: range))
		XCTAssertEqual(5, value.clipped(to: range2))


		let range3 = 0...40
		let value2 = -5
		XCTAssertEqual(23, 23.clipped(to: range3))
		XCTAssertEqual(40, 42.clipped(to: range3))
		XCTAssertEqual(0, (-20).clipped(to: range3))
		XCTAssertEqual(0, value2.clipped(to: range3))
	}
}
