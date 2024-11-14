import XCTest
#if DEBUG
@testable import VectorExtor
#else
import VectorExtor
#endif

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

	func testArbitrarySegmentation() throws {
		let expectations = [
			"C2.0,3.0 8.0,3.0 8.0,5.0",
			"C2.0,3.0 8.0,3.0 8.0,5.0",
			"C2.0,4.0 3.5,3.5 5.0,3.5 C6.5,3.5 8.0,4.0 8.0,5.0",
			"C2.0,4.333333333333333 2.6666666666666665,3.888888888888889 3.5555555555555554,3.6666666666666665 C4.444444444444445,3.4444444444444446 5.555555555555555,3.4444444444444446 6.444444444444445,3.666666666666667 C7.333333333333333,3.888888888888889 8.0,4.333333333333333 8.0,5.0",
			"C2.0,4.5 2.375,4.125 2.9375,3.875 C3.5,3.625 4.25,3.5 5.0,3.5 C5.75,3.5 6.5,3.625 7.0625,3.875 C7.625,4.125 8.0,4.5 8.0,5.0",
			"C2.0,4.6 2.24,4.279999999999999 2.624,4.039999999999999 C3.008,3.7999999999999994 3.536,3.6399999999999997 4.112,3.5599999999999996 C4.688,3.48 5.311999999999999,3.48 5.888,3.56 C6.464,3.64 6.992,3.8 7.3759999999999994,4.039999999999999 C7.76,4.279999999999999 8.0,4.6 8.0,5.0",
			"C2.0,4.666666666666667 2.1666666666666665,4.388888888888889 2.444444444444444,4.166666666666667 C2.722222222222222,3.9444444444444446 3.1111111111111107,3.777777777777778 3.5555555555555554,3.666666666666667 C4.0,3.555555555555556 4.5,3.5 5.0,3.5 C5.5,3.5 6.0,3.5555555555555554 6.444444444444445,3.6666666666666665 C6.888888888888889,3.7777777777777777 7.277777777777778,3.944444444444444 7.555555555555555,4.166666666666666 C7.833333333333333,4.388888888888888 8.0,4.666666666666666 8.0,5.0",
			"C2.0,4.714285714285714 2.122448979591837,4.469387755102041 2.3323615160349855,4.26530612244898 C2.542274052478134,4.061224489795919 2.8396501457725947,3.8979591836734695 3.1895043731778427,3.7755102040816326 C3.539358600583091,3.6530612244897958 3.941690962099126,3.571428571428571 4.361516034985423,3.530612244897959 C4.781341107871721,3.4897959183673466 5.21865889212828,3.4897959183673466 5.6384839650145775,3.530612244897959 C6.058309037900875,3.571428571428571 6.46064139941691,3.6530612244897958 6.810495626822158,3.7755102040816326 C7.160349854227405,3.8979591836734695 7.457725947521866,4.061224489795919 7.667638483965015,4.26530612244898 C7.877551020408164,4.469387755102041 8.0,4.7142857142857135 8.0,5.0",
			"C2.0,4.75 2.09375,4.53125 2.2578125,4.34375 C2.421875,4.15625 2.65625,4.0 2.9375,3.875 C3.21875,3.75 3.546875,3.65625 3.8984375,3.59375 C4.25,3.53125 4.625,3.5 5.0,3.5 C5.375,3.5 5.75,3.53125 6.1015625,3.59375 C6.453125,3.65625 6.78125,3.75 7.0625,3.875 C7.34375,4.0 7.578125,4.15625 7.7421875,4.34375 C7.90625,4.53125 8.0,4.75 8.0,5.0",
			"C2.0,4.777777777777778 2.074074074074074,4.580246913580247 2.2057613168724277,4.407407407407407 C2.337448559670782,4.234567901234568 2.526748971193416,4.08641975308642 2.757201646090535,3.9629629629629632 C2.9876543209876543,3.8395061728395063 3.2592592592592595,3.740740740740741 3.555555555555556,3.666666666666667 C3.851851851851852,3.592592592592593 4.17283950617284,3.54320987654321 4.502057613168725,3.5185185185185186 C4.83127572016461,3.493827160493827 5.168724279835392,3.493827160493827 5.4979423868312765,3.5185185185185186 C5.8271604938271615,3.54320987654321 6.148148148148149,3.5925925925925926 6.444444444444445,3.666666666666667 C6.7407407407407405,3.740740740740741 7.012345679012346,3.8395061728395063 7.242798353909465,3.9629629629629632 C7.473251028806584,4.08641975308642 7.662551440329217,4.234567901234568 7.794238683127571,4.407407407407408 C7.925925925925926,4.580246913580248 8.0,4.777777777777779 8.0,5.0",
			"C2.0,4.8 2.06,4.62 2.168,4.46 C2.2760000000000002,4.3 2.4320000000000004,4.16 2.6240000000000006,4.04 C2.8160000000000007,3.92 3.0440000000000005,3.82 3.2960000000000003,3.7399999999999998 C3.5480000000000005,3.6599999999999997 3.8240000000000007,3.5999999999999996 4.112000000000001,3.5599999999999996 C4.400000000000001,3.5199999999999996 4.700000000000001,3.4999999999999996 5.000000000000001,3.4999999999999996 C5.300000000000001,3.4999999999999996 5.6000000000000005,3.5199999999999996 5.888000000000001,3.5599999999999996 C6.176000000000001,3.5999999999999996 6.452000000000001,3.66 6.704000000000001,3.74 C6.956,3.8200000000000003 7.184,3.9200000000000004 7.376,4.04 C7.5680000000000005,4.16 7.724,4.300000000000001 7.832000000000001,4.460000000000001 C7.94,4.620000000000001 8.0,4.800000000000001 8.0,5.0",
		]

		let curve = generateSimpleCurve()
		let lastSeg = curve.segments.last!

		for (index, expectation) in expectations.enumerated() {
			let parts = lastSeg.split(intoSegments: index)
			let svg = parts.map(\.svgString).joined(separator: " ")
			if index > 0 {
				XCTAssertEqual(parts.count, index)
			}
			XCTAssertEqual(svg, expectation)
		}
	}

	func generateSimpleCurve() -> CGPath {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 2, y: 5))
		path.addCurve(to: CGPoint(x: 8, y: 5), control1: CGPoint(x: 2, y: 3), control2: CGPoint(x: 8, y: 3))
		return path
	}

	func generateSimpleCurve2() -> CGPath {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 2, y: 5))
		path.addCurve(to: CGPoint(x: 8, y: 5), control1: CGPoint(x: 0, y: 4), control2: CGPoint(x: 10, y: 4))
		return path
	}

	// effectively equal to simple curve 1
	func generateSimplePath() -> CGPath {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 2, y: 5))
		path.addCurve(to: CGPoint(x: 5, y: 3.5), control1: CGPoint(x: 2, y: 4), control2: CGPoint(x: 3.5, y: 3.5))
		path.addCurve(to: CGPoint(x: 8, y: 5), control1: CGPoint(x: 6.5, y: 3.5), control2: CGPoint(x: 8, y: 4))
		return path
	}

	#if DEBUG
	@available(*, deprecated)
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
	#endif

	func testSVGString() {
		let path = generateBezierScribble()

		let svg = path.svgString
		XCTAssertEqual("M0.0,7.0 L44.0,7.0 C44.0,7.0 68.0,9.0 66.0,0.0 Q66.0,-7.0 80.0,-7.0", svg)
	}

	func testLength() {
		let path = generateBezierScribble()

		let sections = path.segments
		let (section0, section1, section2, section3) = (sections[0], sections[1], sections[2], sections[3])

		XCTAssertEqual(0, section0.length)
		XCTAssertEqual(44, section1.length)
		XCTAssertEqual(25.74223, section2.length, accuracy: 0.00001)
		XCTAssertEqual(17.43425, section3.length, accuracy: 0.00001)

		XCTAssertEqual(87.1765, path.length, accuracy: 0.00001)
	}

	func testPointAlongCurve() {
		let path = generateSimpleCurve()
		let segment = path.segments.last!

		var result = segment.percentAlongCurve(0.25)!
		var expected = CGPoint(x: 3.19161604, y: 3.774775)
		XCTAssertEqual(expected.x, result.x, accuracy: 0.0001)
		XCTAssertEqual(expected.y, result.y, accuracy: 0.0001)
		result = segment.pointAlongCurve(t: 0.25)
		expected = CGPoint(x: 2.9375, y: 3.875)
		XCTAssertEqual(expected.x, result.x, accuracy: 0.0001)
		XCTAssertEqual(expected.y, result.y, accuracy: 0.0001)

		result = segment.pointAlongCurve(t: 0.0)
		expected = CGPoint(x: 2, y: 5)
		XCTAssertEqual(expected.x, result.x, accuracy: 0.0001)
		XCTAssertEqual(expected.y, result.y, accuracy: 0.0001)
		result = segment.pointAlongCurve(t: 1.0)
		expected = CGPoint(x: 8, y: 5)
		XCTAssertEqual(expected.x, result.x, accuracy: 0.0001)
		XCTAssertEqual(expected.y, result.y, accuracy: 0.0001)

		let path2 = generateSimpleCurve2()
		let segment2 = path2.segments.last!

		result = segment2.percentAlongCurve(0.25)!
		expected = CGPoint(x: 3.107779, y: 4.333667)
		XCTAssertEqual(expected.x, result.x, accuracy: 0.0001)
		XCTAssertEqual(expected.y, result.y, accuracy: 0.0001)
		result = segment2.pointAlongCurve(t: 0.25)
		expected = CGPoint(x: 2.375, y: 4.4375)
		XCTAssertEqual(expected.x, result.x, accuracy: 0.0001)
		XCTAssertEqual(expected.y, result.y, accuracy: 0.0001)

		// confirmed all these points through manual entry in affinity designer
		let length = segment.length
		XCTAssertEqual(7.34655, length, accuracy: 0.00001)
		let percentagePoints = stride(from: CGFloat(0.0), through: 1.0, by: 0.1).compactMap { segment.percentAlongCurve($0) }
		let expectedPoints: [(CGPoint, UInt)] = [
			(CGPoint(x: 2.0, y: 5.0), #line),
			(CGPoint(x: 2.2657412053662127, y: 4.335223675671046), #line),
			(CGPoint(x: 2.8580442469607505, y: 3.9119229270450613), #line),
			(CGPoint(x: 3.536922, y: 3.6687185210449913), #line),
			(CGPoint(x: 4.268764756393066, y: 3.5404283340746803), #line),
			(CGPoint(x: 5.000000000000001, y: 3.5), #line),
			(CGPoint(x: 5.731235243606936, y: 3.5404283340746803), #line),
			(CGPoint(x: 6.452082591602235, y: 3.6687185210449926), #line),
			(CGPoint(x: 7.141955753039252, y: 3.911922927045062), #line),
			(CGPoint(x: 7.734258794633789, y: 4.335223675671047), #line),
			(CGPoint(x: 8.0, y: 5.0), #line),
		]
		for (result, expected) in zip(percentagePoints, expectedPoints) {
			XCTAssertEqual(expected.0.x, result.x, accuracy: 0.01, line: expected.1)
			XCTAssertEqual(expected.0.y, result.y, accuracy: 0.01, line: expected.1)
		}

		let tPoints = stride(from: CGFloat(0.0), through: 1.0, by: 0.1).compactMap { segment.pointAlongCurve(t: $0) }
		let expectedtPoints: [(CGPoint, UInt)] = [
			(CGPoint(x: 2.0, y: 5.0), #line),
			(CGPoint(x: 2.168, y: 4.460000000000001), #line),
			(CGPoint(x: 2.6240000000000006, y: 4.040000000000001), #line),
			(CGPoint(x: 3.2960000000000003, y: 3.7399999999999998), #line),
			(CGPoint(x: 4.112000000000001, y: 3.5600000000000005), #line),
			(CGPoint(x: 5.0, y: 3.5), #line),
			(CGPoint(x: 5.888000000000001, y: 3.56), #line),
			(CGPoint(x: 6.704000000000001, y: 3.7399999999999998), #line),
			(CGPoint(x: 7.376000000000001, y: 4.04), #line),
			(CGPoint(x: 7.832000000000001, y: 4.46), #line),
			(CGPoint(x: 8.0, y: 5.0), #line),
		]
		for (result, expected) in zip(tPoints, expectedtPoints) {
			XCTAssertEqual(expected.0.x, result.x, accuracy: 0.01, line: expected.1)
			XCTAssertEqual(expected.0.y, result.y, accuracy: 0.01, line: expected.1)
		}
	}

	func testPointAlongPath() {
		let path = generateSimplePath()

		let length = path.length
		XCTAssertEqual(7.3275697425434085, length, accuracy: 0.00001)
		let percentagePoints = stride(from: CGFloat(0.0), through: 1.0, by: 0.1).compactMap { path.pointAlongPath(atPercent: $0, precalculatedLength: length) }
		let expectedPoints = [
			CGPoint(x: 2.0, y: 5.0),
			CGPoint(x: 2.265544902523698, y: 4.335119181391632),
			CGPoint(x: 2.857953127107415, y: 3.911861477399667),
			CGPoint(x: 3.5478578546712503, y: 3.668644905707304),
			CGPoint(x: 4.268736823956322, y: 3.540368395330985),
			CGPoint(x: 5.000000000000001, y: 3.5),
			CGPoint(x: 5.7312631760436785, y: 3.540368395330985),
			CGPoint(x: 6.452142145328748, y: 3.668644905707303),
			CGPoint(x: 7.142046872892585, y: 3.911861477399666),
			CGPoint(x: 7.734455097476303, y: 4.335119181391634),
			CGPoint(x: 8.0, y: 5.0)
		]
		XCTAssertEqual(expectedPoints, percentagePoints)
	}

	// this is just a scratchpad - not meant as a real test
	func testDeallocate() throws {
		class Classy {}
		typealias Gen<T: AnyObject> = () -> T
		let sem = DispatchSemaphore(value: 0)

		func a<T: AnyObject>(_ gen: Gen<T>) {
			let foo = gen()
			print("immediate: \(foo)")
			DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak foo] in
				print("delayed: \(foo as Any)")
				XCTAssertNil(foo)
				sem.signal()
			}
		}

		a({
			let t = generateSimplePath()
			let sections = t.sections.first!
			return sections
		})
		sem.wait()
	}
}
