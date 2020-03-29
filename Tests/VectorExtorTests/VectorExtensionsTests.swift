
import XCTest
@testable import VectorExtor

class VectorExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCGPointUtilities() {
		let pointA = CGPoint(x: 5, y: 7)
		let pointB = CGPoint(x: 2.5, y: 5)

		let distance = CGPoint.zero.distance(to: pointA)
		XCTAssertEqual(distance, 8.6023252670, accuracy: 0.00001)

		// greater
		XCTAssertTrue(CGPoint.zero.distance(to: pointA, isWithin: 9))
		// exact
		XCTAssertTrue(CGPoint.zero.distance(to: pointA, isWithin: 8.602325267042627))
		// less
		XCTAssertFalse(CGPoint.zero.distance(to: pointA, isWithin: 8))

		// with slop
		XCTAssertTrue(CGPoint.zero.distance(to: pointA, is: 8.6023252670))
		// with slop
		XCTAssertFalse(CGPoint.zero.distance(to: pointA, is: 9))
		// without slop
		XCTAssertFalse(CGPoint.zero.distance(to: pointA, is: 8.6023252670, slop: 0))
		// without slop
		XCTAssertTrue(CGPoint.zero.distance(to: pointA, is: 8.602325267042627, slop: 0))

		let toSize = pointA.size
		XCTAssertEqual(toSize, CGSize(width: 5, height: 7))

		let scalar3 = CGPoint(scalar: 3)
		let scalar35 = CGPoint(scalar: 3.5)

