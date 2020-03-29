//
//  File.swift
//  
//
//  Created by Michael Redig on 3/29/20.
//

// CoreGraphics isn't available on Linux, but there's partial support for CGPoint and some of its siblings.
// In this extension, CGVector is the most important omission, so I've covered a reimplementation of it as best I could.
// But that should only be present on Linux as it's a reimplementation if it's elsewhere


import Foundation
#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics
#endif

extension CGVector {
	var normalized: CGVector {
		guard !(dx == dy && dx == 0) else { return CGVector(dx: 0, dy: 1) }
		let distance = sqrt(dx * dx + dy * dy)
		return CGVector(dx: dx / distance, dy: dy / distance)
	}

	var inverted: CGVector {
		CGVector(dx: -dx, dy: -dy)
	}

	var point: CGPoint {
		CGPoint(x: dx, y: dy)
	}

	var isNormal: Bool {
		CGPoint.zero.distance(to: self.point, is: 1.0)
	}

	static func + (lhs: CGVector, rhs: CGVector) -> CGVector {
		CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
	}

	static func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
		CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
	}

	/// 0 is facing right (towards 3 o'Clock). Moves CCW
	init(fromRadian radian: CGFloat) {
		self.init(dx: cos(radian), dy: sin(radian))
	}

	/// 0 is facing right (towards 3 o'Clock). Moves CCW
	init(fromDegree degree: CGFloat) {
		self.init(fromRadian: degree * (CGFloat.pi / 180))
	}

	init<IntNumber: BinaryInteger>(scalar: IntNumber) {
		let value = CGFloat(scalar)
		self.init(dx: value, dy: value)
	}

	init<FloatNumber: BinaryFloatingPoint>(scalar: FloatNumber) {
		let value = CGFloat(scalar)
		self.init(dx: value, dy: value)
	}
}

extension CGVector: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(dx)
		hasher.combine(dy)
	}
}

#if os(Linux)
public struct CGVector {
	public var dx: CGFloat
	public var dy: CGFloat
}

extension CGVector {
	public static let zero = CGVector(dx: 0, dy: 0)
	public init(dx: Int, dy: Int) {
		self.init(dx: CGFloat(dx), dy: CGFloat(dy))
	}
	public init(dx: Double, dy: Double) {
		self.init(dx: CGFloat(dx), dy: CGFloat(dy))
	}
}

extension CGVector: Equatable, CustomDebugStringConvertible {
	public var debugDescription: String {
		"(dx: \(dx), dy: \(dy))"
	}
}

extension CGVector: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.dx = try container.decode(CGFloat.self)
		self.dy = try container.decode(CGFloat.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(dx)
		try container.encode(dy)
	}
}

#endif
