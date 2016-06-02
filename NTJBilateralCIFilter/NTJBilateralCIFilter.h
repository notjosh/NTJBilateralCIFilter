//
//  NTJBilateralCIFilter.h
//  BilateralFilter
//
//  Created by joshua may on 1/06/2016.
//  Copyright © 2016 nojo inc. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface NTJBilateralCIFilter : CIFilter

@property (strong) CIImage *inputImage;
@property (strong) NSNumber *sigma_R;
@property (strong) NSNumber *sigma_S;

@end
