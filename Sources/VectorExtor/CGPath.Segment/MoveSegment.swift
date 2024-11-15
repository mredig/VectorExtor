#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct MoveSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		/// See entry in `CGPath.SegmentProtocol`
		public static var isSplitable: Bool { false }
		@inline(__always)
		/// See entry in `CGPath.SegmentProtocol`
		public let _startPoint: CGPoint?
		@inline(__always)
		/// See entry in `CGPath.SegmentProtocol`
		public let endPoint: CGPoint

		@inline(__always)
		/// See entry in `CGPath.SegmentProtocol`
		public var length: Double { 0 }
		@inline(__always)
		/// See entry in `CGPath.SegmentProtocol`
		public var svgString: String { "M\(endPoint.x),\(endPoint.y)" }

		@inline(__always)
		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func split(at t: Double) -> (MoveSegment, MoveSegment) {
			let mid = (_startPoint ?? .zero).interpolation(to: endPoint, tValue: t, clamped: true)
			let a = MoveSegment(startPoint: _startPoint, endPoint: mid)
			let b = MoveSegment(startPoint: mid, endPoint: endPoint)
			return (a, b)
		}

		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? { nil }
	}
}
#endif
