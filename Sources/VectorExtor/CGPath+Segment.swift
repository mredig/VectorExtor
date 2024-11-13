#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath.Segment {

	var length: Double { curve.length }

	private static func calculateQuadraticCurveLengthAdaptive(
		start: CGPoint,
		control: CGPoint,
		end: CGPoint,
		threshold: Double = 0.01
	) -> Double {
		var total = 0.0
		var stack: [(start: CGPoint, control: CGPoint, end: CGPoint)] = [(start, control, end)]

		while let (start, control, end) = stack.popLast() {
			let netLength = start.distance(to: control) + control.distance(to: end)

			if start.distance(to: end, is: netLength, slop: 0.01) {
				total += netLength
			} else {
				let mid1 = start.interpolation(to: control, tValue: 0.5)
				let mid2 = control.interpolation(to: end, tValue: 0.5)
				let middle = mid1.interpolation(to: mid2, tValue: 0.5)

				stack.append((start, mid1, middle))
				stack.append((middle, mid2, end))
			}
		}
		return total
	}

	private static func calculateCubicCurveLengthAdaptive(
		start: CGPoint,
		control1: CGPoint,
		control2: CGPoint,
		end: CGPoint,
		threshold: Double = 0.01
	) -> Double {
		var total = 0.0
		var stack: [(start: CGPoint, control1: CGPoint, control2: CGPoint, end: CGPoint)] = [(start, control1, control2, end)]

		while let (start, control1, control2, end) = stack.popLast() {
			let netLength = start.distance(to: control1) + control1.distance(to: control2) + control2.distance(to: end)

			if start.distance(to: end, is: netLength, slop: 0.01) {
				total += netLength
			} else {
				let mid1 = start.interpolation(to: control1, tValue: 0.5)
				let mid2 = control1.interpolation(to: control2, tValue: 0.5)
				let mid3 = control2.interpolation(to: end, tValue: 0.5)

				let mid4 = mid1.interpolation(to: mid2, tValue: 0.5)
				let mid5 = mid2.interpolation(to: mid3, tValue: 0.5)

				let middle = mid4.interpolation(to: mid5, tValue: 0.5)

				stack.append((start, mid1, mid4, middle))
				stack.append((middle, mid5, mid3, end))
			}
		}
		return total
	}

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
	struct QuadCurve: CurveProtocol, Hashable, Codable, Sendable {
		private var _startPoint: CGPoint { startPoint ?? .zero }
		public let startPoint: CGPoint?
		public let controlPoint: CGPoint
		public let endPoint: CGPoint

		public var length: Double { calculateQuadraticCurveLengthAdaptive() }

		public init(startPoint: CGPoint?, controlPoint: CGPoint, endPoint: CGPoint) {
			self.startPoint = startPoint
			self.controlPoint = controlPoint
			self.endPoint = endPoint
		}

		public func calculateQuadraticCurveLengthAdaptive(
			threshold: Double = 0.01
		) -> Double {
			var total = 0.0
			var stack: [QuadCurve] = [self]

			while let curve = stack.popLast() {
				let (start, control, end) = (curve._startPoint, curve.controlPoint, curve.endPoint)
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
			let mid1 = _startPoint.interpolation(to: controlPoint, tValue: t)
			let mid2 = controlPoint.interpolation(to: endPoint, tValue: t)
			let middle = mid1.interpolation(to: mid2, tValue: t)

			let a = QuadCurve(startPoint: _startPoint, controlPoint: mid1, endPoint: middle)
			let b = QuadCurve(startPoint: middle, controlPoint: mid2, endPoint: endPoint)
			return (a, b)
		}
	}

	struct CubicCurve: CurveProtocol, Hashable, Codable, Sendable {
		private var _startPoint: CGPoint { startPoint ?? .zero }
		public let startPoint: CGPoint?
		public let control1: CGPoint
		public let control2: CGPoint
		public let endPoint: CGPoint

		public var length: Double { calculateCubicCurveLengthAdaptive() }

		public init(startPoint: CGPoint?, control1: CGPoint, control2: CGPoint, endPoint: CGPoint) {
			self.startPoint = startPoint
			self.control1 = control1
			self.control2 = control2
			self.endPoint = endPoint
		}

		public func calculateCubicCurveLengthAdaptive(
			threshold: Double = 0.01
		) -> Double {
			var total = 0.0
			var stack: [CubicCurve] = [self]

			while let curve = stack.popLast() {
				let (start, control1, control2, end) = (curve._startPoint, curve.control1, curve.control2, curve.endPoint)
				let netLength = start.distance(to: control1) + control1.distance(to: control2) + control2.distance(to: end)

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

		public func split(at t: Double) -> (CubicCurve, CubicCurve) {
			let t = t.clamped()
			let mid1 = _startPoint.interpolation(to: control1, tValue: t)
			let mid2 = control1.interpolation(to: control2, tValue: t)
			let mid3 = control2.interpolation(to: endPoint, tValue: t)

			let mid4 = mid1.interpolation(to: mid2, tValue: t)
			let mid5 = mid2.interpolation(to: mid3, tValue: t)

			let middle = mid4.interpolation(to: mid5, tValue: t)

			let a = CubicCurve(startPoint: _startPoint, control1: mid1, control2: mid4, endPoint: middle)
			let b = CubicCurve(startPoint: middle, control1: mid5, control2: mid3, endPoint: endPoint)
			return (a, b)
		}
	}

	struct LineCurve: CurveProtocol, Hashable, Codable, Sendable {
		internal var _startPoint: CGPoint { startPoint ?? .zero }
		public let startPoint: CGPoint?
		public let endPoint: CGPoint

		public var length: Double { _startPoint.distance(to: endPoint) }

		public init(startPoint: CGPoint?, endPoint: CGPoint) {
			self.startPoint = startPoint
			self.endPoint = endPoint
		}
	}

	struct MoveCurve: CurveProtocol, Hashable, Codable, Sendable {
		public let startPoint: CGPoint?
		public let endPoint: CGPoint

		public var length: Double { 0 }

		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self.startPoint = startPoint
			self.endPoint = endPoint
		}
	}

	struct CloseCurve: CurveProtocol, Hashable, Codable, Sendable {
		public let startPoint: CGPoint?
		public let endPoint: CGPoint

		public var length: Double { 0 }

		public init(startPoint: CGPoint? = nil, endPoint: CGPoint) {
			self.startPoint = startPoint
			self.endPoint = endPoint
		}
	}

	protocol CurveProtocol {
		// TODO: change to _
		var startPoint: CGPoint? { get }
		var endPoint: CGPoint { get }

		var length: Double { get }
	}
}

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension Array where Element == CGPath.Segment {
	public var length: Double {
		reduce(0) { $0 + $1.length }
	}
}

#endif
