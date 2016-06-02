//
//  NTJMainWindowController.m
//  BilateralFilter
//
//  Created by Joshua May on 12/04/13.
//  Copyright (c) 2013 nojo inc. All rights reserved.
//

#import "NTJMainWindowController.h"

#import "NTJBilateralFilterRunner.h"

#import <QuartzCore/QuartzCore.h>

NSSize sizeToAspectFitDimension(NSSize size, CGFloat dimension) {
    CGFloat ratio = size.width / size.height;

    if (ratio > 0.0) {
        // landscape
        return NSMakeSize(dimension, dimension / ratio);
    } else {
        // portrait
        return NSMakeSize(dimension / ratio, dimension);
    }

    return NSMakeSize(dimension, dimension);
}

@interface NTJMainWindowController ()

@property (nonatomic, strong) IBOutlet NSImageView *preFilterImageView;
@property (nonatomic, strong) IBOutlet NSImageView *postFilterImageView;
@property (nonatomic, strong) IBOutlet NSPopUpButton *fileURLPopUpButton;

@property (nonatomic, strong) IBOutlet NSSlider *sigmaSlider;
@property (nonatomic, strong) IBOutlet NSSlider *bSigmaSlider;

@property (nonatomic, strong) NSArray<NSURL *> *jpgs;

@property (nonatomic, assign) double sigma_R;
@property (nonatomic, assign) double sigma_S;
@property (nonatomic, assign) CGFloat sizeDimension;

@property (nonatomic, strong) NTJBilateralFilterRunner *filter;

@end

@implementation NTJMainWindowController

- (id)init {
    self = [super initWithWindowNibName:NSStringFromClass([self class])];
    if (self) {
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    NSURL *resources = [[NSBundle mainBundle] resourceURL];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:resources
                                                   includingPropertiesForKeys:nil
                                                                      options:0
                                                                        error:nil];
    self.jpgs = [files filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"path ENDSWITH[c] '.jpg'"]];

    self.sigma_R = 2;
    self.sigma_S = 0.1;
    self.sizeDimension = 200.f;

    [self.fileURLPopUpButton removeAllItems];
    [self.fileURLPopUpButton addItemsWithTitles:[self.jpgs valueForKey:@"lastPathComponent"]];

    [self whoaNewFile:nil];
}

#pragma mark - Actions

- (IBAction)whoaNewFile:(id)sender
{
    NSURL *url = self.jpgs[self.fileURLPopUpButton.indexOfSelectedItem];

    NSImage *image = [[NSImage alloc] initByReferencingURL:url];
    self.preFilterImageView.image = image;

    self.filter = [[NTJBilateralFilterRunner alloc] initWithImageFileURL:url];

    [self.filter read];

    [self whoaNewSize:sender];
}

- (IBAction)whoaNewSize:(id)sender
{
    NSSize size = sizeToAspectFitDimension(self.preFilterImageView.image.size, self.sizeDimension);
    [self.filter prepareAsSize:size];

    [self whoaNewValues:sender];
}

- (IBAction)whoaNewValues:(id)sender
{
    [self work];
}

#pragma mark - Helper

- (void)work
{
    self.postFilterImageView.image = [self.filter runWithSigma_R:self.sigma_R sigma_S:self.sigma_S];
}

@end
