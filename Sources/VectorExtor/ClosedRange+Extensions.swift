import Foundation
#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics
#endif

public extension ClosedRange where Bound: BinaryFloatingPoint {
	/// In a range, the value of a given relative location between bounds. For example, in the range `20...40`, the point `0.5` would be `30`
	func interpolated(at point: Double, clipped: Bool = true) -> Bound {
		let point = clipped ? Swift.max(0, Swift.min(1, point)) : point

		let normalUpper = upperBound - lowerBound
		let tValue = normalUpper * Bound(point)

		return tValue + lowerBound
	}

	/// In a range, the relative location of a value between bounds. For example, if a range were `20...40`, the value `30` would be `0.5`
	func linearPoint(of value: Bound, clipped: Bool = true) -> Double {
		let normalUpper = Double(upperBound) - Double(lowerBound)
		let normalValue = Double(value) - Double(lowerBound)
		return clipped ? Swift.min(Swift.max(normalValue / normalUpper, 0), 1) : normalValue / normalUpper
	}
}

public extension ClosedRange where Bound: BinaryInteger {
	func offset(by value: Bound) -> Self {
		let offsetUpper = upperBound + value
		let offsetLower = lowerBound + value
		return offsetLower...offsetUpper
	}
}
public extension ClosedRange where Bound: BinaryFloatingPoint {
	func offset(by value: Bound) -> Self {
		let offsetUpper = upperBound + value
		let offsetLower = lowerBound + value
		return offsetLower...offsetUpper
	}
}
