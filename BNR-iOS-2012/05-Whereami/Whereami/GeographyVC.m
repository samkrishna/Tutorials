//
//  GeographyVC.m
//  05-Whereami
//
//  Created by Sam Krishna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeographyVC.h"

@implementation GeographyVC

- (id)init
{
	if (!(self = [super initWithNibName:@"GeographyView" bundle:nil])) return nil;
	
	// Initialize the Location Manager
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.distanceFilter = kCLDistanceFilterNone;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[self.locationManager startUpdatingLocation];

	// Only works on device.
//	[self.locationManager startUpdatingHeading];
	
	return self;
}

- (void)dealloc
{
	self.locationManager.delegate = nil;
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	
	// This line won't work in -init. All view objects need to be initialized in viewDidLoad:
	// All view code needs to be initialized in the view lifecycle
	self.worldView.showsUserLocation = YES;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
		didUpdateToLocation:(CLLocation *)newLocation
					 fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"%@", newLocation);	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"Could not find location: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	NSLog(@"%@", newHeading);
}

#pragma mark - Map View Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	CLLocationCoordinate2D loc = userLocation.coordinate;
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
	[self.worldView setRegion:region animated:YES];
}

#pragma mark - Properties
@synthesize locationManager = locationManager_;
@synthesize worldView = worldView_;
@synthesize activityIndicator = activityIndicator_;
@synthesize locationTitleField = locationTitleField_;
@end
