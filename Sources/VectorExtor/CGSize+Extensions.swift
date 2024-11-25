import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension CGSize {
	@inline(__always)
	var midPoint: CGPoint {
		normalPointToAbsolute(normalPoint: CGPoint(scalar: 0.5))
	}

	@inline(__always)
	var min: CGFloat { Swift.min(width, height) }
	@inline(__always)
	var max: CGFloat { Swift.max(width, height) }

	@inline(__always)
	var aspectRatio: CGFloat {
		guard height != 0 else { return 0 }
		return width / height
	}

	/// Given a point in UV space (0 representing the minimal dimension value, 1 representing the max), calculate the point it represents in this CGSize.
	@inline(__always)
	func normalPointToAbsolute(normalPoint: CGPoint) -> CGPoint {
		var normalPoint = normalPoint
		normalPoint.simd = normalPoint.simd * self.simd
		return normalPoint
	}

	/// Convert a point from absolute space (0-size.dimension.max) to UV space (0 representing the minimal dimension value, 1 representing the max); calculate the normalized point representing it in this CGSize.
	@inline(__always)
	func absolutePointToNormal(absolutePoint: CGPoint) -> CGPoint {
		var absolutePoint = absolutePoint
		absolutePoint.simd = absolutePoint.simd / self.simd
		return absolutePoint
	}

	/// Keeps aspect ratio and scales to fit within the given size.
	@inline(__always)
	func scaledToFit(within size: CGSize) -> CGSize {
		let (horizScale, vertScale) = relativeScales(for: size)

		let smallerScale = Swift.min(horizScale, vertScale)
		return self * smallerScale
	}

	/// Keeps aspect ratio and scales to fit within the given size, but will not return a value larger than the original.
	@inline(__always)
	func scaledDownToFit(within size: CGSize) -> CGSize {
		let (horizScale, vertScale) = relativeScales(for: size)

		let smallerScale = Swift.min(horizScale, vertScale)
		if smallerScale < 1 {
			return self * smallerScale
		} else {
			return self
		}
	}

	/// Keeps aspect ratio and scales to fill the given size.
	@inline(__always)
	func scaledToFill(size: CGSize) -> CGSize {
		let (horizScale, vertScale) = relativeScales(for: size)

		let largerScale = Swift.max(horizScale, vertScale)
		return self * largerScale
	}

	/// Keeps aspect ratio and scales to fill the given size, but will not return a value larger than the original.
	@inline(__always)
	func scaledDownToFill(size: CGSize) -> CGSize {
		let (horizScale, vertScale) = relativeScales(for: size)

		let largerScale = Swift.max(horizScale, vertScale)
		if largerScale < 1 {
			return self * largerScale
		} else {
			return self
		}
	}

	/// Returns the value that you'd multiply each of the current CGSize's sides to get the input `size`
	private func relativeScales(for size: CGSize) -> (widthScale: Double, heightScale: Double) {
		let scales = size.simd / simd

		return (scales.x, scales.y)
	}

	@inline(__always)
	init<IntNumber: BinaryInteger>(scalar: IntNumber) {
		let value = CGFloat(scalar)
		self.init(width: value, height: value)
	}

	@inline(__always)
	init<FloatNumber: BinaryFloatingPoint>(scalar: FloatNumber) {
		let value = CGFloat(scalar)
		self.init(width: value, height: value)
	}
}
