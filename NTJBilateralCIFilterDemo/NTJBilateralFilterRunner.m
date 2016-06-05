//
//  NTJBilateralFilterRunner.m
//  BilateralFilter
//
//  Created by joshua may on 1/06/2016.
//  Copyright © 2016 nojo inc. All rights reserved.
//

#import "NTJBilateralFilterRunner.h"

@import NTJBilateralCIFilter;

@interface NTJBilateralFilterRunner ()

@property (strong) CIImage *ciImage;
@property (assign) CGImageRef cgImage;
@property (copy) NSURL *imageFileURL;

@end

@implementation NTJBilateralFilterRunner

- (id)initWithImageFileURL:(NSURL *)imageFileURL
{
    self = [super init];

    if (self) {
        _imageFileURL = imageFileURL;

        // warm up & register with CI
        [NTJBilateralCIFilter class];
    }
    
    return self;
}

- (void)dealloc
{
    CFRelease(self.cgImage);
}

- (void)read {
    CGDataProviderRef provider = CGDataProviderCreateWithURL((CFURLRef)self.imageFileURL);
    self.cgImage = CGImageCreateWithJPEGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);

    CFRelease(provider);
}

- (void)prepareAsSize:(NSSize)size {
    if (CGImageGetWidth(self.cgImage) == size.width &&
        CGImageGetHeight(self.cgImage) == size.height) {

        self.ciImage = [CIImage imageWithCGImage:self.cgImage];
    } else {
        CGContextRef context = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     CGImageGetBitsPerComponent(self.cgImage),
                                                     0,
                                                     CGImageGetColorSpace(self.cgImage),
                                                     CGImageGetBitmapInfo(self.cgImage)
                                                     );

        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGContextDrawImage(context, CGRectMake(0.f, 0.f, size.width, size.height), self.cgImage);

        CGImageRef scaledImage = CGBitmapContextCreateImage(context);

        if (scaledImage) {
            self.ciImage = [CIImage imageWithCGImage:scaledImage];
        }

        if (context) {
            CFRelease(context);
        }

        if (scaledImage) {
            CFRelease(scaledImage);
        }
    }
}

- (NSImage *)runWithSigma_R:(double)sigma_R sigma_S:(double)sigma_S
{
    if (self.ciImage) {
        CIFilter *filter = [CIFilter filterWithName:NSStringFromClass([NTJBilateralCIFilter class])];
        [filter setDefaults];
        [filter setValuesForKeysWithDictionary:@{
                                                 kCIInputImageKey: self.ciImage,
                                                 NSStringFromSelector(@selector(sigma_R)): @(sigma_R),
                                                 NSStringFromSelector(@selector(sigma_S)): @(sigma_S),
                                                 }];

        CIImage *image = [filter valueForKey:kCIOutputImageKey];

        NSCIImageRep *rep = [NSCIImageRep imageRepWithCIImage:image];
        NSImage *nsImage = [[NSImage alloc] initWithSize:rep.size];
        [nsImage addRepresentation:rep];

        return nsImage;
    }

    return nil;
}

@end
