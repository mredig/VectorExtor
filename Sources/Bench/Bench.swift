import Foundation
import BenchyLib
import VectorExtor
import CoreGraphics

@main
struct Bench {
	static func main() async throws {
		var benchy = Benchy()
//		try benchy.addBenchyTest(LengthCalculation.self)
		try benchy.addBenchyTest(PercentCalculation.self)
//		try benchy.addBenchyTest(TPointCalculation.self)

		try benchy.runBenchmarks()

		benchy.displayResults(decimalCount: 10)
	}
}

enum LengthCalculation: BenchyComparator {
	static var benchmarks: [ChildBenchmark] = []
	static var iterations: Int = 999999

	static func setupBenchmarks() throws {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 0, y: 7))
		path.addLine(to: CGPoint(x: 44, y: 7))
		path.addCurve(to: CGPoint(x: 66, y: 0), control1: CGPoint(x: 44, y: 7), control2: CGPoint(x: 68, y: 9))
		path.addQuadCurve(to: CGPoint(x: 80, y: -7), control: CGPoint(x: 66, y: -7))

		ChildBenchmark(
			label: "Segment (new)") { i, label in
				let segments = path.segments

				for segment in segments {
					_ = segment.length
				}
			}

		ChildBenchmark(
			label: "Section (old)") { i, label in
				let segments = path.sections

				for segment in segments {
					_ = segment.length
				}
			}
	}
}

enum PercentCalculationIterative: BenchyComparator {
	static var benchmarks: [ChildBenchmark] = []
	static var iterations: Int = 9999

	static func setupBenchmarks() throws {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 0, y: 7))
		path.addLine(to: CGPoint(x: 44, y: 7))
		path.addCurve(to: CGPoint(x: 66, y: 0), control1: CGPoint(x: 44, y: 7), control2: CGPoint(x: 68, y: 9))
		path.addQuadCurve(to: CGPoint(x: 80, y: -7), control: CGPoint(x: 66, y: -7))
		path.closeSubpath()

		for segment in path.segments {
			let label = segment.svgString.prefix(3)
			ChildBenchmark(label: "Point at Percent Segment - \(label) (new)") { i, label in
				for i in 0...47 {
					let t = Double(i) / 47.0
					_ = segment.percentAlongCurve(t)
				}
			}
		}

		for section in path.sections {
			let label: String
			switch section.element {
			case .addCurveTo: label = "cubic"
			case .addQuadCurveTo: label = "quad"
			case .addLineTo: label = "line"
			case .close: label = "close"
			case .moveTo: label = "move"
			}
			ChildBenchmark(label: "Point at Percent Section - \(label) (old)") { i, label in
				for i in 0...47 {
					let t = Double(i) / 47.0
					_ = section.pointAlongCurve(atPercent: t)
				}
			}
		}
	}
}

enum PercentCalculation: BenchyComparator {
	static var benchmarks: [ChildBenchmark] = []
	static var iterations: Int = 9999

	static func setupBenchmarks() throws {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 0, y: 7))
		path.addLine(to: CGPoint(x: 44, y: 7))
		path.addCurve(to: CGPoint(x: 66, y: 0), control1: CGPoint(x: 44, y: 7), control2: CGPoint(x: 68, y: 9))
		path.addQuadCurve(to: CGPoint(x: 80, y: -7), control: CGPoint(x: 66, y: -7))
		path.closeSubpath()

		ChildBenchmark(label: "Point at Percent Segment (new)") { i, label in
			for segment in path.segments {
				for i in 0...47 {
					let t = Double(i) / 47.0
					_ = segment.percentAlongCurve(t)
				}
			}
		}

		ChildBenchmark(label: "Point at Percent Section (old)") { i, label in
			for section in path.sections {
				for i in 0...47 {
					let t = Double(i) / 47.0
					_ = section.pointAlongCurve(atPercent: t)
				}
			}
		}
	}
}

enum TPointCalculation: BenchyComparator {
	static var benchmarks: [ChildBenchmark] = []
	static var iterations: Int = 999999

	static func setupBenchmarks() throws {
		let path = CGMutablePath()

		path.move(to: CGPoint(x: 0, y: 7))
		path.addLine(to: CGPoint(x: 44, y: 7))
		path.addCurve(to: CGPoint(x: 66, y: 0), control1: CGPoint(x: 44, y: 7), control2: CGPoint(x: 68, y: 9))
		path.addQuadCurve(to: CGPoint(x: 80, y: -7), control: CGPoint(x: 66, y: -7))


		for segment in path.segments {
			let label: String
			switch segment {
			case .addCurveTo: label = "cubic"
			case .addQuadCurveTo: label = "quad"
			case .addLineTo: label = "line"
			case .close: label = "close"
			case .moveTo: label = "move"
			}
			ChildBenchmark(label: "Point at T Segment - \(label) (new)") { i, label in
				for i in 0...47 {
					let t = Double(i) / 47.0
					_ = segment.pointAlongCurve(t: t)
				}
			}
		}

		for section in path.sections {
			let label: String
			switch section.element {
			case .addCurveTo: label = "cubic"
			case .addQuadCurveTo: label = "quad"
			case .addLineTo: label = "line"
			case .close: label = "close"
			case .moveTo: label = "move"
			}
			ChildBenchmark(label: "Point at T Section - \(label) (old)") { i, label in
				for i in 0...47 {
					let t = Double(i) / 47.0
					_ = section.pointAlongCurve(at: t)
				}
			}
		}
	}
}

