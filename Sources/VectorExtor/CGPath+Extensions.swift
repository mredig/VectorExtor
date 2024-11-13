#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	protocol SegmentProtocol {
		var _startPoint: CGPoint? { get }
		var endPoint: CGPoint { get }

		var length: Double { get }
	}

	enum Segment: SegmentProtocol, Hashable, Codable, Sendable {
		case moveTo(MoveSegment)
		case addLineTo(LineSegment)
		case addQuadCurveTo(QuadCurve)
		case addCurveTo(CubicCurve)
		case close(CloseSegment)

		public var length: Double {
			switch self {
			case
					.addLineTo(let curve as SegmentProtocol),
					.addQuadCurveTo(let curve as SegmentProtocol),
					.addCurveTo(let curve as SegmentProtocol),
					.close(let curve as SegmentProtocol),
					.moveTo(let curve as SegmentProtocol):
				curve.length
			}
		}

		public var _startPoint: CGPoint? {
			switch self {
			case .moveTo(let curve):
				curve._startPoint
			case .addLineTo(let curve):
				curve._startPoint
			case .addQuadCurveTo(let curve):
				curve._startPoint
			case .addCurveTo(let curve):
				curve._startPoint
			case .close(let curve):
				curve._startPoint
			}
		}

		public var endPoint: CGPoint {
			switch self {
			case .moveTo(let curve):
				curve.endPoint
			case .addLineTo(let curve):
				curve.endPoint
			case .addQuadCurveTo(let curve):
				curve.endPoint
			case .addCurveTo(let curve):
				curve.endPoint
			case .close(let curve):
				curve.endPoint
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
