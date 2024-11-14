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
		func percentAlongCurve(_ percent: Double) -> CGPoint?
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.SegmentProtocol {
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

extension CGPath {
	protocol BezierSegmentProtocol: SegmentProtocol {}
}

extension CGPath.BezierSegmentProtocol {
	public func percentAlongCurve(_ percent: Double) -> CGPoint? {
		let percent = percent.clamped()
		guard percent.isZero == false else { return _startPoint }
		guard percent != 1 else { return endPoint }

		let segmentLengths = lengths(ofSegmentCount: 10)
		let totalLength = segmentLengths.map(\.length).reduce(0, +)
		let goalLength = totalLength * percent

		var accumulator: Double = 0

		for (segment, length) in segmentLengths {
			let combined = accumulator + length
			guard combined > 0 else { return endPoint }
			guard
				combined._isRoughlyEqual(to: goalLength, usingThreshold: CGPath.Segment.lengthThreshold) == false
			else { return segment.endPoint }

			if combined > goalLength {
				// hone in on this segment
				let remaining = goalLength - accumulator
				let childSegmentGoalPercent = remaining / length
				return segment.percentAlongCurve(childSegmentGoalPercent)
			} else {
				accumulator = combined
			}
		}
		return nil
	}
}
#endif
