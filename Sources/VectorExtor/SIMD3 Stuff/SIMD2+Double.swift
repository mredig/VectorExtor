import Foundation
import simd

public extension SIMD2 where Scalar == Double {
	// MARK: - Distance Convenience
	func distance(to other: Self) -> Scalar {
		simd.distance(self, other)
	}

	func distanceFast(to other: Self) -> Scalar {
		simd_fast_distance(self, other)
	}

	func distancePrecise(to other: Self) -> Scalar {
		simd_precise_distance(self, other)
	}

	func distanceSquared(to other: Self) -> Scalar {
		simd.distance_squared(self, other)
	}

	func distance(to other: Self, isWithin value: Scalar) -> Bool {
		distanceSquared(to: other) <= value * value
	}

	/// Since float values are sloppy, it's highly likely two values that can be considered equal will not be EXACTLY equal. Adjust the `slop` to your liking or set to `0` to disable.
	func distance(to other: Self, is value: Scalar, slop: Scalar = 0.000001) -> Bool {
		let distanceIsh = distanceSquared(to: other)
		let valueIsh = value * value
		return abs(valueIsh - distanceIsh) <= slop
	}

	// MARK: - Length Convenience
	var length: Scalar {
		simd.length(self)
	}

	var lengthFast: Scalar {
		simd_fast_length(self)
	}

	var lengthPrecise: Scalar {
		simd_precise_length(self)
	}

	var lengthSquared: Scalar {
		simd_length_squared(self)
	}

	func lengthIsWithin(_ value: Scalar) -> Bool {
		lengthSquared <= value * value
	}

	/// Since float values are sloppy, it's highly likely two values that can be considered equal will not be EXACTLY equal. Adjust the `slop` to your liking or set to `0` to disable.
	func lengthIs(_ value: Scalar, slop: Scalar = 0.000001) -> Bool {
		let lengthIsh = lengthSquared
		let valueIsh = value * value
		return abs(valueIsh - lengthIsh) <= slop
	}

	// MARK: - Vectorization
	func vector(facing other: Self, normalized: Bool = true) -> Self {
		let direction = inverted + other
		return normalized ? direction.normalizedFast : direction
	}

	// MARK: - Normalization Convenience
	var normalized: Self {
		simd_normalize(self)
	}

	mutating func normalize() {
		self = normalized
	}

	var normalizedFast: Self {
		simd_fast_normalize(self)
	}

	mutating func normalizeFast() {
		self = normalizedFast
	}

	var normalizedPrecise: Self {
		simd_precise_normalize(self)
	}

	mutating func normalizePrecise() {
		self = normalizedPrecise
	}

	// MARK: - linear interpolation convenience
	mutating func mix(with other: Self, at location: Scalar, clipped: Bool = true) {
		let location = clipped ? Swift.max(0, Swift.min(1, location)) : location
		self = simd.mix(self, other, t: location)
	}

	func mixed(with other: Self, at location: Scalar, clipped: Bool = true) -> Self {
		var new = self
		new.mix(with: other, at: location, clipped: clipped)
		return new
	}

	// MARK: - common math conveniences
	@available(macOS 12.0, iOS 15.0, tvOS 15.0, *)
	var cubeRoot: Self {
		simd.cbrt(self)
	}

	var ceil: Self {
		simd.ceil(self)
	}

	var floor: Self {
		simd.floor(self)
	}

	@available(macOS 12.0, iOS 15.0, tvOS 15.0, *)
	var rounded: Self {
		simd.round(self)
	}

	var inverted: Self {
		var new = self
		new *= -1
		return new
	}

	func clamped(to range: ClosedRange<Scalar>) -> Self {
		simd.clamp(self, min: range.lowerBound, max: range.upperBound)
	}
}
