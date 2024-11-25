#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct CloseSegment: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		/// See entry in `CGPath.SegmentProtocol`
		public static var isSplitable: Bool { false }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let _startPoint: CGPoint?
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let endPoint: CGPoint
		
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var length: Double { 0 }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var svgString: String { "z" }

		public var description: String { "\(Self.self)" }
		public var debugDescription: String {
			let points = [_startPoint, endPoint]
				.compactMap { $0 }
				.map { $0.description }
				.joined(separator: ", ")
			return "\(description) - \(points)"
		}

		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.endPoint = endPoint
		}
		
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func split(at t: Double) -> (CloseSegment, CloseSegment) {
			let a = CloseSegment(startPoint: _startPoint, endPoint: endPoint)
			let b = CloseSegment(startPoint: endPoint, endPoint: endPoint)
			return (a, b)
		}
		
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? { nil }
	}
}
#endif
