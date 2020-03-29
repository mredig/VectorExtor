
import XCTest
@testable import VectorExtor

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
}
