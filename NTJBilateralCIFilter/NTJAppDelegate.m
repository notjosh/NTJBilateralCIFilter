//
//  NTJAppDelegate.m
//  BilateralFilter
//
//  Created by Joshua May on 12/04/13.
//  Copyright (c) 2013 nojo inc. All rights reserved.
//

#import "NTJAppDelegate.h"

#import "NTJMainWindowController.h"

@interface NTJAppDelegate ()

@property (nonatomic, strong) IBOutlet NTJMainWindowController *mainWindowController;

@end

@implementation NTJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.mainWindowController showWindow:self];
}

@end
