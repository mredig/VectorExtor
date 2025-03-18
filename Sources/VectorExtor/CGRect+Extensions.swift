import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension CGRect {
	@inline(__always)
	var maxXY: CGPoint { CGPoint(x: maxX, y: maxY) }
	@inline(__always)
	var minXMaxY: CGPoint { CGPoint(x: minX, y: maxY) }
	@inline(__always)
	var maxXMinY: CGPoint { CGPoint(x: maxX, y: minY) }
	@inline(__always)
	var midPoint: CGPoint { CGPoint(x: midX, y: midY) }

	@inline(__always)
	init<FloatNumber: BinaryFloatingPoint>(scalarOrigin: FloatNumber, scalarSize: FloatNumber) {
		self.init(origin: CGPoint(scalar: scalarOrigin), size: CGSize(scalar: scalarSize))
	}

	@inline(__always)
	init(size: CGSize) {
		self.init(origin: .zero, size: size)
	}

	/// Takes the current CGRect and offsets the origin such that the center of both `self` and `outerRect` are
	/// overlaid on each other. This will also have the effect of making the left and right edges of each
	/// CGRect equidistant to each other (inner left -> outer left == inner right -> outer right)
	/// - Parameter outerRect: The CGRect that is stationary.
	/// - Returns: Modified CGRect that is centered
	@inline(__always)
	func centered(inside outerRect: CGRect) -> CGRect {
		let hBuffer = (outerRect.width - width) / 2
		let vBuffer = (outerRect.height - height) / 2

		return CGRect(origin: outerRect.origin + CGPoint(x: hBuffer, y: vBuffer), size: size)
	}

	/// Takes the current CGRect and offsets the origin such that the distance from the left edge of `self` and
	/// `outerRect` are equal to the distance between the right edges.
	/// - Parameter outerRect: The CGRect that is stationary.
	/// - Returns: Modified CGRect that is centered horizontally
	@inline(__always)
	func centeredHorizontally(inside outerRect: CGRect) -> CGRect {
		let hBuffer = (outerRect.width - width) / 2

		return CGRect(
			origin: CGPoint(x: outerRect.origin.x + hBuffer, y: origin.y),
			size: size)
	}

	/// Takes the current CGRect and offsets the origin such that the distance from the left edge of `self` and
	/// `outerRect` are equal to the distance between the right edges.
	/// - Parameter outerRect: The CGRect that is stationary.
	/// - Returns: Modified CGRect that is centered horizontally
	@inline(__always)
	func centeredVerticaly(inside outerRect: CGRect) -> CGRect {
		let vBuffer = (outerRect.height - height) / 2

		return CGRect(
			origin: CGPoint(x: origin.x, y: outerRect.origin.y + vBuffer),
			size: size)
	}
}
