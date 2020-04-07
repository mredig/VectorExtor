//
//  File.swift
//  
//
//  Created by Michael Redig on 4/6/20.
//

import Foundation

public protocol GenericTwoIndexVector {
	var indexOne: CGFloat { get set }
	var indexTwo: CGFloat { get set }

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

// MARK: - Conversion
extension GenericTwoIndexVector {
	public var point: CGPoint { CGPoint(indexOne: indexOne, indexTwo: indexTwo) }
	public var vector: CGVector { CGVector(indexOne: indexOne, indexTwo: indexTwo) }
	public var size: CGSize { CGSize(indexOne: indexOne, indexTwo: indexTwo) }
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
