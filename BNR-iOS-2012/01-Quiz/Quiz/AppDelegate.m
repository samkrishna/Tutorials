//
//  AppDelegate.m
//  Quiz
//
//  Created by Sam Krishna on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (assign) NSUInteger currentQuestionIndex;
@property (strong, nonatomic, readonly) NSMutableArray *questions;
@property (strong, nonatomic, readonly) NSMutableArray *answers;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MainWindow" owner:self options:nil];
	self.window = [nibs lastObject];
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

#pragma mark - Lifecycle

- (id)init
{
	if (!(self = [super init])) return nil;
	
	self.currentQuestionIndex = 0; // Don't need to do this, but we should be explicit while learning.
	questions_ = [[NSMutableArray alloc] init];
	answers_ = [[NSMutableArray alloc] init];

	[self.questions addObject:@"What is 7 + 7?"];
	[self.answers addObject:@"14"];
	
	[self.questions addObject:@"What is the capital of North Carolina?"];
	[self.answers addObject:@"Raleigh"];
	
	[self.questions addObject:@"From what is cognac made?"];
	[self.answers addObject:@"Grapes"];
	
	return self;
}

#pragma mark - Actions

- (IBAction)showQuestion:(id)sender
{
	// Step to next question
	self.currentQuestionIndex++;
	
	// Am I past the last question?
	if (self.currentQuestionIndex == [self.questions count]) {
		self.currentQuestionIndex = 0;
	}
	
	// Get the string at the index in the questions array
	NSString *question = [self.questions objectAtIndex:self.currentQuestionIndex];
	NSLog(@"Displaying question: %@", question);
	
	self.questionField.text = question;
	self.answerField.text = @"???";
}

- (IBAction)showAnswer:(id)sender
{
	NSString *answer = [self.answers objectAtIndex:self.currentQuestionIndex];
	self.answerField.text = answer;
}


#pragma mark - Properties
@synthesize currentQuestionIndex = currentQuestionIndex_;
@synthesize questions = questions_;
@synthesize answers = answers_;
@synthesize questionField = questionField_;
@synthesize answerField = answerField_;
@synthesize window = window_;
@end
