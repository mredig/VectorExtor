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

	// MARK: - Normalization Convenience
	var normalized: Self {
		simd_normalize(self)
	}

	var normalizedFast: Self {
		simd_fast_normalize(self)
	}

	var normalizedPrecise: Self {
		simd_precise_normalize(self)
	}
}
