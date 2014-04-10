//
//  InputAppDelegate.h
//  Input
//
//  Created by Robert Shoemate on 1/15/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputViewController;

@interface InputAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    InputViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InputViewController *viewController;

@end

