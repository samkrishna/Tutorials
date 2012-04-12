//
//  MapPoint.m
//  05-Whereami
//
//  Created by Sam Krishna on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate title:(NSString *)newTitle andSubtitle:(NSString *)newSubtitle
{
	if (!(self = [super init])) return nil;
	
	coordinate_ = newCoordinate;
	self.title = newTitle;
	self.subtitle = newSubtitle;
	
	return self;
}



#pragma mark - Properties
@synthesize title = title_;
@synthesize subtitle = subtitle_;
@synthesize coordinate = coordinate_;
@end
