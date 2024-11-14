import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension CGRect {
	@inline(__always)
	var maxXY: CGPoint { CGPoint(x: maxX, y: maxY) }
	@inline(__always)
	var minXMaxY: CGPoint { CGPoint(x: minX, y: maxY) }
	@inline(__always)
	var maxXMinY: CGPoint { CGPoint(x: maxX, y: minY) }
	@inline(__always)
	var midPoint: CGPoint { CGPoint(x: midX, y: midY) }

	@inline(__always)
	init<FloatNumber: BinaryFloatingPoint>(scalarOrigin: FloatNumber, scalarSize: FloatNumber) {
		self.init(origin: CGPoint(scalar: scalarOrigin), size: CGSize(scalar: scalarSize))
	}

	@inline(__always)
	init(size: CGSize) {
		self.init(origin: .zero, size: size)
	}
}
