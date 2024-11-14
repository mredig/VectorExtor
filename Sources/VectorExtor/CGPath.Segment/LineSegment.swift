#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct LineSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { true }
		public var startPoint: CGPoint { _startPoint ?? .zero }
		public let _startPoint: CGPoint?
		public let endPoint: CGPoint

		public var length: Double { startPoint.distance(to: endPoint) }
		public var svgString: String { "L\(endPoint.x),\(endPoint.y)" }

		public init(startPoint: CGPoint?, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		public func split(at t: Double) -> (LineSegment, LineSegment) {
			let mid = startPoint.interpolation(to: endPoint, tValue: t, clamped: true)
			let a = LineSegment(startPoint: _startPoint, endPoint: mid)
			let b = LineSegment(startPoint: mid, endPoint: endPoint)
			return (a, b)
		}
	}
}
#endif
