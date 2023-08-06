#if os(macOS) || os(watchOS) || os(iOS) || os(tvOS)
import Foundation
import CoreGraphics

public extension CGAffineTransform {
	var offset: CGPoint {
		CGPoint(x: tx, y: ty)
	}
}
#endif
