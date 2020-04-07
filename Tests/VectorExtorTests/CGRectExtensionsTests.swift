
import XCTest
import VectorExtor

class CGRectExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testRectUtilities() {
		let size = CGSize(width: 10, height: 50)
		let rect = CGRect(origin: .zero, size: size)
		XCTAssertEqual(rect.maxXY, size.point)

		XCTAssertEqual(rect.midPoint, CGPoint(x: 5, y: 25))

		let orig2 = CGPoint(x: 10, y: -10)
		let rect2 = CGRect(origin: orig2, size: size)
		XCTAssertEqual(rect2.maxXY, (size + orig2).point)

		XCTAssertEqual(rect2.midPoint, CGPoint(x: 15, y: 15))

		XCTAssertEqual(rect.maxXMinY, CGPoint(x: 10, y: 0))
		XCTAssertEqual(rect.minXMaxY, CGPoint(x: 0, y: 50))

		XCTAssertEqual(rect2.maxXMinY, CGPoint(x: 20, y: -10))
		XCTAssertEqual(rect2.minXMaxY, CGPoint(x: 10, y: 40))
	}

	func testSizeInit() {
		let size = CGSize(width: 10, height: 50)

		XCTAssertEqual(CGRect(x: 0, y: 0, width: 10, height: 50), CGRect(size: size))
	}

	func testScalar() {
		let scalar = CGRect(scalarOrigin: 3.5, scalarSize: 4.5)
		XCTAssertEqual(scalar, CGRect(x: 3.5, y: 3.5, width: 4.5, height: 4.5))
	}
}
