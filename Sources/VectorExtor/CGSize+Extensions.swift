import Foundation
#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics
#endif

public extension CGSize {
	var midPoint: CGPoint {
		normalPointToAbsolute(normalPoint: CGPoint(scalar: 0.5))
	}

	var min: CGFloat { Swift.min(width, height) }
	var max: CGFloat { Swift.max(width, height) }

	var aspectRatio: CGFloat {
		guard height != 0 else { return 0 }
		return width / height
	}

	/// Given a point in UV space (0 representing the minimal dimension value, 1 representing the max), calculate the point it represents in this CGSize.
	func normalPointToAbsolute(normalPoint: CGPoint) -> CGPoint {
		(normalPoint.size * self).point
	}

	/// Convert a point from absolute space (0-size.dimension.max) to UV space (0 representing the minimal dimension value, 1 representing the max); calculate the normalized point representing it in this CGSize.
	func absolutePointToNormal(absolutePoint: CGPoint) -> CGPoint {
		(absolutePoint.size / self).point
	}

	/// Keeps aspect ratio and scales to fit within the given size.
	func scaledToFit(within size: CGSize) -> CGSize {
		let (horizScale, vertScale) = relativeScales(for: size)

		let smallerScale = Swift.min(horizScale, vertScale)
		return self * smallerScale
	}

	/// Keeps aspect ratio and scales to fit within the given size, but will not return a value larger than the original.
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
	func scaledToFill(size: CGSize) -> CGSize {
		let (horizScale, vertScale) = relativeScales(for: size)

		let largerScale = Swift.max(horizScale, vertScale)
		return self * largerScale
	}

	/// Keeps aspect ratio and scales to fill the given size, but will not return a value larger than the original.
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
		let widthScale = size.width / width
		let heightScale = size.height / height

		return (widthScale, heightScale)
	}

	init<IntNumber: BinaryInteger>(scalar: IntNumber) {
		let value = CGFloat(scalar)
		self.init(width: value, height: value)
	}

	init<FloatNumber: BinaryFloatingPoint>(scalar: FloatNumber) {
		let value = CGFloat(scalar)
		self.init(width: value, height: value)
	}
}
