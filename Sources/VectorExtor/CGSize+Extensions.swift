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

public extension CGSize {
	var midPoint: CGPoint {
		normalPointToAbsolute(normalPoint: CGPoint(scalar: 0.5))
	}

	var min: CGFloat { Swift.min(width, height) }
	var max: CGFloat { Swift.max(width, height) }

	/// Given a point in UV space (0 representing the minimal dimension value, 1 representing the max), calculate the point it represents in this CGSize.
	func normalPointToAbsolute(normalPoint: CGPoint) -> CGPoint {
		(normalPoint.size * self).point
	}

	/// Convert a point from absolute space (0-size.dimension.max) to UV space (0 representing the minimal dimension value, 1 representing the max); calculate the normalized point representing it in this CGSize.
	func absolutePointToNormal(absolutePoint: CGPoint) -> CGPoint {
		(absolutePoint.size / self).point
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
