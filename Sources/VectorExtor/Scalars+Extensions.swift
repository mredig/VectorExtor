import Foundation
#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics
#endif

public extension Double {
	var cgFloat: CGFloat { CGFloat(self) }
}

public extension CGFloat {
	static var degToRadFactor = CGFloat.pi / 180
	static var radToDegFactor = 180 / CGFloat.pi

	var double: Double { Double(self) }
}

public extension BinaryFloatingPoint {
	/** Note - does NOT work on negative literals! Essentially, this is evaluated prior the negative sign (unary operator),
	so it is evaluated as if it's positive. Simple fix is to wrap value in parenthases or initializer. Works fine on variables though.

	For example:
	```
	let example: Double = -5.clipped(to: 0...10) // 5 - not what you want!
	let example: Double = Double(-5).clipped(to: 0...10) // 0 - expected behavior!

	// typical usage would be from a variable, not a literal though, so:

	let example: Double = -5
	let clipped = example.clipped(to: 0...10) // 0 - as expected
	```
	*/
	func clipped(to range: ClosedRange<Self> = 0...1) -> Self {
		Swift.max(range.lowerBound, Swift.min(self, range.upperBound))
	}
}

public extension BinaryInteger {
	/** Note - does NOT work on negative literals! Essentially, this is evaluated prior the negative sign (unary operator),
	so it is evaluated as if it's positive. Simple fix is to wrap value in parenthases or initializer. Works fine on variables though.

	For example:
	```
	let example = -5.clipped(to: 0...10) // 5 - not what you want!
	let example = (-5).clipped(to: 0...10) // 0 - expected behavior!

	// typical usage would be from a variable, not a literal though, so:

	let example = -5
	let clipped = example.clipped(to: 0...10) // 0 - as expected
	```
	*/
	func clipped(to range: ClosedRange<Self> = 0...1) -> Self {
		Swift.max(range.lowerBound, Swift.min(self, range.upperBound))
	}
}
