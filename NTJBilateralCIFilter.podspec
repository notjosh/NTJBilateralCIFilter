Pod::Spec.new do |s|
  s.name         = "NTJBilateralCIFilter"
  s.version      = "1.0.0"
  s.summary      = "Bilateral filter, implemented as a CoreImage kernel (CIKernel)"

  s.description  = <<-DESC
                    Bilateral filtering as described by Wikipedia is: "a non-linear, edge-preserving and noise-reducing smoothing filter for images."

                    Think: Gaussian blurring, but with feature detection/preservation.

                    By implementing as a `CIKernel`, it's capable of processing images (even via webcam feed) in realtime.
                   DESC

  s.homepage     = "https://github.com/notjosh/NTJBilateralCIFilter"
  s.screenshots  = "https://s3.amazonaws.com/f.cl.ly/items/0F0R1g0G0o211R3r0g1o/Screen%20Shot%202016-06-03%20at%206.04.26%20AM.png?v=4d2a974f",
                   "https://s3.amazonaws.com/f.cl.ly/items/081f013U3u0s132E3L40/Screen%20Shot%202016-06-03%20at%206.02.57%20AM.png?v=e3f20e9c"

  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author             = { "Joshua May" => "josh@notjosh.com" }
  s.social_media_url   = "http://twitter.com/notjosh"

  s.platform     = :osx

  s.source       = { :git => "https://github.com/notjosh/NTJBilateralCIFilter.git", :tag => "#{s.version}" }

  s.source_files  = "NTJBilateralCIFilter/**/*.{h,m}"

  s.resource_bundles = {
    "NTJBilateralCIFilter" => ["NTJBilateralCIFilter/**/*.cikernel"]
  }

  s.framework  = "CoreImage"
end
