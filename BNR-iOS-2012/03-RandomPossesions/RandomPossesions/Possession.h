//
//  Possession.h
//  RandomPossesions
//
//  Created by Sam Krishna on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Possession : NSObject

@property (copy) NSString *name;
@property (copy) NSString *serialNumber;
@property (assign) NSUInteger valueInDollars;
@property (strong, readonly) NSDate *dateCreated;

+ (Possession *)randomPossession;
- (id)initWithName:(NSString *)name valueInDollars:(NSUInteger)value serialNumber:(NSString *)sNumber;

@end
