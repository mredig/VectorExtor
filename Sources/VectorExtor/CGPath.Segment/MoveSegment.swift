#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct MoveSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { false }
		public let _startPoint: CGPoint?
		public let endPoint: CGPoint

		public var length: Double { 0 }
		public var svgString: String { "M\(endPoint.x),\(endPoint.y)" }

		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		public func split(at t: Double) -> (MoveSegment, MoveSegment) {
			let mid = (_startPoint ?? .zero).interpolation(to: endPoint, tValue: t, clamped: true)
			let a = MoveSegment(startPoint: _startPoint, endPoint: mid)
			let b = MoveSegment(startPoint: mid, endPoint: endPoint)
			return (a, b)
		}
	}
}
#endif
