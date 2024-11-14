#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {
	struct QuadCurve: CGPath.SegmentProtocol, Hashable, Codable, Sendable {
		public static var isSplitable: Bool { true }
		public var startPoint: CGPoint { _startPoint ?? .zero }
		public let _startPoint: CGPoint?
		public let controlPoint: CGPoint
		public let endPoint: CGPoint

		public var length: Double { calculateQuadraticCurveLengthAdaptive() }
		public var svgString: String { "Q\(controlPoint.x),\(controlPoint.y) \(endPoint.x),\(endPoint.y)" }

		public init(startPoint: CGPoint?, controlPoint: CGPoint, endPoint: CGPoint) {
			self._startPoint = startPoint
			self.controlPoint = controlPoint
			self.endPoint = endPoint
		}

		public func calculateQuadraticCurveLengthAdaptive(
			threshold: Double = 0.01
		) -> Double {
			var total = 0.0
			var stack: [QuadCurve] = [self]

			while let curve = stack.popLast() {
				let (start, control, end) = (curve.startPoint, curve.controlPoint, curve.endPoint)
				let netLength = start.distance(to: control) + control.distance(to: end)

				if start.distance(to: end, is: netLength, slop: 0.01) {
					total += netLength
				} else {
					let (a, b) = curve.split(at: 0.5)

					stack.append(a)
					stack.append(b)
				}
			}
			return total
		}

		public func split(at t: Double) -> (QuadCurve, QuadCurve) {
			let mid1 = startPoint.interpolation(to: controlPoint, tValue: t)
			let mid2 = controlPoint.interpolation(to: endPoint, tValue: t)
			let middle = mid1.interpolation(to: mid2, tValue: t)

			let a = QuadCurve(startPoint: startPoint, controlPoint: mid1, endPoint: middle)
			let b = QuadCurve(startPoint: middle, controlPoint: mid2, endPoint: endPoint)
			return (a, b)
		}
	}
}
#endif
