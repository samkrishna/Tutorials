//
//  AppDelegate.h
//  Quiz
//
//  Created by Sam Krishna on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UILabel *questionField;
@property (strong, nonatomic) IBOutlet UILabel *answerField;
@property (strong, nonatomic) IBOutlet UIWindow *window;

- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
