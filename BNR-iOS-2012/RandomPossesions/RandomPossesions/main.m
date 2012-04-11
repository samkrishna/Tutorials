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
		
		for (int i = 0; i < 10; i++) {
			NSLog(@"Possession = %@", [items objectAtIndex:i]);
		}
	}
	
	return 0;
}

