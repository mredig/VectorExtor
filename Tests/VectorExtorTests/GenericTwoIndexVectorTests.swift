import XCTest
import VectorExtor

class GenericTwoIndexVectorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testToSIMD2() {
		let point = CGPoint(x: 100, y: 200)
		let vector = CGVector(dx: -20, dy: 62)
		let size = CGSize(width: 99, height: 10)

		XCTAssertEqual(point.simd, SIMD2(100, 200))
		XCTAssertEqual(vector.simd, SIMD2(-20, 62))
		XCTAssertEqual(size.simd, SIMD2(99, 10))
	}

	func testFromSIMD2() {
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

	func testToSIMD3() {
		let point = CGPoint(x: 100, y: 200)
		let vector = CGVector(dx: -20, dy: 62)
		let size = CGSize(width: 99, height: 10)

		XCTAssertEqual(point.simd3xy, SIMD3(100, 200, 0))
		XCTAssertEqual(vector.simd3xy, SIMD3(-20, 62, 0))
		XCTAssertEqual(size.simd3xy, SIMD3(99, 10, 0))

		XCTAssertEqual(point.simd3xz, SIMD3(100, 0, 200))
		XCTAssertEqual(vector.simd3xz, SIMD3(-20, 0, 62))
		XCTAssertEqual(size.simd3xz, SIMD3(99, 0, 10))
	}

	func testFromSIMD3() {
		let simd = SIMD3(123, -456.0, 789)

		var point = CGPoint.zero
		var vector = CGVector.zero
		var size = CGSize.zero

		XCTAssertNotEqual(point.simd3xy, simd)
		XCTAssertNotEqual(vector.simd3xy, simd)
		XCTAssertNotEqual(size.simd3xy, simd)
		XCTAssertNotEqual(point.simd3xz, simd)
		XCTAssertNotEqual(vector.simd3xz, simd)
		XCTAssertNotEqual(size.simd3xz, simd)

		point.simd3xy = simd
		vector.simd3xy = simd
		size.simd3xy = simd

		let expectedXY = SIMD3(simd.x, simd.y, 0)
		XCTAssertEqual(point.simd3xy, expectedXY)
		XCTAssertEqual(vector.simd3xy, expectedXY)
		XCTAssertEqual(size.simd3xy, expectedXY)
		XCTAssertNotEqual(point.simd3xz, expectedXY)
		XCTAssertNotEqual(vector.simd3xz, expectedXY)
		XCTAssertNotEqual(size.simd3xz, expectedXY)

		point.simd3xz = simd
		vector.simd3xz = simd
		size.simd3xz = simd
		let expectedXZ = SIMD3(simd.x, 0, simd.z)
		XCTAssertEqual(point.simd3xz, expectedXZ)
		XCTAssertEqual(vector.simd3xz, expectedXZ)
		XCTAssertEqual(size.simd3xz, expectedXZ)
		XCTAssertNotEqual(point.simd3xy, expectedXZ)
		XCTAssertNotEqual(vector.simd3xy, expectedXZ)
		XCTAssertNotEqual(size.simd3xy, expectedXZ)
	}

	func testAbsValue() throws {
		let size = CGSize(width: 1920, height: 1080)
		let pos = CGPoint(x: 640, y: -480)
		let vec = CGVector(dx: -1024, dy: 768)
		let final = CGPoint(x: -1280, y: -720)

		XCTAssertEqual(abs(size), CGSize(width: 1920, height: 1080))
		XCTAssertEqual(abs(pos), CGPoint(x: 640, y: 480))
		XCTAssertEqual(abs(vec), CGVector(dx: 1024, dy: 768))
		XCTAssertEqual(abs(final), CGPoint(x: 1280, y: 720))
	}

	func testNegateValue() throws {
		let size = CGSize(width: 1920, height: 1080)
		let pos = CGPoint(x: 640, y: -480)
		let vec = CGVector(dx: -1024, dy: 768)
		let final = CGPoint(x: -1280, y: -720)

		XCTAssertEqual(negate(size), CGSize(width: -1920, height: -1080))
		XCTAssertEqual(negate(pos), CGPoint(x: -640, y: 480))
		XCTAssertEqual(negate(vec), CGVector(dx: 1024, dy: -768))
		XCTAssertEqual(negate(final), CGPoint(x: 1280, y: 720))
	}
}
