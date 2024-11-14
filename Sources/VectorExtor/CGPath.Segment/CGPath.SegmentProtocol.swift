#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	protocol SegmentProtocol {
		@inline(__always)
		var _startPoint: CGPoint? { get }
		@inline(__always)
		var endPoint: CGPoint { get }

		@inline(__always)
		var length: Double { get }

		@inline(__always)
		var svgString: String { get }
		static var isSplitable: Bool { get }

		@inline(__always)
		func split(at t: Double) -> (Self, Self)
		@inline(__always)
		func percentAlongCurve(_ percent: Double) -> CGPoint?
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.SegmentProtocol {
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

	@inline(__always)
	func lengths(ofSegmentCount segmentCount: Int) -> [(segment: Self, length: Double)] {
		let segments = split(intoSegments: segmentCount)
		return segments.reduce(into: []) {
			$0.append(($1, $1.length))
		}
	}

	func pointAlongCurve(t: Double) -> CGPoint {
		split(at: t).0.endPoint
	}
}
#endif
