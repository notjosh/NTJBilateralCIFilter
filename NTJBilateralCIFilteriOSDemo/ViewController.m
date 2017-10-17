//
//  ViewController.m
//  NTJBilateralCIFilteriOSDemo
//
//  Created by Joshua May on 17/10/17.
//  Copyright © 2017 nojo inc. All rights reserved.
//

#import "ViewController.h"

#import "NTJBilateralFilterRunner.h"

@interface ViewController ()

    @property (nonatomic, strong) IBOutlet UIImageView *imageView;
    @property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
    @property (nonatomic, strong) IBOutlet UILabel *sigma_RLabel;
    @property (nonatomic, strong) IBOutlet UILabel *sigma_SLabel;
    @property (nonatomic, strong) IBOutlet UISlider *sigma_RSlider;
    @property (nonatomic, strong) IBOutlet UISlider *sigma_SSlider;

    @property (nonatomic, strong) NSArray<NSURL *> *jpgs;

    @property (nonatomic, assign) double sigma_R;
    @property (nonatomic, assign) double sigma_S;

    @property (nonatomic, strong) NTJBilateralFilterRunner *filter;

    @end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *resources = [[NSBundle bundleForClass:[self class]] resourceURL];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:resources
                                                   includingPropertiesForKeys:nil
                                                                      options:0
                                                                        error:nil];
    self.jpgs = [files filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"path ENDSWITH[c] '.jpg'"]];

    self.sigma_R = 2;
    self.sigma_S = 0.1;

    self.sigma_RSlider.value = self.sigma_R;
    self.sigma_SSlider.value = self.sigma_S;

    [self update];

    [self updateImage];
}


- (IBAction)handleSliderDidChange:(id)sender {
    self.sigma_R = self.sigma_RSlider.value;
    self.sigma_S = self.sigma_SSlider.value;

    [self update];
}

    - (void)update {
        self.sigma_RLabel.text = [NSString stringWithFormat:@"%0.2f", self.sigma_R];
        self.sigma_SLabel.text = [NSString stringWithFormat:@"%0.2f", self.sigma_S];

        self.imageView.image = [self.filter runWithSigma_R:self.sigma_R
                                                   sigma_S:self.sigma_S];
    }

    - (void)updateImage {
        NSURL *url = self.jpgs[[self.pickerView selectedRowInComponent:0]];

        [self updateImage:url];
    }

    - (void)updateImage:(nonnull NSURL *)url {
        self.filter = [[NTJBilateralFilterRunner alloc] initWithImageFileURL:url];
        [self.filter read];
        [self.filter prepareAsSize:self.imageView.bounds.size];

        [self update];
    }
    
    @end

@implementation ViewController (UIPickerViewDataSource)

    - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
        return 1;
    }

    // returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.jpgs.count;
}

    @end

@implementation ViewController (UIPickerViewDelegate)

    - (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        return [self.jpgs[row] lastPathComponent];
    }

    - (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
        [self updateImage];
    }

@end