		XCTAssertEqual(scalar3, CGPoint(x: 3, y: 3))
		XCTAssertEqual(scalar35, CGPoint(x: 3.5, y: 3.5))
	}

	func testCGPointOperands() {
		let pointA = CGPoint(x: 5, y: 7)
		let pointB = CGPoint(x: 2.5, y: 5)
		let pointC = CGPoint(x: -3, y: -2)

		let randomVector = CGVector(dx: 2, dy: 10)

		let pointAB = pointA + pointB
		XCTAssertEqual(pointAB, CGPoint(x: 7.5, y: 12))

		let pointVec = pointA + randomVector
		XCTAssertEqual(pointVec, CGPoint(x: 7, y: 17))

		let sub1 = pointA - pointB
		XCTAssertEqual(sub1, CGPoint(x: 2.5, y: 2))
		let sub2 = pointA - pointC
		XCTAssertEqual(sub2, CGPoint(x: 8, y: 9))

		let sub3 = pointA - randomVector
		XCTAssertEqual(sub3, CGPoint(x: 3, y: -3))

		let pointD = pointA * pointB
		XCTAssertEqual(pointD, CGPoint(x: 12.5, y: 35))

		let pointA2 = pointA * 2
		XCTAssertEqual(pointA2, CGPoint(x: 10, y: 14))
	}

	func testCGPointInterpolation() {
		let pointA = CGPoint.zero
		let pointB = CGPoint(x: -100, y: 50)
		let pointC = CGPoint(x: 20, y: 1)

		XCTAssertEqual(pointA.interpolation(to: pointC, location: 0.5), CGPoint(x: 10, y: 0.5))
		XCTAssertEqual(pointA.interpolation(to: pointC, location: 1), CGPoint(x: 20, y: 1))
		XCTAssertEqual(pointA.interpolation(to: pointC, location: 0), CGPoint(x: 0, y: 0))
		XCTAssertEqual(pointA.interpolation(to: pointC, location: -1), CGPoint(x: 0, y: 0))
		XCTAssertEqual(pointA.interpolation(to: pointC, location: 2), CGPoint(x: 20, y: 1))
		XCTAssertEqual(pointA.interpolation(to: pointC, location: 2, clipped: false), CGPoint(x: 40, y: 2))
		XCTAssertEqual(pointA.interpolation(to: pointC, location: -1, clipped: false), CGPoint(x: -20, y: -1))

		XCTAssertEqual(pointB.interpolation(to: pointC, location: 0.5), CGPoint(x: -40, y: 25.5))
		XCTAssertEqual(pointB.interpolation(to: pointC, location: 0), CGPoint(x: -100, y: 50))
		XCTAssertEqual(pointB.interpolation(to: pointC, location: 1), CGPoint(x: 20, y: 1))
		XCTAssertEqual(pointC.interpolation(to: pointB, location: 0), CGPoint(x: 20, y: 1))
		XCTAssertEqual(pointC.interpolation(to: pointB, location: 1), CGPoint(x: -100, y: 50))
	}

	func testCGPointBehindAndFront() {
		let attacker = CGPoint(x: 5, y: 10)
		let victim = CGPoint(x: 6, y: 11)

		let vicFacingAway = victim.vector(facing: CGPoint(x: 7, y: 12))
		let vicFacingTowardAttacker = victim.vector(facing: attacker)
		let vicFacingLeft = victim.vector(facing: CGPoint(x: 5, y: 12))

		let attackerFacingAway = attacker.vector(facing: CGPoint(x: 4, y: 9))
		let attackerFacingLeft = attacker.vector(facing: CGPoint(x: 4, y: 11))
		let attackerTowardVictim = attacker.vector(facing: victim)

		// victim facing directly away
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingAway, withLatitude: 0))
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingAway, withLatitude: 0.5))
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingAway, withLatitude: 1))
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingAway, withLatitude: -0.5))
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingAway, withLatitude: -1))
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingAway, withLatitude: -0.99))

		// attacker facing directly at vic
		XCTAssertTrue(victim.isInFront(of: attacker, facing: attackerTowardVictim, withLatitude: 0))
		XCTAssertTrue(victim.isInFront(of: attacker, facing: attackerTowardVictim, withLatitude: 0.5))
		XCTAssertTrue(victim.isInFront(of: attacker, facing: attackerTowardVictim, withLatitude: 1))
		XCTAssertTrue(victim.isInFront(of: attacker, facing: attackerTowardVictim, withLatitude: -0.5))
		XCTAssertFalse(victim.isInFront(of: attacker, facing: attackerTowardVictim, withLatitude: -1))
		XCTAssertTrue(victim.isInFront(of: attacker, facing: attackerTowardVictim, withLatitude: -0.99))

		// victim facing directly at attacker
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingTowardAttacker, withLatitude: 0))
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingTowardAttacker, withLatitude: 0.5))
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingTowardAttacker, withLatitude: -0.5))
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingTowardAttacker, withLatitude: 1.00001))
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingTowardAttacker, withLatitude: 1))
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingTowardAttacker, withLatitude: 0.99))

		// attacker facing directly away from vic
		XCTAssertFalse(victim.isInFront(of: attacker, facing: attackerFacingAway, withLatitude: 0))
		XCTAssertFalse(victim.isInFront(of: attacker, facing: attackerFacingAway, withLatitude: 0.5))
		XCTAssertFalse(victim.isInFront(of: attacker, facing: attackerFacingAway, withLatitude: -0.5))

		// victim facing to the left
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingLeft, withLatitude: 0))
		XCTAssertTrue(attacker.isBehind(point2: victim, facing: vicFacingLeft, withLatitude: 0.5))
		XCTAssertFalse(attacker.isBehind(point2: victim, facing: vicFacingLeft, withLatitude: -0.5))

		// attacker facing to the left
		XCTAssertFalse(victim.isInFront(of: attacker, facing: attackerFacingLeft, withLatitude: 0))
		XCTAssertTrue(victim.isInFront(of: attacker, facing: attackerFacingLeft, withLatitude: 0.5))
		XCTAssertFalse(victim.isInFront(of: attacker, facing: attackerFacingLeft, withLatitude: -0.5))

	}

	func testCGPointHashing() {
		let point0 = CGPoint.zero
		let point1 = CGPoint(x: 1, y: 0)
		let point2 = CGPoint(x: 0, y: 1)

		let hash0 = point0.hashValue
		let hash1 = point1.hashValue
		let hash2 = point2.hashValue

		XCTAssertNotEqual(hash0, hash1)
		XCTAssertNotEqual(hash0, hash2)
		XCTAssertNotEqual(hash1, hash2)
	}

	func testCGPointTowardStepping() {
		let pointA = CGPoint.zero
		let pointB = CGPoint(x: 0, y: 100)
		let pointC = CGPoint(x: 100, y: -100)
		let pointD = CGPoint(x: 1, y: 0)

		// tests that time intervals work
		var mutPoint = pointA
		let iterations: TimeInterval = 60
		for _ in 0..<Int(iterations) {
			mutPoint = mutPoint.stepped(toward: pointB, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 0, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, 1, accuracy: 0.00001)

		// tests that time intervals work v2
		mutPoint = pointA
		for _ in 0..<Int(iterations) {
			mutPoint = mutPoint.stepped(toward: pointB, interval: 1/iterations, speed: 50)
		}
		XCTAssertEqual(mutPoint.x, 0, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, 50, accuracy: 0.00001)

		// tests going to a different quadrant
		mutPoint = pointA
		for _ in 0..<Int(iterations) {
			mutPoint = mutPoint.stepped(toward: pointC, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 0.7071067, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, -0.7071067, accuracy: 0.00001)

		// should land exactly on destination
		mutPoint = pointA
		for _ in 0..<Int(iterations) {
			mutPoint.step(toward: pointD, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 1, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, 0, accuracy: 0.00001)

		// makes to destination halfway through. shouldn't keep going
		mutPoint = pointA
		for _ in 0..<Int(iterations * 2) {
			mutPoint.step(toward: pointD, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 1, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, 0, accuracy: 0.00001)

		// doesn't make to destination
		mutPoint = pointA
		for _ in 0..<Int(iterations/2) {
			mutPoint.step(toward: pointD, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 0.5, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, 0, accuracy: 0.00001)
	}

	func testCGPointVectorStepping() {
		let pointA = CGPoint.zero
		let pointB = CGPoint(x: 0, y: 100)
		let pointC = CGPoint(x: 100, y: -100)

		// tests that vectors move toward the right direction
		var mutPoint = pointA
		let vector1 = pointA.vector(facing: pointB)
		let iterations: TimeInterval = 60
		for _ in 0..<Int(iterations) {
			mutPoint = mutPoint.stepped(withNormalizedVector: vector1, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 0, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, 1, accuracy: 0.00001)

		// tests that vectors move toward the right direction at the expected rate
		mutPoint = pointA
		let vector2 = pointA.vector(facing: pointC)
		for _ in 0..<Int(iterations) {
			mutPoint.step(withNormalizedVector: vector2, interval: 1/iterations, speed: 1)
		}
		XCTAssertEqual(mutPoint.x, 0.7071067, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, -0.7071067, accuracy: 0.00001)

		// tests that vectors move toward the right direction  at the rate of the vector itself
		mutPoint = pointA
		let vector3 = pointA.vector(facing: pointB, normalized: false)
		for _ in 0..<Int(iterations) {
			mutPoint = mutPoint.stepped(withVector: vector3, interval: 1/iterations)
		}
		XCTAssertEqual(mutPoint.x, pointB.x, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, pointB.y, accuracy: 0.00001)

		// tests that vectors move toward the right direction  at the rate of the vector itself v2
		mutPoint = pointA
		let vector4 = pointA.vector(facing: pointC, normalized: false)
		for _ in 0..<Int(iterations) {
			mutPoint.step(withVector: vector4, interval: 1/iterations)
		}
		XCTAssertEqual(mutPoint.x, pointC.x, accuracy: 0.00001)
		XCTAssertEqual(mutPoint.y, pointC.y, accuracy: 0.00001)

	}

	func testCGPointVectorStuff() {
		let pointA = CGPoint.zero
		let pointB = CGPoint(x: 0, y: 100)
		let pointC = CGPoint(x: 100, y: -100)

		// confirms the vector is correct
		let facing1 = pointA.vector(facing: pointB)
		let facing2 = pointA.vector(facing: pointB, normalized: false)
		XCTAssertEqual(facing1.dx, 0, accuracy: 0.00001)
		XCTAssertEqual(facing1.dy, 1, accuracy: 0.00001)
		XCTAssertEqual(facing2.dx, 0, accuracy: 0.00001)
		XCTAssertEqual(facing2.dy, 100, accuracy: 0.00001)

		// confirms the vector is correct
		let facing3 = pointA.vector(facing: pointC)
		let facing4 = pointA.vector(facing: pointC, normalized: false)
		XCTAssertEqual(facing3.dx, 0.7071067, accuracy: 0.00001)
		XCTAssertEqual(facing3.dy, -0.7071067, accuracy: 0.00001)
		XCTAssertEqual(facing4.dx, 100, accuracy: 0.00001)
		XCTAssertEqual(facing4.dy, -100, accuracy: 0.00001)

		let toVector = pointC.vector
		XCTAssertEqual(toVector, CGVector(dx: 100, dy: -100))
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

	func testRectUtilities() {
		let size = CGSize(width: 10, height: 50)
		let rect = CGRect(origin: .zero, size: size)
		XCTAssertEqual(rect.maxXY, size.point)

		XCTAssertEqual(rect.midPoint, CGPoint(x: 5, y: 25))

		let orig2 = CGPoint(x: 10, y: -10)
		let rect2 = CGRect(origin: orig2, size: size)
		XCTAssertEqual(rect2.maxXY, (size + orig2.size).point)

		XCTAssertEqual(rect2.midPoint, CGPoint(x: 15, y: 15))

		let scalar = CGRect(scalarOrigin: 3.5, scalarSize: 4.5)
		XCTAssertEqual(scalar, CGRect(x: 3.5, y: 3.5, width: 4.5, height: 4.5))
	}

	func testDoubleAndCGFloat() {
		let valueCG: CGFloat = 12.34
		let valueDouble = 12.34

		XCTAssertEqual(valueCG.double, valueDouble)
		XCTAssertEqual(valueDouble.cgFloat, valueCG)
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

	func testCGAffineTransform() {
		let transform = CGAffineTransform(translationX: 10, y: 20)
		XCTAssertEqual(transform.offset, CGPoint(x: 10, y: 20))
	}

	func testRangeInterpolation() {
		let rangeA = 0...100.0

		XCTAssertEqual(rangeA.interpolated(at: 0.5), 50, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 0.25), 25, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: -1), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: -1, clipped: false), -100, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 0.9), 90, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 1.9), 100, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.interpolated(at: 1.9, clipped: false), 190, accuracy: 0.000000001)

		let rangeB = -20.0...20
		XCTAssertEqual(rangeB.interpolated(at: 0), -20, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 0.5), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 1), 20, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 2), 20, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.interpolated(at: 2, clipped: false), 60, accuracy: 0.000000001)

		let rangeC = -10...20.0
		XCTAssertEqual(rangeC.interpolated(at: 0.5), 5, accuracy: 0.000000001)
		XCTAssertEqual(rangeC.interpolated(at: -1), -10, accuracy: 0.000000001)
		XCTAssertEqual(rangeC.interpolated(at: -1, clipped: false), -40, accuracy: 0.000000001)
	}

	func testRangeLinearPoint() {
		let rangeA = 0...100.0
		let rangeB = 20...40.0

		XCTAssertEqual(rangeA.linearPoint(of: 50), 0.5, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.linearPoint(of: 25), 0.25, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.linearPoint(of: -10), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeA.linearPoint(of: -10, clipped: false), -0.1, accuracy: 0.000000001)

		XCTAssertEqual(rangeB.linearPoint(of: 20), 0, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 30), 0.5, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 40), 1, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 45), 1, accuracy: 0.000000001)
		XCTAssertEqual(rangeB.linearPoint(of: 45, clipped: false), 1.25, accuracy: 0.000000001)

	}
}
