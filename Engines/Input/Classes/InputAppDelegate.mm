//
//  InputAppDelegate.m
//  Input
//
//  Created by Robert Shoemate on 1/15/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "InputAppDelegate.h"
#import "InputViewController.h"

@implementation InputAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
