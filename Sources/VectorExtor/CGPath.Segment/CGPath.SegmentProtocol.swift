#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	protocol SegmentProtocol {
		var _startPoint: CGPoint? { get }
		var endPoint: CGPoint { get }

		var length: Double { get }

		var svgString: String { get }
		static var isSplitable: Bool { get }

		func split(at t: Double) -> (Self, Self)
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension CGPath.SegmentProtocol {
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
}
#endif
