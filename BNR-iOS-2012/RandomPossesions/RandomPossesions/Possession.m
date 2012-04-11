//
//  Possession.m
//  RandomPossesions
//
//  Created by Sam Krishna on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Possession.h"

@implementation Possession

+ (Possession *)randomPossession
{
	NSArray *adjectiveList = [NSArray arrayWithObjects:@"Fluffy", @"Rusty", @"Shiny", nil];
	NSArray *nounList = [NSArray arrayWithObjects:@"Bear", @"Spork", @"Mac", nil];
	int adjIndex = rand() % [adjectiveList count];
	int nounIndex = rand() % [nounList count];
	NSString *name = [NSString stringWithFormat:@"%@ %@", [adjectiveList objectAtIndex:adjIndex], [nounList objectAtIndex:nounIndex]];
	int rValue = rand() % 100;
	NSString *rSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 
														 '0' + rand() % 10,
														 'A' + rand() % 26,
														 '0' + rand() % 10,
														 'A' + rand() % 26,
														 '0' + rand() % 10];
	Possession *p = [[Possession alloc] initWithName:name valueInDollars:rValue serialNumber:rSerialNumber];
	return p;
}

- (id)init
{
	if (!(self = [self initWithName:@"<Possession>" valueInDollars:0 serialNumber:@"<serial number>"])) return nil;
	
	return self;
}

- (id)initWithName:(NSString *)name valueInDollars:(NSUInteger)value serialNumber:(NSString *)sNumber
{
	// BNR uses this as the root call of the initializer chain. Good to know.
	if (!(self = [super init])) return nil;
	
	self.name = name;
	self.valueInDollars = value;
	self.serialNumber = sNumber;
	dateCreated_ = [NSDate date];
	
	return self;
}

- (NSString *)description
{
	NSString *descString = [NSString stringWithFormat:@"name: %@ dateCreated: %@ serialNumber: %@ Worth: $%lu", 
													self.name, 
													self.dateCreated, 
													self.serialNumber, 
													self.valueInDollars];
	return descString;
}

#pragma mark - Properties
@synthesize name = name_;
@synthesize serialNumber = serialNumber_;
@synthesize valueInDollars = valueInDollars_;
@synthesize dateCreated = dateCreated_;
@end
