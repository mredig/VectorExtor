internal extension BinaryFloatingPoint {
	@inline(__always)
	func _isRoughlyEqual(to other: Self, usingThreshold threshold: Self) -> Bool {
		let diff = abs(self - other)
		return diff <= threshold
	}
}
