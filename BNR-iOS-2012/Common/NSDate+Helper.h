//
//  NSDate+Helper.h
//  Codebook
//
//  Created by Billy Gray on 2/26/09.
//  Copyright 2009 Zetetic LLC. All rights reserved.
//
//  NSDate-Calendar.h
//  Motivator
//  Created by Jon Maddox on 11/26/08.
//
//  NSDate (Misc)
//  Created by Jeff LaMarche on 7/12/08
//
//  NSDate (NaturalDates)
//  Created by Alex Curlyo on 7/25/09

// These are a set of utility categories for NSDate
// to use for date processing. I found it helpful to compile
// them all in one place.

#import <Foundation/Foundation.h>

/*
y		Year					1, 2 or 4 'y's will show the value, 2 digit zero-padded value or 4 digit zero-padded value respectively
M		Month					1, 2, 3, 4 or 5 'M's will show the value, 2 digit zero-padded value, short name, long name or initial letter months
d		Day of Month	1 or 2 'd's will show the value or 2 digit zero-padded value representation respectively.
 
E		Weekday				1, 2, 3, 4 or 5 'e's will show the value weekday number, 2 digit zero-padded value weekday number, short name, 
									long name or initial letter respectively. Weekday numbers starts on Sunday. 
									Use lowercase 'e' for weekday numbers starting on Monday.

a		AM or PM			No repeat supported
h		Hour					1 or 2 'h's will show the value or 2 digit zero-padded value representation respectively. Use uppercase for 24 hour time.
m		Minute				1 or 2 'm's will show the value or 2 digit zero-padded value representation respectively.
s		Second				1 or 2 's's will show the value or 2 digit zero-padded value representation respectively.

z		Timezone			1, 2, 3 or 4 'z's will show short acronym, short name, long acronym, long name respectively. 
									Use uppercase to show GMT offset instead of name — 1 or 2 digit zero-padded values shows GMT or RFC 822 respectively.
*/

@interface NSDate (Helper)

- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
//- (NSUInteger)weekday;

+ (NSString *)dbFormatString;
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;

@end

@interface NSDate (Misc)

+ (NSDate *)dateWithoutTime;
- (NSDate *)dateByAddingDays:(NSInteger)numDays;
- (NSDate *)dateAsDateWithoutTime;
- (NSDate *)dateAsDateJustBeforeMidnight;
- (NSDate *)dateAsDateWithoutSeconds;
- (NSInteger)differenceInDaysTo:(NSDate *)toDate;
- (NSInteger)inclusiveDifferenceInDaysTo:(NSDate *)toDate;
- (NSString *)formattedDateString;
- (NSString *)formattedStringUsingFormat:(NSString *)dateFormat;

@end

@interface NSDate (NaturalDates) 

- (BOOL)isSameDay:(NSDate*)anotherDate;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isLastWeek;
- (NSString *)stringFromDateCapitalized:(BOOL)capitalize;

@end

@interface NSDate (Calendar)

+ (id)today;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSTimeZone *)timeZone;
- (NSInteger)weekday;
- (NSDate *)firstDayOfCurrentMonth;
- (NSDate *)firstDayOfCurrentWeek;
- (NSDate *)lastDayOfCurrentMonth;
- (BOOL)lastDayIsThirtieth;
- (BOOL)lastDayIsThirtyFirst;
- (NSDate *)dateByAddingYears:(NSInteger)years
                       months:(NSInteger)months
                         days:(NSInteger)days
                        hours:(NSInteger)hours
                      minutes:(NSInteger)minutes
                      seconds:(NSInteger)seconds;

+ (NSDate *)dateWithYear:(NSInteger)years
                   month:(NSInteger)months
                     day:(NSInteger)days
                    hour:(NSInteger)hours
                  minute:(NSInteger)minutes
                  second:(NSInteger)seconds
                timeZone:(NSTimeZone *)timeZone;

@end