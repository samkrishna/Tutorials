//
//  AppDelegate.m
//  Whereami
//
//  Created by Sam Krishna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "GeographyVC.h"

// I'm starting to see how bad habits are getting created around the App Delegate.
// Putting so-called "Global Functional State" into the App delegate for a real app is a BAD IDEA.
// Classes should have one and only one functional responsibility.
// An App Delegate's functional responsibility is to simply bootstrap the app into runtime mode. Period.
// CoreLocation-delegate methods should have their own delegate object (not App Delegate)
// Same w/ JSON-loading/hydration (which is what we dealt w/ on the MoCO project).
// AppDelegates are the first candidate for a refactor.

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Load the nib
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	// Override point for customization after application launch.
	self.geographyVC = [[GeographyVC alloc] init];
	self.window.rootViewController = self.geographyVC;
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Methods

- (void)doSomethingWeird
{
	NSLog(@"Line 1");
	NSLog(@"Line 2");
	NSLog(@"Line 3");
}

#pragma mark - Properties
@synthesize window = _window;
@synthesize geographyVC = geographyVC_;
@end
