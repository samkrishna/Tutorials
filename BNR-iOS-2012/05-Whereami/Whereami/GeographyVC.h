//
//  GeographyVC.h
//  05-Whereami
//
//  Created by Sam Krishna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

// I'm starting to see how bad habits are getting created around the App Delegate.
// Putting so-called "Global Functional State" into the App delegate for a real app is a BAD IDEA.
// Classes should have one and only one functional responsibility.
// An App Delegate's functional responsibility is to simply bootstrap the app into runtime mode. Period.
// CoreLocation-delegate methods should have their own delegate object (not App Delegate)
// Same w/ JSON-loading/hydration (which is what we dealt w/ on the MoCO project).
// AppDelegates are the first candidate for a refactor.

// For now we're going to create the Geography VC be both the Controller layer (for the view and MKMapView) 
// as well as provide the Model data (for the CLLocationManager). It makes conceptual sense and I don't think that
// an app's structural object graph needs to always be fully denormalized. Combining Map View controller functionality along
// with location manager data is a good conceptual fit. I just don't think it should be done in the app delegate any longer.
// 
// AND if I have an app in the future that requires Location Manager data from more than one VC,
// I should simply break out that delegate into its own model object that everyone can access.
// It won't go into the App Delegate ever again, though.

@interface GeographyVC : UIViewController
<CLLocationManagerDelegate,
MKMapViewDelegate,
UITextFieldDelegate>

@property (strong) CLLocationManager *locationManager;
@property (strong) IBOutlet MKMapView *worldView;
@property (strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong) IBOutlet UITextField *locationTitleField;

- (void)findLocation;
- (void)foundLocation:(CLLocation *)location;
- (void)foundMappedLocaton:(CLLocation *)location;

@end
