import Foundation
#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics
#endif

public protocol GenericTwoIndexVector {
	var indexOne: CGFloat { get set }
	var indexTwo: CGFloat { get set }

	var simd: SIMD2<Double> { get set }

	init(indexOne: CGFloat, indexTwo: CGFloat)
}

// MARK: - Basic Math
public extension GenericTwoIndexVector {
	static func + (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne + rhs.indexOne, indexTwo: lhs.indexTwo + rhs.indexTwo)
	}

	static func - (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne - rhs.indexOne, indexTwo: lhs.indexTwo - rhs.indexTwo)
	}

	static func * (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne * rhs.indexOne, indexTwo: lhs.indexTwo * rhs.indexTwo)
	}

	static func / (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne / rhs.indexOne, indexTwo: lhs.indexTwo / rhs.indexTwo)
	}

	static func + (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne + rhs, indexTwo: lhs.indexTwo + rhs)
	}

	static func - (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne - rhs, indexTwo: lhs.indexTwo - rhs)
	}

	static func * (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne * rhs, indexTwo: lhs.indexTwo * rhs)
	}

	static func / (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne / rhs, indexTwo: lhs.indexTwo / rhs)
	}

	static func += (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne += rhs.indexOne
		lhs.indexTwo += rhs.indexTwo
	}

	static func -= (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne -= rhs.indexOne
		lhs.indexTwo -= rhs.indexTwo
	}

	static func *= (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne *= rhs.indexOne
		lhs.indexTwo *= rhs.indexTwo
	}

	static func /= (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne /= rhs.indexOne
		lhs.indexTwo /= rhs.indexTwo
	}

	static func += (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne += rhs
		lhs.indexTwo += rhs
	}

	static func -= (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne -= rhs
		lhs.indexTwo -= rhs
	}

	static func *= (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne *= rhs
		lhs.indexTwo *= rhs
	}

	static func /= (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne /= rhs
		lhs.indexTwo /= rhs
	}

	static prefix func - (value: Self) -> Self {
		Self(indexOne: -value.indexOne, indexTwo: -value.indexTwo)
	}
}

@inlinable public func abs<V: GenericTwoIndexVector>(_ vector: V) -> V {
	V(indexOne: abs(vector.indexOne), indexTwo: abs(vector.indexTwo))
}

@inlinable public func negate<V: GenericTwoIndexVector>(_ vector: V) -> V {
	V(indexOne: -vector.indexOne, indexTwo: -vector.indexTwo)
}

// MARK: - Conversion
extension GenericTwoIndexVector {
	public var point: CGPoint { CGPoint(indexOne: indexOne, indexTwo: indexTwo) }
	public var vector: CGVector { CGVector(indexOne: indexOne, indexTwo: indexTwo) }
	public var size: CGSize { CGSize(indexOne: indexOne, indexTwo: indexTwo) }
	public var simd: SIMD2<Double> {
		get { SIMD2(x: indexOne, y: indexTwo) }
		set {
			indexOne = newValue.x
			indexTwo = newValue.y
		}
	}
	/// When getting, returns a SIMD3 where the x and y are populated, respectively, while the z is given 0.
	/// When setting, `indexOne` becomes the value of the SIMD3 `x`, and `indexTwo` becomes `y`
	public var simd3xy: SIMD3<Double> {
		get { SIMD3(x: indexOne, y: indexTwo, z: 0) }
		set {
			indexOne = newValue.x
			indexTwo = newValue.y
		}
	}
	/// When getting, returns a SIMD3 where the x and z are populated, respectively, while the y is given 0.
	/// When setting, `indexOne` becomes the value of the SIMD3 `x`, and `indexTwo` becomes `z`
	public var simd3xz: SIMD3<Double> {
		get { SIMD3(x: indexOne, y: 0, z: indexTwo) }
		set {
			indexOne = newValue.x
			indexTwo = newValue.z
		}
	}

}

// MARK: - Conformance
extension CGPoint: GenericTwoIndexVector {
	public var indexOne: CGFloat {
		get { x }
		set { x = newValue }
	}

	public var indexTwo: CGFloat {
		get { y }
		set { y = newValue }
	}

	public init(indexOne: CGFloat, indexTwo: CGFloat) {
		self.init(x: indexOne, y: indexTwo)
	}
}

extension CGSize: GenericTwoIndexVector {
	public var indexOne: CGFloat {
		get { width }
		set { width = newValue }
	}

	public var indexTwo: CGFloat {
		get { height }
		set { height = newValue }
	}

	public init(indexOne: CGFloat, indexTwo: CGFloat) {
		self.init(width: indexOne, height: indexTwo)
	}
}

extension CGVector: GenericTwoIndexVector {
	public var indexOne: CGFloat {
		get { dx }
		set { dx = newValue }
	}

	public var indexTwo: CGFloat {
		get { dy }
		set { dy = newValue }
	}

	public init(indexOne: CGFloat, indexTwo: CGFloat) {
		self.init(dx: indexOne, dy: indexTwo)
	}
}
