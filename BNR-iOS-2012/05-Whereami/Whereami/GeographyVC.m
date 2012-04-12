//
//  GeographyVC.m
//  05-Whereami
//
//  Created by Sam Krishna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeographyVC.h"
#import "MapPoint.h"
#import "NSDate+Helper.h"
#import <AddressBookUI/AddressBookUI.h>

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
	NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
	if (t < -180) {
		return;
	}
	
//	[self foundLocation:newLocation];
	[self foundMappedLocaton:newLocation];
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

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self findLocation];
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - Methods


//=========================================================== 
// - (void)findLocation
//
//=========================================================== 
- (void)findLocation
{
	[self.locationManager startUpdatingLocation];
	[self.activityIndicator startAnimating];
	self.locationTitleField.hidden = YES;
} //findLocation

//=========================================================== 
// - (void)foundLocation:(CLLocation *)location
//
//=========================================================== 
- (void)foundLocation:(CLLocation *)location
{
	CLLocationCoordinate2D coord = location.coordinate;
	
	// Get the date
	NSString *timestamp = [NSString stringWithFormat:@"Tagged on %@ at %@", 
												 [[NSDate date] formattedStringUsingFormat:@"dd MMM yyyy"],
												 [[NSDate date] formattedStringUsingFormat:@"hh:mm:ss"]];
	
	// Create an instance of MapPoint w/ the current data.
	MapPoint *mp = [[MapPoint alloc] initWithCoordinate:coord title:self.locationTitleField.text andSubtitle:timestamp];
	[self.worldView addAnnotation:mp];
	
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
	[self.worldView setRegion:region animated:YES];
	
	self.locationTitleField.text = @"";
	self.locationTitleField.hidden = NO;
	[self.activityIndicator stopAnimating];
	[self.locationManager stopUpdatingLocation];
} //foundLocation:


//=========================================================== 
// - (void)foundMappedLocaton:(CLLocation *)location
//
//=========================================================== 
- (void)foundMappedLocaton:(CLLocation *)location
{
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
	[geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
	{
		// Create an instance of MapPoint w/ the current data.
		NSLog(@"placemarks = %@", placemarks);
		NSLog(@"placemarks count = %d", [placemarks count]);
		CLPlacemark *placemark = [placemarks lastObject];
		NSString *name = placemark.name;
		NSLog(@"name = %@",name);
		NSString *addressString = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
		MapPoint *mp = [[MapPoint alloc] initWithCoordinate:location.coordinate title:name andSubtitle:addressString];
		[self.worldView addAnnotation:mp];
		
		MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 250, 250);
		[self.worldView setRegion:region animated:YES];
		
	}];
	
	self.locationTitleField.text = @"";
	self.locationTitleField.hidden = NO;
	[self.activityIndicator stopAnimating];
	[self.locationManager stopUpdatingLocation];
} //foundMappedLocaton:


#pragma mark - Properties
@synthesize locationManager = locationManager_;
@synthesize worldView = worldView_;
@synthesize activityIndicator = activityIndicator_;
@synthesize locationTitleField = locationTitleField_;
@end
