//
//  File.swift
//  
//
//  Created by Michael Redig on 3/29/20.
//

import Foundation
#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import CoreGraphics
#endif

extension CGSize {
	var point: CGPoint {
		CGPoint(x: width, y: height)
	}

	var midPoint: CGPoint {
		CGPoint(x: width / 2, y: height / 2)
	}

	static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
		CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
	}

	static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
		CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
	}

	static func + (lhs: CGSize, rhs: CGFloat) -> CGSize {
		lhs + CGSize(scalar: rhs)
	}

	static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
		CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
	}

	static func - (lhs: CGSize, rhs: CGFloat) -> CGSize {
		lhs - CGSize(scalar: rhs)
	}

	static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
		lhs + -rhs
	}

	static prefix func - (size: CGSize) -> CGSize {
		CGSize(width: -size.width, height: -size.height)
	}

	init<IntNumber: BinaryInteger>(scalar: IntNumber) {
		let value = CGFloat(scalar)
		self.init(width: value, height: value)
	}

	init<FloatNumber: BinaryFloatingPoint>(scalar: FloatNumber) {
		let value = CGFloat(scalar)
		self.init(width: value, height: value)
	}
}
