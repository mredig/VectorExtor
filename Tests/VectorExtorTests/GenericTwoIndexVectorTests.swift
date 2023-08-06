import XCTest
import VectorExtor

class GenericTwoIndexVectorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testToSIMD() {
		let point = CGPoint(x: 100, y: 200)
		let vector = CGVector(dx: -20, dy: 62)
		let size = CGSize(width: 99, height: 10)

		XCTAssertEqual(point.simd, SIMD2(100, 200))
		XCTAssertEqual(vector.simd, SIMD2(-20, 62))
		XCTAssertEqual(size.simd, SIMD2(99, 10))
	}

	func testFromSIMD() {
		let simd = SIMD2(123, -456.0)

		var point = CGPoint.zero
		var vector = CGVector.zero
		var size = CGSize.zero

		XCTAssertNotEqual(point.simd, simd)
		XCTAssertNotEqual(vector.simd, simd)
		XCTAssertNotEqual(size.simd, simd)

		point.simd = simd
		vector.simd = simd
		size.simd = simd

		XCTAssertEqual(point.simd, simd)
		XCTAssertEqual(vector.simd, simd)
		XCTAssertEqual(size.simd, simd)
	}
}
