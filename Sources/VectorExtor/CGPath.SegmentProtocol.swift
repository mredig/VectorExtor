#if canImport(CoreGraphics)
import CoreGraphics

@available(OSX 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public extension CGPath {
	protocol SegmentProtocol {
		var _startPoint: CGPoint? { get }
		var endPoint: CGPoint { get }

		var length: Double { get }

		func split(at t: Double) -> (Self, Self)
	}
}
#endif
