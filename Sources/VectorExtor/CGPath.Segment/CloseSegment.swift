#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct CloseSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { false }
		public let _startPoint: CGPoint?
		public let endPoint: CGPoint

		public var length: Double { 0 }
		public var svgString: String { "z" }

		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		public func split(at t: Double) -> (CloseSegment, CloseSegment) {
			let a = CloseSegment(startPoint: _startPoint, endPoint: endPoint)
			let b = CloseSegment(startPoint: endPoint, endPoint: endPoint)
			return (a, b)
		}

		public func percentAlongCurve(_ percent: Double) -> CGPoint? { nil }
	}
}
#endif
