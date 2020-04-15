
import XCTest
@testable import VectorExtor

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class CGPathExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func generateBezierScribble() -> CGPath {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 0, y: 7))
		path.addLine(to: CGPoint(x: 44, y: 7))
		path.addCurve(to: CGPoint(x: 66, y: 0), control1: CGPoint(x: 44, y: 7), control2: CGPoint(x: 68, y: 9))
		path.addQuadCurve(to: CGPoint(x: 80, y: -7), control: CGPoint(x: 66, y: -7))
		return path
	}

	func testPathElements() {
		let path = generateBezierScribble()

		let elements = path.elements

		let element0: CGPath.PathElement = .moveTo(point: CGPoint(x: 0, y: 7))
		let element1: CGPath.PathElement = .addLineTo(point: CGPoint(x: 44, y: 7))
		let element2: CGPath.PathElement = .addCurveTo(point: CGPoint(x: 66, y: 0),
													   controlPoint1: CGPoint(x: 44, y: 7),
													   controlPoint2: CGPoint(x: 68, y: 9))
		let element3: CGPath.PathElement = .addQuadCurveTo(point: CGPoint(x: 80, y: -7),
														   controlPoint: CGPoint(x: 66, y: -7))

		XCTAssertEqual(element0, elements[0])
		XCTAssertEqual(element1, elements[1])
		XCTAssertEqual(element2, elements[2])
		XCTAssertEqual(element3, elements[3])

		let sections = path.sections
		let (section0, section1, section2, section3) = (sections[0], sections[1], sections[2], sections[3])
		XCTAssertNil(section0.previous)
		XCTAssertEqual(section0.element, element0)
		XCTAssertTrue(section0.next === section1)

		XCTAssertTrue(section1.previous === section0)
		XCTAssertEqual(section1.element, element1)
		XCTAssertTrue(section1.next === section2)

		XCTAssertTrue(section2.previous === section1)
		XCTAssertEqual(section2.element, element2)
		XCTAssertTrue(section2.next === section3)

		XCTAssertTrue(section3.previous === section2)
		XCTAssertEqual(section3.element, element3)
		XCTAssertNil(section3.next)
	}

	func testSVGString() {
		let path = generateBezierScribble()

		let svg = path.svgString
		XCTAssertEqual("M0.0,7.0 L44.0,7.0 C44.0,7.0 68.0,9.0 66.0,0.0 Q66.0,-7.0 80.0,-7.0 ", svg)
	}

	func testLength() {
		let path = generateBezierScribble()

		let sections = path.sections
		let (section0, section1, section2, section3) = (sections[0], sections[1], sections[2], sections[3])

		XCTAssertEqual(0, section0.length)
		XCTAssertEqual(44, section1.length)
		XCTAssertEqual(25.7317, section2.length, accuracy: 0.00001)
		XCTAssertEqual(17.4204, section3.length, accuracy: 0.00001)

		XCTAssertEqual(87.1521, path.length, accuracy: 0.00001)
	}
}
