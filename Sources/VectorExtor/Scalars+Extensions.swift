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

public extension Double {
	var cgFloat: CGFloat { CGFloat(self) }
}

public extension CGFloat {
	static var degToRadFactor = CGFloat.pi / 180
	static var radToDegFactor = 180 / CGFloat.pi

	var double: Double { Double(self) }

	func clipped(to range: ClosedRange<CGFloat> = 0...1) -> CGFloat {
		Swift.max(range.lowerBound, Swift.min(self, range.upperBound))
	}
}
