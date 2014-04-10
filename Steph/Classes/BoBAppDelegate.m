//
//  BoBAppDelegate.m
//  BoB
//
//  Created by Eric Duhon on 1/12/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "BoBAppDelegate.h"
#import "EAGLView.h"

@implementation BoBAppDelegate

@synthesize window;
@synthesize glView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	glView.animationInterval = 1.0 / 60.0;
	[glView startAnimation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 5.0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 60.0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[glView applicationTerminated];
}

- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}

@end
