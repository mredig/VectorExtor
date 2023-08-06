import XCTest
import VectorExtor

class CGAffineTransformExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCGAffineTransform() {
		let transform = CGAffineTransform(translationX: 10, y: 20)
		XCTAssertEqual(transform.offset, CGPoint(x: 10, y: 20))
	}
}
