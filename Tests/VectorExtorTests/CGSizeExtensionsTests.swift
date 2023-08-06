import XCTest
import VectorExtor

class CGSizeExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCGSizeUtilities() {
		let sizeA = CGSize(width: 3, height: 4)
		let sizeB = CGSize(width: 10, height: 15)

		XCTAssertEqual(-sizeA, CGSize(width: -3, height: -4))

		let size2 = sizeA * 2
		XCTAssertEqual(size2, CGSize(width: 6, height: 8))

		let sizePlus2 = sizeA + 2
		XCTAssertEqual(sizePlus2, CGSize(width: 5, height: 6))

		let sizeMinus2 = sizeA - 2
		XCTAssertEqual(sizeMinus2, CGSize(width: 1, height: 2))

		let sizeAB = sizeA + sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 13, height: 19))

		let sizeAMinusB = sizeA - sizeB
		XCTAssertEqual(sizeAMinusB, CGSize(width: -7, height: -11))

		let sizeC = sizeA * sizeB
		XCTAssertEqual(sizeC, CGSize(width: 30, height: 60))

		let point = sizeA.point
		XCTAssertEqual(point, CGPoint(x: 3, y: 4))

		let scalar3 = CGSize(scalar: 3)
		let scalar35 = CGSize(scalar: 3.5)
		XCTAssertEqual(scalar3, CGSize(width: 3, height: 3))
		XCTAssertEqual(scalar35, CGSize(width: 3.5, height: 3.5))

		XCTAssertEqual(sizeA.midPoint, CGPoint(x: 1.5, y: 2))
	}

	func testDivision() {
		let sizeA = CGSize(width: 22, height: 45)
		let sizeB = CGSize(width: 2, height: 15)

		let sizeC = CGSize(scalar: 2)

		XCTAssertEqual(CGSize(width: 11, height: 3), sizeA / sizeB)
		XCTAssertEqual(CGSize(width: 11, height: 22.5), sizeA / sizeC)
		XCTAssertEqual(CGSize(width: 11, height: 22.5), sizeA / 2)
	}

	func testNormalizationConversion() {
		let size = CGSize(width: 100, height: 50)

		let normalA = CGPoint(x: 0.9, y: 0.1)
		let absA = CGPoint(x: 90, y: 5)

		let normalB = CGPoint(x: 0.1, y: 0.8)
		let absB = CGPoint(x: 10, y: 40)

		XCTAssertEqual(absA, size.normalPointToAbsolute(normalPoint: normalA))
		XCTAssertEqual(normalA, size.absolutePointToNormal(absolutePoint: absA))

		XCTAssertEqual(absB, size.normalPointToAbsolute(normalPoint: normalB))
		XCTAssertEqual(normalB, size.absolutePointToNormal(absolutePoint: absB))
	}

	func testCGSizeOperands() {
		let sizeA = CGSize(width: 5, height: 7)
		let sizeB = CGSize(width: 2.5, height: 5)

		// test negate
		XCTAssertEqual(-sizeA, CGSize(width: -5, height: -7))

		// cgsize with cgsize compuation tests
		XCTAssertEqual(sizeA + sizeB, CGSize(width: 7.5, height: 12))
		var sizeAB = sizeA
		sizeAB += sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 7.5, height: 12))

		XCTAssertEqual(sizeA - sizeB, CGSize(width: 2.5, height: 2))
		sizeAB = sizeA
		sizeAB -= sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 2.5, height: 2))

		XCTAssertEqual(sizeA * sizeB, CGSize(width: 12.5, height: 35))
		sizeAB = sizeA
		sizeAB *= sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 12.5, height: 35))

		XCTAssertEqual(sizeA / sizeB, CGSize(width: 2, height: 1.4))
		sizeAB = sizeA
		sizeAB /= sizeB
		XCTAssertEqual(sizeAB, CGSize(width: 2, height: 1.4))

		// cgsize with cgvector computation tests
		let bVector = sizeB.vector
		XCTAssertEqual(sizeA + bVector, CGSize(width: 7.5, height: 12))
		sizeAB = sizeA
		sizeAB += bVector
		XCTAssertEqual(sizeAB, CGSize(width: 7.5, height: 12))

		XCTAssertEqual(sizeA - bVector, CGSize(width: 2.5, height: 2))
		sizeAB = sizeA
		sizeAB -= bVector
		XCTAssertEqual(sizeAB, CGSize(width: 2.5, height: 2))

		XCTAssertEqual(sizeA * bVector, CGSize(width: 12.5, height: 35))
		sizeAB = sizeA
		sizeAB *= bVector
		XCTAssertEqual(sizeAB, CGSize(width: 12.5, height: 35))

		XCTAssertEqual(sizeA / bVector, CGSize(width: 2, height: 1.4))
		sizeAB = sizeA
		sizeAB /= bVector
		XCTAssertEqual(sizeAB, CGSize(width: 2, height: 1.4))

		// cgsize with cgpoint computation tests
		let bPoint = sizeB.point
		XCTAssertEqual(sizeA + bPoint, CGSize(width: 7.5, height: 12))
		sizeAB = sizeA
		sizeAB += bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 7.5, height: 12))

		XCTAssertEqual(sizeA - bPoint, CGSize(width: 2.5, height: 2))
		sizeAB = sizeA
		sizeAB -= bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 2.5, height: 2))

		XCTAssertEqual(sizeA * bPoint, CGSize(width: 12.5, height: 35))
		sizeAB = sizeA
		sizeAB *= bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 12.5, height: 35))

		XCTAssertEqual(sizeA / bPoint, CGSize(width: 2, height: 1.4))
		sizeAB = sizeA
		sizeAB /= bPoint
		XCTAssertEqual(sizeAB, CGSize(width: 2, height: 1.4))

		// cgfloat computation tests
		let cgFloatValue: CGFloat = 5
		XCTAssertEqual(sizeA + cgFloatValue, CGSize(width: 10, height: 12))
		var pointCGFloat = sizeA
		pointCGFloat += cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 10, height: 12))

		XCTAssertEqual(sizeA - cgFloatValue, CGSize(width: 0, height: 2))
		pointCGFloat = sizeA
		pointCGFloat -= cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 0, height: 2))

		XCTAssertEqual(sizeA * cgFloatValue, CGSize(width: 25, height: 35))
		pointCGFloat = sizeA
		pointCGFloat *= cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 25, height: 35))

		XCTAssertEqual(sizeA / cgFloatValue, CGSize(width: 1, height: 1.4))
		pointCGFloat = sizeA
		pointCGFloat /= cgFloatValue
		XCTAssertEqual(pointCGFloat, CGSize(width: 1, height: 1.4))
	}

	func testSizeMinMax() {
		let sizeA = CGSize(width: 5, height: 7)
		let sizeB = CGSize(width: 2.5, height: 5)

		XCTAssertEqual(sizeA.min, 5)
		XCTAssertEqual(sizeA.max, 7)
		XCTAssertEqual(sizeB.min, 2.5)
		XCTAssertEqual(sizeB.max, 5)
	}

	func testAspectRatio() {
		XCTAssertEqual(2, CGSize(width: 10, height: 5).aspectRatio)
		XCTAssertEqual(4/3.0, CGSize(width: 4, height: 3).aspectRatio)
		XCTAssertEqual(1.3333, CGSize(width: 4, height: 3).aspectRatio, accuracy: 0.01)
		XCTAssertEqual(0, CGSize(width: 4, height: 0).aspectRatio)
		XCTAssertEqual(1.5, CGSize(width: 6000, height: 4000).aspectRatio)
	}

	func testScalingToFit() {
		let startLandscapeSize = CGSize(width: 1920, height: 1080)
		let startSquareSize = CGSize(scalar: 500)
		let startPortraitSize = CGSize(width: 3000, height: 4000)

		let fitInSquare = CGSize(scalar: 300)
		let fitInPortraitARect = CGSize(width: 200, height: 400)
		let fitInPortraitBRect = CGSize(width: 200, height: 220)
		let fitInLandscapeRect = CGSize(width: 500, height: 100)

		// landscape in square
		XCTAssertEqual(CGSize(width: 300, height: 168.75), startLandscapeSize.scaledToFit(within: fitInSquare))

		// landscape in portrait
		XCTAssertEqual(CGSize(width: 200, height: 112.5), startLandscapeSize.scaledToFit(within: fitInPortraitARect))

		// landscape in landscape
		let expectedLandscapeToLandscape = CGSize(width: 177.7777777778, height: 100)
		let resultingLandscapeToLandscape = startLandscapeSize.scaledToFit(within: fitInLandscapeRect)
		XCTAssertEqual(expectedLandscapeToLandscape.width, resultingLandscapeToLandscape.width, accuracy: 0.001)
		XCTAssertEqual(expectedLandscapeToLandscape.height, resultingLandscapeToLandscape.height, accuracy: 0.001)


		// square in square
		XCTAssertEqual(CGSize(scalar: 300), startSquareSize.scaledToFit(within: fitInSquare))

		// square in portrait
		XCTAssertEqual(CGSize(scalar: 200), startSquareSize.scaledToFit(within: fitInPortraitARect))

		// square in landscape
		XCTAssertEqual(CGSize(scalar: 100), startSquareSize.scaledToFit(within: fitInLandscapeRect))


		// portrait in square
		XCTAssertEqual(CGSize(width: 225, height: 300), startPortraitSize.scaledToFit(within: fitInSquare))

		// portrait in portrait
		let expectedPortraitToPortraitA = CGSize(width: 200, height: 266.66666667)
		let resultingPortraitToPortraitA = startPortraitSize.scaledToFit(within: fitInPortraitARect)
		XCTAssertEqual(expectedPortraitToPortraitA.width, resultingPortraitToPortraitA.width, accuracy: 0.001)
		XCTAssertEqual(expectedPortraitToPortraitA.height, resultingPortraitToPortraitA.height, accuracy: 0.001)
		XCTAssertEqual(CGSize(width: 165, height: 220), startPortraitSize.scaledToFit(within: fitInPortraitBRect))

		// portrait in landscape
		XCTAssertEqual(CGSize(width: 75, height: 100), startPortraitSize.scaledToFit(within: fitInLandscapeRect))

		// scale up
		XCTAssertEqual(CGSize(width: 1920, height: 384), fitInLandscapeRect.scaledToFit(within: startLandscapeSize))
	}

	func testScaleDownToFit() {
		let startLandscapeSize = CGSize(width: 1920, height: 1080)
		let startSquareSize = CGSize(scalar: 500)
		let startPortraitSize = CGSize(width: 3000, height: 4000)

		let fitInSquare = CGSize(scalar: 300)
		let fitInPortraitRect = CGSize(width: 200, height: 400)
		let fitInLandscapeRect = CGSize(width: 500, height: 100)

		// landscape in square
		XCTAssertEqual(CGSize(width: 300, height: 168.75), startLandscapeSize.scaledDownToFit(within: fitInSquare))

		// square in portrait
		XCTAssertEqual(CGSize(scalar: 200), startSquareSize.scaledDownToFit(within: fitInPortraitRect))

		// portrait in landscape
		XCTAssertEqual(CGSize(width: 75, height: 100), startPortraitSize.scaledDownToFit(within: fitInLandscapeRect))

		// scale up
		XCTAssertEqual(fitInLandscapeRect, fitInLandscapeRect.scaledDownToFit(within: startLandscapeSize))
	}

	func testScalingToFill() {
		let startLandscapeSize = CGSize(width: 1920, height: 1080)
		let startSquareSize = CGSize(scalar: 500)
		let startPortraitSize = CGSize(width: 3000, height: 4000)

		let fillInSquare = CGSize(scalar: 300)
		let fillInPortraitARect = CGSize(width: 200, height: 400)
		let fillInPortraitBRect = CGSize(width: 200, height: 220)
		let fillInLandscapeRect = CGSize(width: 500, height: 100)

		// landscape in square
		let expectedLToS = CGSize(width: 533.33333333, height: 300)
		let resultLToS = startLandscapeSize.scaledToFill(size: fillInSquare)
		XCTAssertEqual(expectedLToS.width, resultLToS.width, accuracy: 0.001)
		XCTAssertEqual(expectedLToS.height, resultLToS.height, accuracy: 0.001)

		// landscape in portrait
		let expectedLToP = CGSize(width: 711.1111111, height: 400)
		let resultLToP = startLandscapeSize.scaledToFill(size: fillInPortraitARect)
		XCTAssertEqual(expectedLToP.width, resultLToP.width, accuracy: 0.001)
		XCTAssertEqual(expectedLToP.height, resultLToP.height, accuracy: 0.001)

		// landscape in landscape
		let expectedLandscapeToLandscape = CGSize(width: 500, height: 281.25)
		let resultingLandscapeToLandscape = startLandscapeSize.scaledToFill(size: fillInLandscapeRect)
		XCTAssertEqual(expectedLandscapeToLandscape.width, resultingLandscapeToLandscape.width, accuracy: 0.001)
		XCTAssertEqual(expectedLandscapeToLandscape.height, resultingLandscapeToLandscape.height, accuracy: 0.001)


		// square in square
		XCTAssertEqual(CGSize(scalar: 300), startSquareSize.scaledToFill(size: fillInSquare))

		// square in portrait
		XCTAssertEqual(CGSize(scalar: 400), startSquareSize.scaledToFill(size: fillInPortraitARect))

		// square in landscape
		XCTAssertEqual(CGSize(scalar: 500), startSquareSize.scaledToFill(size: fillInLandscapeRect))


		// portrait in square
		XCTAssertEqual(CGSize(width: 300, height: 400), startPortraitSize.scaledToFill(size: fillInSquare))

		// portrait in portrait
		XCTAssertEqual(CGSize(width: 300, height: 400), startPortraitSize.scaledToFill(size: fillInPortraitARect))
		let expectedPToPB = CGSize(width: 200, height: 266.66666667)
		let resultingPToPB = startPortraitSize.scaledToFill(size: fillInPortraitBRect)
		XCTAssertEqual(expectedPToPB.width, resultingPToPB.width, accuracy: 0.001)
		XCTAssertEqual(expectedPToPB.height, resultingPToPB.height, accuracy: 0.001)

		// portrait in landscape
		let expectedPToL = CGSize(width: 500, height: 666.66666667)
		let resultingPToL = startPortraitSize.scaledToFill(size: fillInLandscapeRect)
		XCTAssertEqual(expectedPToL.width, resultingPToL.width, accuracy: 0.001)
		XCTAssertEqual(expectedPToL.height, resultingPToL.height, accuracy: 0.001)

		// scale up
		XCTAssertEqual(CGSize(width: 5400, height: 1080), fillInLandscapeRect.scaledToFill(size: startLandscapeSize))
	}

	func testScaleDownToFill() {
		let startLandscapeSize = CGSize(width: 1920, height: 1080)
		let startSquareSize = CGSize(scalar: 500)
		let startPortraitSize = CGSize(width: 3000, height: 4000)

		let fillInSquare = CGSize(scalar: 300)
		let fillInPortraitRect = CGSize(width: 200, height: 400)
		let fillInLandscapeRect = CGSize(width: 500, height: 100)

		// landscape in square
		let expectedLToS = CGSize(width: 533.33333333, height: 300)
		let resultLToS = startLandscapeSize.scaledDownToFill(size: fillInSquare)
		XCTAssertEqual(expectedLToS.width, resultLToS.width, accuracy: 0.001)
		XCTAssertEqual(expectedLToS.height, resultLToS.height, accuracy: 0.001)

		// square in portrait
		XCTAssertEqual(CGSize(scalar: 400), startSquareSize.scaledDownToFill(size: fillInPortraitRect))

		// portrait in landscape
		let expectedPToL = CGSize(width: 500, height: 666.66666667)
		let resultingPToL = startPortraitSize.scaledToFill(size: fillInLandscapeRect)
		XCTAssertEqual(expectedPToL.width, resultingPToL.width, accuracy: 0.001)
		XCTAssertEqual(expectedPToL.height, resultingPToL.height, accuracy: 0.001)

		// scale up
		XCTAssertEqual(fillInLandscapeRect, fillInLandscapeRect.scaledDownToFill(size: startLandscapeSize))
	}
}
