
import XCTest
import VectorExtor

class CGSizeExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCGSizeUtilities() {
		let sizeA = CGSize(width: 3, height: 4)
		let sizeB = CGSize(width: 10, height: 15)

		XCTAssertEqual(-sizeA, CGSize(width: -3, height: -4))

		let size2 = sizeA * 2
		XCTAssertEqual(size2, CGSize(width: 6, height: 8))

		let sizePlus2 = sizeA + 2
		XCTAssertEqual(sizePlus2, CGSize(width: 5, height: 6))

		let sizeMinus2 = sizeA - 2
		XCTAssertEqual(sizeMinus2, CGSize(width: 1, height: 2))

		let sizeAB = sizeA + sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 13, height: 19))

		let sizeAMinusB = sizeA - sizeB
		XCTAssertEqual(sizeAMinusB, CGSize(width: -7, height: -11))

		let sizeC = sizeA * sizeB
		XCTAssertEqual(sizeC, CGSize(width: 30, height: 60))

		let point = sizeA.point
		XCTAssertEqual(point, CGPoint(x: 3, y: 4))

		let scalar3 = CGSize(scalar: 3)
		let scalar35 = CGSize(scalar: 3.5)
		XCTAssertEqual(scalar3, CGSize(width: 3, height: 3))
		XCTAssertEqual(scalar35, CGSize(width: 3.5, height: 3.5))

		XCTAssertEqual(sizeA.midPoint, CGPoint(x: 1.5, y: 2))
	}

	func testDivision() {
		let sizeA = CGSize(width: 22, height: 45)
		let sizeB = CGSize(width: 2, height: 15)

		let sizeC = CGSize(scalar: 2)

		XCTAssertEqual(CGSize(width: 11, height: 3), sizeA / sizeB)
		XCTAssertEqual(CGSize(width: 11, height: 22.5), sizeA / sizeC)
		XCTAssertEqual(CGSize(width: 11, height: 22.5), sizeA / 2)
	}

	func testNormalizationConversion() {
		let size = CGSize(width: 100, height: 50)

		let normalA = CGPoint(x: 0.9, y: 0.1)
		let absA = CGPoint(x: 90, y: 5)

		let normalB = CGPoint(x: 0.1, y: 0.8)
		let absB = CGPoint(x: 10, y: 40)

		XCTAssertEqual(absA, size.normalPointToAbsolute(normalPoint: normalA))
		XCTAssertEqual(normalA, size.absolutePointToNormal(absolutePoint: absA))

		XCTAssertEqual(absB, size.normalPointToAbsolute(normalPoint: normalB))
		XCTAssertEqual(normalB, size.absolutePointToNormal(absolutePoint: absB))
	}

	func testCGSizeOperands() {
		let sizeA = CGSize(width: 5, height: 7)
		let sizeB = CGSize(width: 2.5, height: 5)

		// test negate
		XCTAssertEqual(-sizeA, CGSize(width: -5, height: -7))

		// cgsize with cgsize compuation tests
		XCTAssertEqual(sizeA + sizeB, CGSize(width: 7.5, height: 12))
		var sizeAB = sizeA
		sizeAB += sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 7.5, height: 12))

		XCTAssertEqual(sizeA - sizeB, CGSize(width: 2.5, height: 2))
		sizeAB = sizeA
		sizeAB -= sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 2.5, height: 2))

		XCTAssertEqual(sizeA * sizeB, CGSize(width: 12.5, height: 35))
		sizeAB = sizeA
		sizeAB *= sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 12.5, height: 35))

		XCTAssertEqual(sizeA / sizeB, CGSize(width: 2, height: 1.4))
		sizeAB = sizeA
		sizeAB /= sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 2, height: 1.4))

		// cgsize with cgvector computation tests
		let bVector = sizeB.vector
		XCTAssertEqual(sizeA + bVector, CGSize(width: 7.5, height: 12))
		sizeAB = sizeA
		sizeAB += bVector
		XCTAssertEqual(sizeAB, CGSize(width: 7.5, height: 12))

		XCTAssertEqual(sizeA - bVector, CGSize(width: 2.5, height: 2))
		sizeAB = sizeA
		sizeAB -= bVector
		XCTAssertEqual(sizeAB, CGSize(width: 2.5, height: 2))

		XCTAssertEqual(sizeA * bVector, CGSize(width: 12.5, height: 35))
		sizeAB = sizeA
		sizeAB *= bVector
		XCTAssertEqual(sizeAB, CGSize(width: 12.5, height: 35))

		XCTAssertEqual(sizeA / bVector, CGSize(width: 2, height: 1.4))
		sizeAB = sizeA
		sizeAB /= bVector
		XCTAssertEqual(sizeAB, CGSize(width: 2, height: 1.4))

		// cgsize with cgpoint computation tests
		let bPoint = sizeB.point
		XCTAssertEqual(sizeA + bPoint, CGSize(width: 7.5, height: 12))
		sizeAB = sizeA
		sizeAB += bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 7.5, height: 12))

		XCTAssertEqual(sizeA - bPoint, CGSize(width: 2.5, height: 2))
		sizeAB = sizeA
		sizeAB -= bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 2.5, height: 2))

		XCTAssertEqual(sizeA * bPoint, CGSize(width: 12.5, height: 35))
		sizeAB = sizeA
		sizeAB *= bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 12.5, height: 35))

		XCTAssertEqual(sizeA / bPoint, CGSize(width: 2, height: 1.4))
		sizeAB = sizeA
		sizeAB /= bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 2, height: 1.4))

		// cgfloat computation tests
		let cgFloatValue: CGFloat = 5
		XCTAssertEqual(sizeA + cgFloatValue, CGSize(width: 10, height: 12))
		var pointCGFloat = sizeA
		pointCGFloat += cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 10, height: 12))

		XCTAssertEqual(sizeA - cgFloatValue, CGSize(width: 0, height: 2))
		pointCGFloat = sizeA
		pointCGFloat -= cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 0, height: 2))

		XCTAssertEqual(sizeA * cgFloatValue, CGSize(width: 25, height: 35))
		pointCGFloat = sizeA
		pointCGFloat *= cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 25, height: 35))

		XCTAssertEqual(sizeA / cgFloatValue, CGSize(width: 1, height: 1.4))
		pointCGFloat = sizeA
		pointCGFloat /= cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 1, height: 1.4))
	}

	func testSizeMinMax() {
		let sizeA = CGSize(width: 5, height: 7)
		let sizeB = CGSize(width: 2.5, height: 5)

		XCTAssertEqual(sizeA.min, 5)
		XCTAssertEqual(sizeA.max, 7)
		XCTAssertEqual(sizeB.min, 2.5)
		XCTAssertEqual(sizeB.max, 5)
	}
}
