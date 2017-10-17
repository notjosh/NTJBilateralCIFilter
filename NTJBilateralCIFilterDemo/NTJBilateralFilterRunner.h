//
//  NTJBilateralFilterRunner.h
//  BilateralFilter
//
//  Created by joshua may on 1/06/2016.
//  Copyright © 2016 nojo inc. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#define IMAGE NSImage
#else
#import <UIKit/UIKit.h>
#define IMAGE UIImage
#endif

@interface NTJBilateralFilterRunner : NSObject

- (id)initWithImageFileURL:(NSURL *)imageFileURL;
- (void)read;
- (void)prepareAsSize:(CGSize)size;
- (IMAGE *)runWithSigma_R:(double)sigma_R sigma_S:(double)sigma_S;

@end
