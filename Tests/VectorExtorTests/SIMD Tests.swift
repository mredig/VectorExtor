import XCTest
import VectorExtor
import Accelerate
import simd

class SIMDTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testDistance() {
		let a = SIMD3(96.15, 45.65, 67.89)
		let b = SIMD3(21.30, 86.49, 32.19)

		XCTAssertEqual(a.distance(to: b), 92.438726, accuracy: 0.00001)
		XCTAssertEqual(b.distance(to: a), 92.438726, accuracy: 0.00001)

		XCTAssertEqual(a.distanceFast(to: b), 92.438726, accuracy: 0.00001)
		XCTAssertEqual(a.distancePrecise(to: b), 92.43872619200245)

		XCTAssertEqual(a.distanceSquared(to: b), 8544.9181, accuracy: 0.00001)

		XCTAssertTrue(a.distance(to: b, isWithin: 92.438727))
		XCTAssertTrue(a.distance(to: b, isWithin: 93))
		XCTAssertFalse(a.distance(to: b, isWithin: 91))

		XCTAssertTrue(a.distance(to: b, is: 92.438726, slop: 0.0001))
		XCTAssertFalse(a.distance(to: b, is: 92.438726, slop: 0.00001))

		XCTAssertFalse(a.distance(to: b, is: 100))
		XCTAssertFalse(a.distance(to: b, is: 90))
	}

	func testLength() {
		let a = SIMD3(96.15, 45.65, 67.89)
		let b = SIMD3(21.30, 86.49, 32.19)
		
		XCTAssertEqual(a.length, 126.244988, accuracy: 0.00001)
		XCTAssertEqual(a.lengthFast, 126.244988, accuracy: 0.00001)
		XCTAssertEqual(a.lengthPrecise, 126.24498841538225)

		XCTAssertEqual(b.length, 94.712228, accuracy: 0.00001)
		XCTAssertEqual(b.lengthFast, 94.712228, accuracy: 0.00001)
		XCTAssertEqual(b.lengthPrecise, 94.71222835516012)

		XCTAssertTrue(a.lengthIsWithin(126.244989))
		XCTAssertFalse(a.lengthIsWithin(126.244987))

		XCTAssertTrue(a.lengthIs(126.24498841538225))
		XCTAssertTrue(a.lengthIs(126.244988, slop: 0.001))
	}

	func testNormalization() {
		let a = SIMD3(24.35, 78.90, 82.31)

		let aNormal = SIMD3(0.20885275632623104, 0.6767343931884858, 0.7059823561894076)

		XCTAssertEqual(a.normalized, aNormal)
		XCTAssertEqual(a.normalizedFast, aNormal)
		XCTAssertEqual(a.normalizedPrecise, aNormal)

		var comparee = a
		comparee.normalize()
		XCTAssertEqual(a.normalized, comparee)
		comparee = a
		comparee.normalizeFast()
		XCTAssertEqual(a.normalizedFast, comparee)
		comparee = a
		comparee.normalizePrecise()
		XCTAssertEqual(a.normalizedPrecise, comparee)
	}

	func testLerp() {
		let a = SIMD3(10, 68, 26.0)
		let b = SIMD3(56, 37, 98.0)

		let quarterway = SIMD3(21.5, 60.25, 44.0)
		let halfway = SIMD3(33.0, 52.5, 62.0)
		let threeQuarterway = SIMD3(44.5, 44.75, 80.0)

		XCTAssertEqual(a.distance(to: halfway), b.distance(to: halfway))
		XCTAssertEqual(a.mixed(with: b, at: 0.5), halfway)

		XCTAssertEqual(a.mixed(with: b, at: 0.25), quarterway)
		XCTAssertEqual(a.mixed(with: b, at: 0.75), threeQuarterway)
		XCTAssertEqual(a.distance(to: quarterway), b.distance(to: threeQuarterway))
	}

	func testMathStuff() {
		let x = SIMD3(21.5, 60.25, 44.0)
		let y = SIMD3(44.5, 44.75, 80.0)

		XCTAssertEqual(x.cubeRoot, SIMD3(2.7806488832606178, 3.9202974229418146, 3.530348335326063))
		XCTAssertEqual(y.cubeRoot, SIMD3(3.5436705307503775, 3.5502942293987707, 4.308869380063768))

		XCTAssertEqual(x.ceil, SIMD3(22, 61, 44))
		XCTAssertEqual(y.ceil, SIMD3(45, 45, 80))

		XCTAssertEqual(x.floor, SIMD3(21, 60, 44))
		XCTAssertEqual(y.floor, SIMD3(44, 44, 80))

		XCTAssertEqual(x.rounded, SIMD3(22, 60, 44))
		XCTAssertEqual(y.rounded, SIMD3(45, 45, 80))
	}
}
