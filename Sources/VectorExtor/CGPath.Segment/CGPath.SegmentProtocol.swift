#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	/// A common set of properties and methods for all `Segment`s
	protocol SegmentProtocol: CustomStringConvertible, CustomDebugStringConvertible {
		/// The location of the starting point. Can be `nil`. Using `startPoint` on most implementers will default
		/// to `.zero`, but if used in a sequence, it would usually be the previous item's `endPoint`
		@inline(__always)
		var _startPoint: CGPoint? { get }
		/// The location of the ending point
		@inline(__always)
		var endPoint: CGPoint { get }

		/// A measurement of the segment. This value is recalculated every time it's accessed.
		@inline(__always)
		var length: Double { get }

		/// An svg format string of this individual component.
		@inline(__always)
		var svgString: String { get }
		/// Indicates whether you can split the implementing type into smaller segments.
		static var isSplitable: Bool { get }

		/// When the type's `isSplitable` is `true`, it will subdivide the
		/// segment into two parts, divided at the `t` offset. Valid `t` values are `0.0...1.0`.
		@inline(__always)
		func split(at t: Double) -> (Self, Self)
		/// Searches for the location that is `percent` distance along the `length` of
		/// the curve. Valid `percent` values are `0.0...1.0`
		@inline(__always)
		func percentAlongCurve(_ percent: Double) -> CGPoint?
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.SegmentProtocol {
	/// Splits the curve into `segmentCount` segments. Segments are divided evenly along
	/// the `t` values of the curve. Note that this does not mean "equal sizes", just equal `t` distributions.
	@inline(__always)
	func split(intoSegments segmentCount: Int) -> [Self] {
		guard Self.isSplitable, segmentCount > 0 else { return [self] }

		let doubleCount = Double(segmentCount + 1)
		let chunkTSize = 1.0 / doubleCount
		var accumulator: [Self] = []
		var remainingSegment = self
		func remainingTRange() -> Double {
			(doubleCount - Double(accumulator.count + 1)) / doubleCount
		}
		while accumulator.count < segmentCount - 1 {
			let tValue = chunkTSize / remainingTRange()
			let (left, right) = remainingSegment.split(at: tValue)
			remainingSegment = right
			accumulator.append(left)
		}

		accumulator.append(remainingSegment)

		return accumulator
	}

	/// Splits the curve into `segmentCount` segments, then measures the `length`
	/// of each segment, pairing them in the returned array.
	@inline(__always)
	func lengths(ofSegmentCount segmentCount: Int) -> [(segment: Self, length: Double)] {
		let segments = split(intoSegments: segmentCount)
		return segments.reduce(into: []) {
			$0.append(($1, $1.length))
		}
	}

	/// Finds the point at a given `t` value in the curve. Valid `t` values are `0.0...1.0`.
	func pointAlongCurve(t: Double) -> CGPoint {
		split(at: t).0.endPoint
	}
}
#endif
