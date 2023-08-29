import XCTest
import VectorExtor

class ScalarExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	@available(macOS 11.0, iOS 14.0, *)
	func testDoubleAndCGFloat() {
		let valueCG: CGFloat = 12.34
		let valueDouble = 12.34
		let floatVal: Float = 12.34
		let float16Val: Float16 = 12.34
		#if arch(x86_64)
		let float80Val: Float80 = 12.34
		#endif

		XCTAssertEqual(valueCG.toDouble, valueDouble)
		XCTAssertEqual(valueDouble.toCGFloat, valueCG)
		XCTAssertEqual(valueDouble.toFloat, floatVal)
		XCTAssertEqual(valueDouble.toFloat16, float16Val)

		#if arch(x86_64)
		XCTAssertEqual(valueDouble.toFloat80, float80Val)
		#endif
	}

	func testRangeClipping() {
		let range: ClosedRange<CGFloat> = 0...1
		let range2: ClosedRange<CGFloat> = 5...42.3

		var value: CGFloat = 0.23
		XCTAssertEqual(0.23, value.clamped(to: range))
		XCTAssertEqual(0.23, value.clamped())
		XCTAssertEqual(5, value.clamped(to: range2))
		value = 50
		XCTAssertEqual(1, value.clamped(to: range))
		XCTAssertEqual(1, value.clamped())
		XCTAssertEqual(42.3, value.clamped(to: range2))
		XCTAssertEqual(60, value.clamped(to: 60...100))
		value = -50
		XCTAssertEqual(0, value.clamped(to: range))
		XCTAssertEqual(0, CGFloat(-50).clamped(to: range))
		XCTAssertEqual(5, value.clamped(to: range2))


		let range3 = 0...40
		let value2 = -5
		XCTAssertEqual(23, 23.clamped(to: range3))
		XCTAssertEqual(40, 42.clamped(to: range3))
		XCTAssertEqual(0, (-20).clamped(to: range3))
		XCTAssertEqual(0, value2.clamped(to: range3))
	}
}
