# VectorExtor

A set of extensions for common conversions and calculations used when dealing with CGPoint, CGRect, CGVector, CGSize, CGPath, and more.

CoreGraphics isn't available on Linux, but there's partial support for CGPoint and some of its siblings.
In this package, CGVector is the most important omission from Linux, so I've covered a basic reimplementation.
