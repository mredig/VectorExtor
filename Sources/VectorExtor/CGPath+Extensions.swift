#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	enum Segment: SegmentProtocol, Hashable, Codable, Sendable {
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

		public var length: Double {
			curve.length
		}

		public var _startPoint: CGPoint? {
			curve._startPoint
		}

		public var endPoint: CGPoint {
			curve.endPoint
		}

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

	var segments: [Segment] {
		var accumulator: [Segment] = []
		var closeEnd: CGPoint?
		applyWithBlock { elementsPointer in
			func setClose(_ new: CGPoint?) {
				if closeEnd == nil {
					closeEnd = new
				}
			}

			let prevEnd = accumulator.last?.endPoint
			let element = elementsPointer[0]
			let curve: Segment
			switch element.type {
			case .moveToPoint:
				let point = element.points[0]
				curve = .moveTo(.init(startPoint: prevEnd, endPoint: point))
				setClose(prevEnd)
			case .addLineToPoint:
				let point = element.points[0]
				curve = .addLineTo(.init(startPoint: prevEnd, endPoint: point))
				setClose(prevEnd)
			case .addQuadCurveToPoint:
				let point = element.points[1]
				let control = element.points[0]
				curve = .addQuadCurveTo(.init(startPoint: prevEnd, controlPoint: control, endPoint: point))
				setClose(prevEnd)
			case .addCurveToPoint:
				let point = element.points[2]
				let control1 = element.points[0]
				let control2 = element.points[1]
				curve = .addCurveTo(.init(startPoint: prevEnd, control1: control1, control2: control2, endPoint: point))
				setClose(prevEnd)
			case .closeSubpath:
				curve = .close(.init(startPoint: prevEnd, endPoint: closeEnd ?? .zero))
				closeEnd = nil
			@unknown default:
				print("Unknown path element type: \(element.type) \(element.type.rawValue)")
				return
			}

			accumulator.append(curve)
		}
		return accumulator
	}

	var length: CGFloat { segments.length }

	var svgString: String { toSVGString() }

	private func toSVGString() -> String {
		let components = segments

		return components.reduce("") {
			switch $1 {
			case .moveTo(let move):
				return $0 + "M\(move.endPoint.x),\(move.endPoint.y) "
			case .addLineTo(let line):
				return $0 + "L\(line.endPoint.x),\(line.endPoint.y) "
			case .addQuadCurveTo(let quad):
				return $0 + "Q\(quad.controlPoint.x),\(quad.controlPoint.y) \(quad.endPoint.x),\(quad.endPoint.y) "
			case .addCurveTo(let cubic):
				return $0 + "C\(cubic.control1.x),\(cubic.control1.y) \(cubic.control2.x),\(cubic.control2.y) \(cubic.endPoint.x),\(cubic.endPoint.y) "
			case .close:
				return $0 + "z "
			}
		}
	}

	func pointAlongPath(atPercent percent: CGFloat, precalculatedLength: CGFloat? = nil) -> CGPoint? {
//		let subpaths = sections
//		let percent = percent.clamped()
//		let length = precalculatedLength ?? self.length
//		let desiredLength = length * percent
//
//		var currentLength: CGFloat = 0
//
//		for subpath in subpaths {
//			let thisSubLength = subpath.length
//			currentLength += thisSubLength
//			if currentLength >= desiredLength {
//				let remaining = desiredLength - (currentLength - thisSubLength)
//				let straightPercentage = thisSubLength != 0 ? remaining / thisSubLength : 0
//				return subpath.pointAlongCurve(atPercent: straightPercentage)
//			}
//		}
		
		return nil
	}
}

#endif
