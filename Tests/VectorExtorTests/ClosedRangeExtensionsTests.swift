import XCTest
import VectorExtor

class ClosedRangeExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testRangeInterpolation() {
		let rangeA = 0...100.0

		XCTAssertEqual(rangeA.interpolated(at: 0.5), 50, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 0.25), 25, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: -1), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: -1, clamped: false), -100, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 0.9), 90, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 1.9), 100, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 1.9, clamped: false), 190, accuracy: 0.000000001)

		let rangeB = -20.0...20
		XCTAssertEqual(rangeB.interpolated(at: 0), -20, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 0.5), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 1), 20, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 2), 20, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 2, clamped: false), 60, accuracy: 0.000000001)

		let rangeC = -10...20.0
		XCTAssertEqual(rangeC.interpolated(at: 0.5), 5, accuracy: 0.000000001)
		XCTAssertEqual(rangeC.interpolated(at: -1), -10, accuracy: 0.000000001)
		XCTAssertEqual(rangeC.interpolated(at: -1, clamped: false), -40, accuracy: 0.000000001)
	}

	func testRangeLinearPoint() {
		let rangeA = 0...100.0
		let rangeB = 20...40.0

		XCTAssertEqual(rangeA.linearPoint(of: 50), 0.5, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.linearPoint(of: 25), 0.25, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.linearPoint(of: -10), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.linearPoint(of: -10, clamped: false), -0.1, accuracy: 0.000000001)

		XCTAssertEqual(rangeB.linearPoint(of: 20), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 30), 0.5, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 40), 1, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 45), 1, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 45, clamped: false), 1.25, accuracy: 0.000000001)
	}

	func testOffset() {
		let rangeA = 0...100
		let rangeB = (-5)...5
		let rangeC = (-20)...(-10.0)

		XCTAssertEqual(rangeA.offset(by: 5), 5...105)
		XCTAssertEqual(rangeA.offset(by: -5), -5...95)

		XCTAssertEqual(rangeB.offset(by: 5), 0...10)
		XCTAssertEqual(rangeB.offset(by: -5), (-10)...0)

		XCTAssertEqual(rangeC.offset(by: 5), (-15)...(-5))
		XCTAssertEqual(rangeC.offset(by: -5), (-25)...(-15))
	}
}
