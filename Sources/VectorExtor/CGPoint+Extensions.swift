import Foundation
import simd
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension CGPoint {
	// MARK: - Point Initialization
	init<IntNumber: BinaryInteger>(scalar: IntNumber) {
		let value = CGFloat(scalar)
		self.init(x: value, y: value)
	}

	init<FloatNumber: BinaryFloatingPoint>(scalar: FloatNumber) {
		let value = CGFloat(scalar)
		self.init(x: value, y: value)
	}

	// MARK: - Point Distance
	/// calculate the distance between points
	func distance(to point: CGPoint) -> Double {
		simd.distance(to: point.simd)
	}

	/// Determine if the distance between points is less than or equal to a comparison value. Quicker than actually calculating the distance
	func distance(to point: CGPoint, isWithin value: Double) -> Bool {
		simd.distance(to: point.simd, isWithin: value)
	}

	/// Since float values are sloppy, it's highly likely two values that can be considered equal will not be EXACTLY equal. Adjust the `slop` to your liking or set to `0` to disable.
	func distance(to point: CGPoint, is value: Double, slop: Double = 0.000001) -> Bool {
		simd.distance(to: point.simd, is: value, slop: slop)
	}

	// MARK: - Point Stepping
	/**
	returns a point in the direction of the `toward` CGPoint, iterated at a speed of `speed` points per second. `interval`
	is the duration of time since the last frame was updated
	*/
	func stepped(toward destination: CGPoint, interval: TimeInterval, speed: Double) -> CGPoint {
		let adjustedSpeed = speed * interval
		let vectorBetweenPoints = vector(facing: destination)

		if distance(to: destination, isWithin: adjustedSpeed) {
			return destination
		}

		return self.stepped(withNormalizedVector: vectorBetweenPoints, interval: interval, speed: speed)
	}

	/// See `stepped` variation, just mutates self with the result
	mutating func step(toward destination: CGPoint, interval: TimeInterval, speed: CGFloat) {
		self = stepped(toward: destination, interval: interval, speed: speed)
	}

	/// Steps in the direction of the vector at a rate of `speed` distance points per second. Assumes the vector is
	/// normalized - does NOT check - it is YOUR responsibility to assure that the vector is normal!
	func stepped(withNormalizedVector vector: CGVector, interval: TimeInterval, speed: CGFloat) -> CGPoint {
		let adjustedVector = vector * speed
		return self.stepped(withVector: adjustedVector, interval: interval)
	}

	/// See `stepped` variation, just mutates self with the result
	mutating func step(withNormalizedVector vector: CGVector, interval: TimeInterval, speed: CGFloat) {
		self = stepped(withNormalizedVector: vector, interval: interval, speed: speed)
	}

	/// The vector is the rate the point will step per second. This function assumes the speed is baked into the vector.
	func stepped(withVector vector: CGVector, interval: TimeInterval) -> CGPoint {
		var new = self
		new.step(withVector: vector, interval: interval)
		return new
	}

	/// See `stepped` variation, just mutates self with the result
	mutating func step(withVector vector: CGVector, interval: TimeInterval) {
		let adjustedVector = vector.simd * interval
		self.simd += adjustedVector
	}

	// MARK: - Point Facing
	/// Generates a vector in the direction of `facing`, optionally (default) normalized.
	func vector(facing point: CGPoint, normalized normalize: Bool = true) -> CGVector {
		var vec = vector
		vec.simd = vec.simd.vector(facing: point.simd, normalized: normalize)
		return vec
	}


	/// Determines whether the CGPoint instance is behind the passed in CGPoint,
	/// `point2`. `facing` is the `direction` that `point2` is facing.
	/// `latitude` determines angle of cone 'behind' `point2`. `1` means
	/// everything is behind `point2`, `0` means everything directly beside and
	/// behind, while `-1` means NOTHING is behind.
	func isBehind(point2: CGPoint, facing direction: CGVector, withLatitude latitude: CGFloat) -> Bool {
		let facingSelf = point2.simd.vector(facing: self.simd, normalized: true)
		let normalDirection = direction.simd.normalized

		let dotProduct = dot(facingSelf, normalDirection)

		return dotProduct < latitude
	}

	/// Determines whether the CGPoint instance is in front of the passed in CGPoint,
	/// `point2`. `facing` is the `direction` that `point2` is facing.
	/// `latitude` determines angle of cone 'in front of' `point2`. `1` means
	/// everything is in front of `point2`, `0` means everything directly beside and
	/// behind, while `-1` means NOTHING is in front.
	func isInFront(of point2: CGPoint, facing direction: CGVector, withLatitude latitude: CGFloat) -> Bool {
		let facingSelf = point2.simd.vector(facing: self.simd, normalized: true)
		let normalDirection = direction.simd.normalized

		let dotProduct = dot(facingSelf, normalDirection)

		return dotProduct > -latitude
	}

	// MARK: - Linear Interpolation
	@available(*, deprecated, renamed: "interpolation(to:tValue:clamped:)", message: "Use variant with `clamped` instead")
	func interpolation(to point: CGPoint, location: Double, clipped: Bool = true) -> CGPoint {
		interpolation(to: point, tValue: location, clamped: clipped)
	}

	func interpolation(to point: CGPoint, tValue: Double, clamped: Bool = true) -> CGPoint {
		var new = self
		new.simd.mix(with: point.simd, at: tValue, clamped: clamped)
		return new
	}
}

extension CGPoint: @retroactive Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(x)
		hasher.combine(y)
	}
}
