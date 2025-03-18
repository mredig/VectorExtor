import Testing
import Foundation
import VectorExtor

struct CGRectExtensionsTests {
	@Test func rectUtilities() {
		let size = CGSize(width: 10, height: 50)
		let rect = CGRect(origin: .zero, size: size)
		#expect(rect.maxXY == size.point)

		#expect(rect.midPoint == CGPoint(x: 5, y: 25))

		let orig2 = CGPoint(x: 10, y: -10)
		let rect2 = CGRect(origin: orig2, size: size)
		#expect(rect2.maxXY == (size + orig2).point)

		#expect(rect2.midPoint == CGPoint(x: 15, y: 15))

		#expect(rect.maxXMinY == CGPoint(x: 10, y: 0))
		#expect(rect.minXMaxY == CGPoint(x: 0, y: 50))

		#expect(rect2.maxXMinY == CGPoint(x: 20, y: -10))
		#expect(rect2.minXMaxY == CGPoint(x: 10, y: 40))
	}

	@Test func sizeInit() {
		let size = CGSize(width: 10, height: 50)

		#expect(CGRect(x: 0, y: 0, width: 10, height: 50) == CGRect(size: size))
	}

	@Test func scalar() {
		let scalar = CGRect(scalarOrigin: 3.5, scalarSize: 4.5)
		#expect(scalar == CGRect(x: 3.5, y: 3.5, width: 4.5, height: 4.5))
	}

	@Test(arguments: [
		(
			CGRect(scalarOrigin: 0, scalarSize: 20),
			CGRect(scalarOrigin: 0, scalarSize: 10),
			CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(scalar: 10))
		),
		(
			CGRect(scalarOrigin: -100, scalarSize: 200),
			CGRect(scalarOrigin: 0, scalarSize: 10),
			CGRect(origin: CGPoint(x: -5, y: -5), size: CGSize(scalar: 10))
		),
		(
			CGRect(origin: .zero, size: CGSize(width: 10, height: 20)),
			CGRect(origin: CGPoint(x: 3_902_875, y: 878), size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: 3, y: 9), size: CGSize(width: 4, height: 2))
		),
		(
			CGRect(origin: .zero, size: CGSize(width: 20, height: 10)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -878), size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: 8, y: 4), size: CGSize(width: 4, height: 2))
		),

		(
			CGRect(origin: .zero, size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -878), size: CGSize(width: 10, height: 20)),
			CGRect(origin: CGPoint(x: -3, y: -9), size: CGSize(width: 10, height: 20))
		),
	])
	func centering(base: CGRect, toCenter: CGRect, expected: CGRect) {
		let result = toCenter.centered(inside: base)

		#expect(expected == result)
	}

	@Test(arguments: [
		(
			CGRect(scalarOrigin: 0, scalarSize: 20),
			CGRect(scalarOrigin: 0, scalarSize: 10),
			CGRect(origin: CGPoint(x: 5, y: 0), size: CGSize(scalar: 10))
		),
		(
			CGRect(scalarOrigin: -100, scalarSize: 200),
			CGRect(scalarOrigin: 0, scalarSize: 10),
			CGRect(origin: CGPoint(x: -5, y: 0), size: CGSize(scalar: 10))
		),
		(
			CGRect(origin: .zero, size: CGSize(width: 10, height: 20)),
			CGRect(origin: CGPoint(x: 3_902_875, y: 878), size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: 3, y: 878), size: CGSize(width: 4, height: 2))
		),
		(
			CGRect(origin: .zero, size: CGSize(width: 20, height: 10)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -878), size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: 8, y: -878), size: CGSize(width: 4, height: 2))
		),

		(
			CGRect(origin: .zero, size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -878), size: CGSize(width: 10, height: 20)),
			CGRect(origin: CGPoint(x: -3, y: -878), size: CGSize(width: 10, height: 20))
		),
	])
	func centeringHorizontal(base: CGRect, toCenter: CGRect, expected: CGRect) {
		let result = toCenter.centeredHorizontally(inside: base)

		#expect(expected == result)
	}

	@Test(arguments: [
		(
			CGRect(scalarOrigin: 0, scalarSize: 20),
			CGRect(scalarOrigin: 0, scalarSize: 10),
			CGRect(origin: CGPoint(x: 0, y: 5), size: CGSize(scalar: 10))
		),
		(
			CGRect(scalarOrigin: -100, scalarSize: 200),
			CGRect(scalarOrigin: 0, scalarSize: 10),
			CGRect(origin: CGPoint(x: 0, y: -5), size: CGSize(scalar: 10))
		),
		(
			CGRect(origin: .zero, size: CGSize(width: 10, height: 20)),
			CGRect(origin: CGPoint(x: 3_902_875, y: 878), size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: 3_902_875, y: 9), size: CGSize(width: 4, height: 2))
		),
		(
			CGRect(origin: .zero, size: CGSize(width: 20, height: 10)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -878), size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: -3_902_875, y: 4), size: CGSize(width: 4, height: 2))
		),

		(
			CGRect(origin: .zero, size: CGSize(width: 4, height: 2)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -878), size: CGSize(width: 10, height: 20)),
			CGRect(origin: CGPoint(x: -3_902_875, y: -9), size: CGSize(width: 10, height: 20))
		),
	])
	func centeringVertical(base: CGRect, toCenter: CGRect, expected: CGRect) {
		let result = toCenter.centeredVerticaly(inside: base)

		#expect(expected == result)
	}
}
