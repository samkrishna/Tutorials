//
//  main.m
//  RandomPossesions
//
//  Created by Sam Krishna on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Possession.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	  // Create a mutable array, store its address in items variable
		NSMutableArray *items = [[NSMutableArray alloc] init];
		for (int i = 0; i < 10; i++) {
			Possession *p = [Possession randomPossession];
			[items addObject:p];
		}
		
		for (Possession *p in items) {
			NSLog(@"%@", p);
		}
		
		// Challenge problem
		@try {
			Possession *p = [items objectAtIndex:10];
			NSLog(@"%@", p);
		}
		@catch (NSException *exception) {
			NSLog(@"exception = %@", exception);
			NSLog(@"backtrace = %@", [exception callStackSymbols]);
		}
	}
	
	return 0;
}

