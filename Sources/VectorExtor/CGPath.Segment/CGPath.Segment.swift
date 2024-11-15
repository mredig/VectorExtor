#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	/// Correlates to CGPathElement/CGPathElementType, but in a more managable form.
	/// Provides measurement (`length`), easy svg conversion, and some convenience functions.
	enum Segment: SegmentProtocol, Hashable, Codable, Sendable {
		/// Adjusts the adaptive resolution algorithm threshold used when calculating curve length.
		/// Smaller values are more accurate, but more computationally expensive. Defaults to `0.01`
		public static var lengthThreshold: Double = 0.01
		/// Indicates whether you can split this type into smaller segments.
		public static var isSplitable: Bool { true }

		public var description: String { "Segment.\(curve.description))" }
		public var debugDescription: String { description }

		case moveTo(MoveSegment)
		case addLineTo(LineSegment)
		case addQuadCurveTo(QuadCurve)
		case addCurveTo(CubicCurve)
		case close(CloseSegment)

		/// Generic protocol access to the underlying curve. This is convenient, but
		/// performantly slower than switching over the possilbe cases.
		@inline(__always)
		public var curve: SegmentProtocol {
			switch self {
			case
					.moveTo(let curve as SegmentProtocol),
					.addLineTo(let curve as SegmentProtocol),
					.addQuadCurveTo(let curve as SegmentProtocol),
					.addCurveTo(let curve as SegmentProtocol),
					.close(let curve as SegmentProtocol):
				curve
			}
		}
		/// An svg format string of this individual component.
		@inline(__always)
		public var svgString: String { accessCurveProperty(\.svgString) }
		/// A measurement of the segment. This value is recalculated every time it's accessed.
		@inline(__always)
		public var length: Double { accessCurveProperty(\.length) }
		/// The location of the starting point. Can be `nil`. Using `startPoint` on most implementers will default
		/// to `.zero`, but if used in a sequence, it would usually be the previous item's `endPoint`
		@inline(__always)
		public var _startPoint: CGPoint? { accessCurveProperty(\._startPoint) }
		/// The location of the ending point
		@inline(__always)
		public var endPoint: CGPoint { accessCurveProperty(\.endPoint) }

		/// Consolidated, yet performant protocol access for properties
		@inline(__always)
		private func accessCurveProperty<T>(_ keypath: KeyPath<SegmentProtocol, T>) -> T {
			switch self {
			case .moveTo(let curve):
				curve[keyPath: keypath]
			case .addLineTo(let curve):
				curve[keyPath: keypath]
			case .addQuadCurveTo(let curve):
				curve[keyPath: keypath]
			case .addCurveTo(let curve):
				curve[keyPath: keypath]
			case .close(let curve):
				curve[keyPath: keypath]
			}
		}

		/// When the type's `isSplitable` is `true`, it will subdivide the
		/// segment into two parts, divided at the `t` offset. Valid `t` values are `0.0...1.0`.
		@inline(__always)
		public func split(at t: Double) -> (Segment, Segment) {
			switch self {
			case .moveTo(let original):
				let chunks = original.split(at: t)
				return (.moveTo(chunks.0), .moveTo(chunks.1))
			case .addLineTo(let original):
				let chunks = original.split(at: t)
				return (.addLineTo(chunks.0), .addLineTo(chunks.1))
			case .addQuadCurveTo(let original):
				let chunks = original.split(at: t)
				return (.addQuadCurveTo(chunks.0), .addQuadCurveTo(chunks.1))
			case .addCurveTo(let original):
				let chunks = original.split(at: t)
				return (.addCurveTo(chunks.0), .addCurveTo(chunks.1))
			case .close(let original):
				let chunks = original.split(at: t)
				return (.close(chunks.0), .close(chunks.1))
			}
		}

		/// Searches for the location that is `percent` distance along the `length` of
		/// the curve. Valid `percent` values are `0.0...1.0`
		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? {
			switch self {
			case .moveTo, .close:
				nil
			case .addLineTo(let curve):
				curve.percentAlongCurve(percent)
			case .addQuadCurveTo(let curve):
				curve.percentAlongCurve(percent)
			case .addCurveTo(let curve):
				curve.percentAlongCurve(percent)
			}
		}
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension Array where Element == CGPath.Segment {
	/// A measurement of the segments contained within. This value is recalculated every time it's accessed.
	@inline(__always)
	public var length: Double { reduce(0) { $0 + $1.length } }
}

#endif
