//
//  NTJBilateralCIFilter.m
//  BilateralFilter
//
//  Created by joshua may on 1/06/2016.
//  Copyright © 2016 nojo inc. All rights reserved.
//

#import "NTJBilateralCIFilter.h"

@implementation NTJBilateralCIFilter

static CIKernel *filterKernel = nil;

+ (void)initialize
{
    [CIFilter registerFilterName:NSStringFromClass([NTJBilateralCIFilter class])
                     constructor:(id<CIFilterConstructor>)self
                 classAttributes:@{
                                   kCIAttributeDisplayName: NSStringFromClass([NTJBilateralCIFilter class]),
                                   kCIAttributeFilterCategories: @[ kCICategoryDistortionEffect, ]
                                   }];
}

+ (CIFilter *)filterWithName:(NSString *)name
{
    return [self new];
}

- (id)init
{
    if (filterKernel == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];

        // CocoaPods
        NSURL *subBundleURL = [bundle URLForResource:@"NTJBilateralCIFilter" withExtension:@"bundle"];
        if (subBundleURL) {
            bundle = [NSBundle bundleWithURL:subBundleURL];
        }

        NSString *code = [NSString stringWithContentsOfFile:[bundle pathForResource:@"NTJBilateralCIFilter"
                                                                             ofType:@"cikernel"]
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];

        NSArray *kernels = [CIKernel kernelsWithString:code];
        filterKernel = kernels.firstObject;
    }
    
    return [super init];
}

- (NSDictionary *)customAttributes
{
    return @{
             NSStringFromSelector(@selector(sigma_R)): @{
                     kCIAttributeType: kCIAttributeTypeScalar,
                     kCIAttributeMin: @0.0,
                     kCIAttributeDefault: @15,
                     },
             NSStringFromSelector(@selector(sigma_S)): @{
                     kCIAttributeType: kCIAttributeTypeScalar,
                     kCIAttributeMin: @0.0,
                     kCIAttributeDefault: @0.2,
                     },
             };
}

- (CIImage *)outputImage
{
    CISampler *src = [CISampler samplerWithImage:self.inputImage];

    return [self apply:
            filterKernel,
            src,
            self.sigma_R,
            self.sigma_S,
            kCIApplyOptionDefinition,
            src.definition,
            nil];
}

@end
