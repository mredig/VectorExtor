#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
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
		segments.map(\.svgString).joined(separator: " ")
	}

	private func segmentLengths() -> [(segment: Segment, length: Double)] {
		let segments = segments

		return segments.reduce(into: [], {
			$0.append(($1, $1.length))
		})
	}

	func percentAlongPath(_ percent: Double) -> CGPoint? {
		let subpaths = segmentLengths()
		let percent = percent.clamped()
		let length = subpaths.map(\.length).reduce(0, +)
		let goalLength = length * percent

		var accumulatedLength: Double = 0

		for subpath in subpaths {
			let combined = accumulatedLength + subpath.length

			guard combined != goalLength else {
				return subpath.segment.endPoint
			}

			if combined > goalLength {
				let remaining = goalLength - accumulatedLength
				let segmentPercent = remaining / subpath.length
				return subpath.segment.percentAlongCurve(segmentPercent)
			} else {
				accumulatedLength = combined
				continue
			}
		}
		
		return nil
	}
}

#endif
