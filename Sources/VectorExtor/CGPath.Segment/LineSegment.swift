#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct LineSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		/// See entry in `CGPath.SegmentProtocol`
		public static var isSplitable: Bool { true }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var startPoint: CGPoint { _startPoint ?? .zero }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let _startPoint: CGPoint?
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let endPoint: CGPoint
		
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var length: Double { startPoint.distance(to: endPoint) }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var svgString: String { "L\(endPoint.x),\(endPoint.y)" }

		@inline(__always)
		public init(startPoint: CGPoint?, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func split(at t: Double) -> (LineSegment, LineSegment) {
			let mid = startPoint.interpolation(to: endPoint, tValue: t, clamped: true)
			let a = LineSegment(startPoint: _startPoint, endPoint: mid)
			let b = LineSegment(startPoint: mid, endPoint: endPoint)
			return (a, b)
		}

		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? {
			startPoint.interpolation(to: endPoint, tValue: percent, clamped: true)
		}
	}
}
#endif
