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

extension CGRect {
	var maxXY: CGPoint {
		CGPoint(x: maxX, y: maxY)
	}

	var midPoint: CGPoint {
		CGPoint(x: midX, y: midY)
	}

	init<FloatNumber: BinaryFloatingPoint>(scalarOrigin: FloatNumber, scalarSize: FloatNumber) {
		self.init(origin: CGPoint(scalar: scalarOrigin), size: CGSize(scalar: scalarSize))
	}
}
