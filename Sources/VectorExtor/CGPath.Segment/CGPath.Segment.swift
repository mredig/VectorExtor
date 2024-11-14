#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	enum Segment: SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { true }
		case moveTo(MoveSegment)
		case addLineTo(LineSegment)
		case addQuadCurveTo(QuadCurve)
		case addCurveTo(CubicCurve)
		case close(CloseSegment)

		public var curve: SegmentProtocol {
			switch self {
			case
					.moveTo(let curve as SegmentProtocol),
					.addLineTo(let curve as SegmentProtocol),
					.addQuadCurveTo(let curve as SegmentProtocol),
					.addCurveTo(let curve as SegmentProtocol),
					.close(let curve as SegmentProtocol):
				curve
			}
		}
		public var svgString: String { curve.svgString }
		public var length: Double { curve.length }
		public var _startPoint: CGPoint? { curve._startPoint }
		public var endPoint: CGPoint { curve.endPoint }

		public func split(at t: Double) -> (Segment, Segment) {
			switch self {
			case .moveTo(let original):
				let chunks = original.split(at: t)
				return (.moveTo(chunks.0), .moveTo(chunks.1))
			case .addLineTo(let original):
				let chunks = original.split(at: t)
				return (.addLineTo(chunks.0), .addLineTo(chunks.1))
			case .addQuadCurveTo(let original):
				let chunks = original.split(at: t)
				return (.addQuadCurveTo(chunks.0), .addQuadCurveTo(chunks.1))
			case .addCurveTo(let original):
				let chunks = original.split(at: t)
				return (.addCurveTo(chunks.0), .addCurveTo(chunks.1))
			case .close(let original):
				let chunks = original.split(at: t)
				return (.close(chunks.0), .close(chunks.1))
			}
		}
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {

	/// Calculated by first calculating the total length, then iterating over divided segments until the current point
	/// is `percent` length from the starting point. If this is being called repeatedly for the same curve, you may save
	/// some calculation by provided a precalculated length value. However, providing an incorrect value is untested and
	/// unsupported. No protections are made against this. Behave yourself.
//	func pointAlongCurve(atPercent percent: Double, precalculatedLength: Double? = nil) -> CGPoint? {
////		// FIXME: Read note:
////		// check that this work with subpaths - subpaths can move and close, allowing for a move to happen where there might be a previous point, unintentionally
////		guard previous?.endPoint != nil else {
////			if case CGPath.PathElement.moveTo(point: let move) = self.element {
////				return move
////			}
////			return nil
////		}
//
//		switch curve {
//		case .moveTo(point: let point):
//			return point
//		case .close:
//			return startingPoint
//		case .addLineTo(point: let end):
//			return (startingPoint ?? .zero).interpolation(to: end, tValue: percent)
//		case .addCurveTo, .addQuadCurveTo:
//			break
//		}
//
//		let percent = percent.clamped()
//		let length = precalculatedLength ?? self.length
//		let desiredLength = length * percent
//
//		var currentLength: CGFloat = 0
//		let relativeSectionLength = 1.0 / CGFloat(CGPath.PathSection.curveResolution)
//		var iteration = 0
//		var lastLength: CGFloat = 0
//		while currentLength < desiredLength && iteration < CGPath.PathSection.curveResolution {
//			lastLength = calculateCurveLengthForSpan(iterationStep: iteration, relativeSectionLength: relativeSectionLength)
//			currentLength += lastLength
//			iteration += 1
//		}
//
//		let remaining = desiredLength - (currentLength - lastLength)
//		let straightPercentage = remaining / lastLength
//		guard let (subPointStart, subPointEnd) = calculateCurveStartStopPointsForSpan(iterationStep: iteration - 1, relativeSectionLength: relativeSectionLength) else { return nil }
//
//		return linearBezierPoint(t: straightPercentage, start: subPointStart, end: subPointEnd)
//	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension Array where Element == CGPath.Segment {
	public var length: Double { reduce(0) { $0 + $1.length } }
}

#endif
