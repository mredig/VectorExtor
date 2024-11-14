#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct LineSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { true }
		@inline(__always)
		public var startPoint: CGPoint { _startPoint ?? .zero }
		@inline(__always)
		public let _startPoint: CGPoint?
		@inline(__always)
		public let endPoint: CGPoint

		@inline(__always)
		public var length: Double { startPoint.distance(to: endPoint) }
		@inline(__always)
		public var svgString: String { "L\(endPoint.x),\(endPoint.y)" }

		@inline(__always)
		public init(startPoint: CGPoint?, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		@inline(__always)
		public func split(at t: Double) -> (LineSegment, LineSegment) {
			let mid = startPoint.interpolation(to: endPoint, tValue: t, clamped: true)
			let a = LineSegment(startPoint: _startPoint, endPoint: mid)
			let b = LineSegment(startPoint: mid, endPoint: endPoint)
			return (a, b)
		}

		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? {
			startPoint.interpolation(to: endPoint, tValue: percent, clamped: true)
		}
	}
}
#endif
