#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct CubicCurve: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public static var isSplitable: Bool { true }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var startPoint: CGPoint { _startPoint ?? .zero }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let _startPoint: CGPoint?
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let control1: CGPoint
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let control2: CGPoint
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public let endPoint: CGPoint
		
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var length: Double { calculateCubicCurveLengthAdaptive() }
		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public var svgString: String {
			"C\(control1.x),\(control1.y) \(control2.x),\(control2.y) \(endPoint.x),\(endPoint.y)"
		}

		public var description: String {
			let points = [_startPoint, control1, control2, endPoint]
				.compactMap { $0 }
				.map { $0.description }
				.joined(separator: ", ")
			return "\(Self.self) - \(points)"
		}
		public var debugDescription: String {
			description
		}

		@inline(__always)
		public init(startPoint: CGPoint?, control1: CGPoint, control2: CGPoint, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.control1 = control1
			self.control2 = control2
			self.endPoint = endPoint
		}

		@inline(__always)
		public func calculateCubicCurveLengthAdaptive(
			threshold: Double = CGPath.Segment.lengthThreshold
		) -> Double {
			var total = 0.0
			var stack: [CubicCurve] = [self]

			while let curve = stack.popLast() {
				let (start, control1, control2, end) = (curve.startPoint, curve.control1, curve.control2, curve.endPoint)
				let netLength = start.distance(to: control1) + control1.distance(to: control2) + control2.distance(to: end)

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

		/// See entry in `CGPath.SegmentProtocol`
		@inline(__always)
		public func split(at t: Double) -> (CubicCurve, CubicCurve) {
			let t = t.clamped()
			let mid1 = startPoint.interpolation(to: control1, tValue: t)
			let mid2 = control1.interpolation(to: control2, tValue: t)
			let mid3 = control2.interpolation(to: endPoint, tValue: t)

			let mid4 = mid1.interpolation(to: mid2, tValue: t)
			let mid5 = mid2.interpolation(to: mid3, tValue: t)

			let middle = mid4.interpolation(to: mid5, tValue: t)

			let a = CubicCurve(startPoint: startPoint, control1: mid1, control2: mid4, endPoint: middle)
			let b = CubicCurve(startPoint: middle, control1: mid5, control2: mid3, endPoint: endPoint)
			return (a, b)
		}

		// exact same code as `QuadCurve.percentAlongCurve` - duplicated for better performance
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
