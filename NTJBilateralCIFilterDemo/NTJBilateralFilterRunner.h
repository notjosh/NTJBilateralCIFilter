//
//  NTJBilateralFilterRunner.h
//  BilateralFilter
//
//  Created by joshua may on 1/06/2016.
//  Copyright © 2016 nojo inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTJBilateralFilterRunner : NSObject

- (id)initWithImageFileURL:(NSURL *)imageFileURL;
- (void)read;
- (void)prepareAsSize:(NSSize)size;
- (NSImage *)runWithSigma_R:(double)sigma_R sigma_S:(double)sigma_S;

@end
