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

#if !os(Linux)
extension CGAffineTransform {
	var offset: CGPoint {
		CGPoint(x: tx, y: ty)
	}
}
#endif
