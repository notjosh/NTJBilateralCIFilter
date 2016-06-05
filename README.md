NTJBilateralCIFilter
====================

Ever wanted to play with [bilateral filtering](https://en.wikipedia.org/wiki/Bilateral_filter) inside of [Core Image](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html#//apple_ref/doc/uid/TP30001185-CH1-TPXREF101)? Well you've come to the right place.

Inside you'll find a basic toolkit for switching images, and tinkering around with parameters:

![](https://s3.amazonaws.com/f.cl.ly/items/0F0R1g0G0o211R3r0g1o/Screen%20Shot%202016-06-03%20at%206.04.26%20AM.png?v=4d2a974f)

![](https://s3.amazonaws.com/f.cl.ly/items/081f013U3u0s132E3L40/Screen%20Shot%202016-06-03%20at%206.02.57%20AM.png?v=e3f20e9c)

It's almost certainly not the fastest/best implementation out there, but for small images (< 1000px square, give or take) it's capable of running in real time.

Library Usage
=============

Inside of the project is the class `NTJBilateralCIFilter`. It extends `CIFilter`, so feel free to use it in other projects like you would any other `CIFilter`. Or take a look at `NTJBilateralFilterRunner` in the demo app for some ideas on how to load content in.

If you're manually including the code into your project, make sure to also bring `NTJBilateralCIFilter.cikernel` into your project.

The three parameters are:

 - `inputImage`: A `CIImage` to filter
 - `sigma_R`: The range of blur. Higher value = more blur. (Default value: 15)
 - `sigma_S`: The spatial parameter. Higher value = more features getting flattened. (Default value: 0.2)

 TODO
 ====

  - [ ] iOS demo (and compatibility? afaik it should Just Work™ though)