
import XCTest
@testable import VectorExtor

class CGVectorExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCGVectorUtilities() {
		let vec = CGVector(dx: 34, dy: 8.432)
		let point = vec.point

		XCTAssertEqual(vec.dx, point.x)
		XCTAssertEqual(vec.dy, point.y)

		let notNormal = CGVector(dx: 1, dy: 1)
		XCTAssertEqual(notNormal.isNormal, false)
		let normalized = notNormal.normalized
		XCTAssertEqual(normalized.isNormal, true)

		let normalVec = CGVector(dx: 0.7071067, dy: 0.7071067)
		XCTAssertEqual(normalVec.isNormal, true)

		let one = CGVector(dx: 1, dy: 1)
		let two = CGVector(dx: 2, dy: 2)
		let three = one + two
		XCTAssertEqual(three, CGVector(dx: 3, dy: 3))

		let six = two * 3
		XCTAssertEqual(six, CGVector(dx: 6, dy: 6))

		let inverted = notNormal.inverted
		XCTAssertEqual(inverted, CGVector(dx: -1, dy: -1))

		var rotationVector = CGVector(fromDegree: 0)
		XCTAssertEqual(rotationVector.dx, 1, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0, accuracy: 0.0000001)

		rotationVector = CGVector(fromDegree: 45)
		XCTAssertEqual(rotationVector.dx, 0.7071067811865476, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0.7071067811865476, accuracy: 0.0000001)

		rotationVector = CGVector(fromDegree: 90)
		XCTAssertEqual(rotationVector.dx, 0, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 1, accuracy: 0.0000001)

		rotationVector = CGVector(fromDegree: 180)
		XCTAssertEqual(rotationVector.dx, -1, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0, accuracy: 0.0000001)

		rotationVector = CGVector(fromDegree: 270)
		XCTAssertEqual(rotationVector.dx, 0, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, -1, accuracy: 0.0000001)

		rotationVector = CGVector(fromDegree: 360)
		XCTAssertEqual(rotationVector.dx, 1, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0, accuracy: 0.0000001)

		rotationVector = CGVector(fromRadian: 0)
		XCTAssertEqual(rotationVector.dx, 1, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0, accuracy: 0.0000001)

		rotationVector = CGVector(fromRadian: CGFloat.pi / 2)
		XCTAssertEqual(rotationVector.dx, 0, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 1, accuracy: 0.0000001)

		rotationVector = CGVector(fromRadian: CGFloat.pi)
		XCTAssertEqual(rotationVector.dx, -1, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0, accuracy: 0.0000001)

		rotationVector = CGVector(fromRadian: CGFloat.pi * 1.5)
		XCTAssertEqual(rotationVector.dx, 0, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, -1, accuracy: 0.0000001)

		rotationVector = CGVector(fromRadian: CGFloat.pi * 2)
		XCTAssertEqual(rotationVector.dx, 1, accuracy: 0.0000001)
		XCTAssertEqual(rotationVector.dy, 0, accuracy: 0.0000001)

		let scalar3 = CGVector(scalar: 3)
		let scalar35 = CGVector(scalar: 3.5)

		XCTAssertEqual(scalar3, CGVector(dx: 3, dy: 3))
		XCTAssertEqual(scalar35, CGVector(dx: 3.5, dy: 3.5))
	}

	func testCGVectorHashing() {
		let point0 = CGVector.zero
		let point1 = CGVector(dx: 1, dy: 0)
		let point2 = CGVector(dx: 0, dy: 1)

		let hash0 = point0.hashValue
		let hash1 = point1.hashValue
		let hash2 = point2.hashValue

		XCTAssertNotEqual(hash0, hash1)
		XCTAssertNotEqual(hash0, hash2)
		XCTAssertNotEqual(hash1, hash2)
	}
}
