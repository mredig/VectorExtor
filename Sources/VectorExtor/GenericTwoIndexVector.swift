import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public protocol GenericTwoIndexVector {
	@inlinable
	var indexOne: CGFloat { get set }
	@inlinable
	var indexTwo: CGFloat { get set }

	@inlinable
	var simd: SIMD2<Double> { get set }

	@inlinable
	init(indexOne: CGFloat, indexTwo: CGFloat)
}

// MARK: - Basic Math
public extension GenericTwoIndexVector {
	@inlinable
	static func + (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne + rhs.indexOne, indexTwo: lhs.indexTwo + rhs.indexTwo)
	}

	@inlinable
	static func - (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne - rhs.indexOne, indexTwo: lhs.indexTwo - rhs.indexTwo)
	}

	@inlinable
	static func * (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne * rhs.indexOne, indexTwo: lhs.indexTwo * rhs.indexTwo)
	}

	@inlinable
	static func / (lhs: Self, rhs: GenericTwoIndexVector) -> Self {
		Self.init(indexOne: lhs.indexOne / rhs.indexOne, indexTwo: lhs.indexTwo / rhs.indexTwo)
	}

	@inlinable
	static func + (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne + rhs, indexTwo: lhs.indexTwo + rhs)
	}

	@inlinable
	static func - (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne - rhs, indexTwo: lhs.indexTwo - rhs)
	}

	@inlinable
	static func * (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne * rhs, indexTwo: lhs.indexTwo * rhs)
	}

	@inlinable
	static func / (lhs: Self, rhs: CGFloat) -> Self {
		Self.init(indexOne: lhs.indexOne / rhs, indexTwo: lhs.indexTwo / rhs)
	}

	@inlinable
	static func += (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne += rhs.indexOne
		lhs.indexTwo += rhs.indexTwo
	}

	@inlinable
	static func -= (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne -= rhs.indexOne
		lhs.indexTwo -= rhs.indexTwo
	}

	@inlinable
	static func *= (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne *= rhs.indexOne
		lhs.indexTwo *= rhs.indexTwo
	}

	@inlinable
	static func /= (lhs: inout Self, rhs: GenericTwoIndexVector) {
		lhs.indexOne /= rhs.indexOne
		lhs.indexTwo /= rhs.indexTwo
	}

	@inlinable
	static func += (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne += rhs
		lhs.indexTwo += rhs
	}

	@inlinable
	static func -= (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne -= rhs
		lhs.indexTwo -= rhs
	}

	@inlinable
	static func *= (lhs: inout Self, rhs: CGFloat) {
		lhs.indexOne *= rhs
		lhs.indexTwo *= rhs
	}

	@inlinable
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
	@inlinable
	public var point: CGPoint { CGPoint(indexOne: indexOne, indexTwo: indexTwo) }
	@inlinable
	public var vector: CGVector { CGVector(indexOne: indexOne, indexTwo: indexTwo) }
	@inlinable
	public var size: CGSize { CGSize(indexOne: indexOne, indexTwo: indexTwo) }
	@inlinable
	public var simd: SIMD2<Double> {
		get { SIMD2(x: indexOne, y: indexTwo) }
		set {
			indexOne = newValue.x
			indexTwo = newValue.y
		}
	}
	/// When getting, returns a SIMD3 where the x and y are populated, respectively, while the z is given 0.
	/// When setting, `indexOne` becomes the value of the SIMD3 `x`, and `indexTwo` becomes `y`
	@inlinable
	public var simd3xy: SIMD3<Double> {
		get { SIMD3(x: indexOne, y: indexTwo, z: 0) }
		set {
			indexOne = newValue.x
			indexTwo = newValue.y
		}
	}
	/// When getting, returns a SIMD3 where the x and z are populated, respectively, while the y is given 0.
	/// When setting, `indexOne` becomes the value of the SIMD3 `x`, and `indexTwo` becomes `z`
	@inlinable
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
	@inlinable
	public var indexOne: CGFloat {
		get { x }
		set { x = newValue }
	}

	@inlinable
	public var indexTwo: CGFloat {
		get { y }
		set { y = newValue }
	}

	@inlinable
	public init(indexOne: CGFloat, indexTwo: CGFloat) {
		self.init(x: indexOne, y: indexTwo)
	}
}

extension CGSize: GenericTwoIndexVector {
	@inlinable
	public var indexOne: CGFloat {
		get { width }
		set { width = newValue }
	}

	@inlinable
	public var indexTwo: CGFloat {
		get { height }
		set { height = newValue }
	}

	@inlinable
	public init(indexOne: CGFloat, indexTwo: CGFloat) {
		self.init(width: indexOne, height: indexTwo)
	}
}

extension CGVector: GenericTwoIndexVector {
	@inlinable
	public var indexOne: CGFloat {
		get { dx }
		set { dx = newValue }
	}

	@inlinable
	public var indexTwo: CGFloat {
		get { dy }
		set { dy = newValue }
	}

	@inlinable
	public init(indexOne: CGFloat, indexTwo: CGFloat) {
		self.init(dx: indexOne, dy: indexTwo)
	}
}
