# VectorExtor

A set of extensions for common conversions and calculations used when dealing with CGPoint, CGRect, CGVector, CGSize, and more.

CoreGraphics isn't available on Linux, but there's partial support for CGPoint and some of its siblings.
In this extension, CGVector is the most important omission, so I've covered a reimplementation of it as best I could.
But that should only be present on Linux as it's a reimplementation if it's elsewhere
