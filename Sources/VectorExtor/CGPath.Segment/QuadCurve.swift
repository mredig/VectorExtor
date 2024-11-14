#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct QuadCurve: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { true }
		@inline(__always)
		public var startPoint: CGPoint { _startPoint ?? .zero }
		@inline(__always)
		public let _startPoint: CGPoint?
		@inline(__always)
		public let controlPoint: CGPoint
		@inline(__always)
		public let endPoint: CGPoint

		@inline(__always)
		public var length: Double { calculateQuadraticCurveLengthAdaptive() }
		@inline(__always)
		public var svgString: String { "Q\(controlPoint.x),\(controlPoint.y) \(endPoint.x),\(endPoint.y)" }

		@inline(__always)
		public init(startPoint: CGPoint?, controlPoint: CGPoint, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.controlPoint = controlPoint
			self.endPoint = endPoint
		}

		@inline(__always)
		public func calculateQuadraticCurveLengthAdaptive(
			threshold: Double = CGPath.Segment.lengthThreshold
		) -> Double {
			var total = 0.0
			var stack: [QuadCurve] = [self]

			while let curve = stack.popLast() {
				let (start, control, end) = (curve.startPoint, curve.controlPoint, curve.endPoint)
				let netLength = start.distance(to: control) + control.distance(to: end)

				if start.distance(to: end, is: netLength, slop: threshold) {
					total += netLength
				} else {
					let (a, b) = curve.split(at: 0.5)

					stack.append(a)
					stack.append(b)
				}
			}
			return total
		}

		@inline(__always)
		public func split(at t: Double) -> (QuadCurve, QuadCurve) {
			let t = t.clamped()
			let mid1 = startPoint.interpolation(to: controlPoint, tValue: t)
			let mid2 = controlPoint.interpolation(to: endPoint, tValue: t)
			let middle = mid1.interpolation(to: mid2, tValue: t)

			let a = QuadCurve(startPoint: startPoint, controlPoint: mid1, endPoint: middle)
			let b = QuadCurve(startPoint: middle, controlPoint: mid2, endPoint: endPoint)
			return (a, b)
		}

		// exact same code as `CubicCurve.percentAlongCurve` - duplicated for better performance
		@inline(__always)
		public func percentAlongCurve(_ percent: Double) -> CGPoint? {
			let percent = percent.clamped()
			guard percent.isZero == false else { return _startPoint }
			guard percent != 1 else { return endPoint }

			let segmentLengths = lengths(ofSegmentCount: 4)
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
}
#endif
