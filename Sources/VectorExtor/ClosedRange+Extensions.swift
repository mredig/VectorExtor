import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension ClosedRange where Bound: BinaryFloatingPoint {
	// using `@_disfavoredOverload` to help prioritize using the renamed method going forward, but not break existing
	// explicit calls to the old version

	@_disfavoredOverload
	@available(*, deprecated, renamed: "interpolated(at:clamped:)", message: "Use `clamped` variant")
	func interpolated(at point: Bound, clipped: Bool) -> Bound {
		interpolated(at: point, clamped: clipped)
	}

	/// In a range, the value of a given relative location between bounds. For example, in the range `20...40`, the point `0.5` would be `30`
	@inline(__always)
	func interpolated(at point: Bound, clamped: Bool = true) -> Bound {
		let point = clamped ? Swift.max(0, Swift.min(1, point)) : point

		let normalUpper = upperBound - lowerBound
		let tValue = normalUpper * Bound(point)

		return tValue + lowerBound
	}

	@_disfavoredOverload
	@available(*, deprecated, renamed: "linearPoint(of:clamped:)", message: "Use `clamped` variant")
	func linearPoint(of value: Bound, clipped: Bool) -> Bound {
		linearPoint(of: value, clamped: clipped)
	}

	/// In a range, the relative location of a value between bounds. For example, if a range were `20...40`, the value `30` would be `0.5`
	@inline(__always)
	func linearPoint(of value: Bound, clamped: Bool = true) -> Bound {
		let normalUpper = Bound(upperBound) - Bound(lowerBound)
		let normalValue = Bound(value) - Bound(lowerBound)
		return clamped ? Swift.min(Swift.max(normalValue / normalUpper, 0), 1) : normalValue / normalUpper
	}
}

public extension ClosedRange where Bound: Numeric {
	@inline(__always)
	func offset(by value: Bound) -> Self {
		let offsetUpper = upperBound + value
		let offsetLower = lowerBound + value
		return offsetLower...offsetUpper
	}
}
