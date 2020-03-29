
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
}
