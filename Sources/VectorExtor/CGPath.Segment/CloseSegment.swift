#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct CloseSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { false }
		@inline(__always)
		public let _startPoint: CGPoint?
		@inline(__always)
		public let endPoint: CGPoint

		@inline(__always)
		public var length: Double { 0 }
		@inline(__always)
		public var svgString: String { "z" }

		@inline(__always)
		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}

		@inline(__always)
		public func split(at t: Double) -> (CloseSegment, CloseSegment) {
			let a = CloseSegment(startPoint: _startPoint, endPoint: endPoint)
			let b = CloseSegment(startPoint: endPoint, endPoint: endPoint)
			return (a, b)
		}

		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? { nil }
	}
}
#endif
