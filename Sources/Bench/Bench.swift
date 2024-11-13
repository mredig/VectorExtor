import Foundation
import BenchyLib
import VectorExtor
import CoreGraphics

@main
struct Bench {
	static func main() async throws {
		var benchy = Benchy()
		try benchy.addBenchyTest(LengthCalculation.self)

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
