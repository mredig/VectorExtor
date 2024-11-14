import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension CGRect {
	var maxXY: CGPoint { CGPoint(x: maxX, y: maxY) }
	var minXMaxY: CGPoint { CGPoint(x: minX, y: maxY) }
	var maxXMinY: CGPoint { CGPoint(x: maxX, y: minY) }
	var midPoint: CGPoint { CGPoint(x: midX, y: midY) }

	init<FloatNumber: BinaryFloatingPoint>(scalarOrigin: FloatNumber, scalarSize: FloatNumber) {
		self.init(origin: CGPoint(scalar: scalarOrigin), size: CGSize(scalar: scalarSize))
	}

	init(size: CGSize) {
		self.init(origin: .zero, size: size)
	}
}
