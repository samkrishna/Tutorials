//
//  AppDelegate.h
//  Whereami
//
//  Created by Sam Krishna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class GeographyVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong) GeographyVC *geographyVC;
@property (strong, nonatomic) IBOutlet UIWindow *window;

- (void)doSomethingWeird;

@end
