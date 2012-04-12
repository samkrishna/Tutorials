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

//  SK NOTE (1.24.2012): I removed all the pre-ARC code b/c NSDate is now (like everything else
//  in Apple) ARC-ified. A pre-ARC category will fail on an ARC class even if you turn off
//  the ARC code (by using the compiler flag -fno-objc-arc in the Compile Sources phase of the project).
//  If there was a #if for ARC, I'd put that in here for backwards-compatibility.

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

/*
 * This guy can be a little unreliable and produce unexpected results,
 * you're better off using daysAgoAgainstMidnight
 */
- (NSUInteger)daysAgo {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSDayCalendarUnit) 
                                             fromDate:self
                                               toDate:[NSDate date]
                                              options:0];
	return [components day];
}

- (NSUInteger)daysAgoAgainstMidnight {
	// get a midnight version of ourself:
	NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
	[mdf setDateFormat:@"yyyy-MM-dd"];
	NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
//	[mdf release];
	
	return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
	return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
	NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
	NSString *text = nil;
	switch (daysAgo) {
		case 0:
			text = @"Today";
			break;
		case 1:
			text = @"Yesterday";
			break;
		default:
			text = [NSString stringWithFormat:@"%d days ago", daysAgo];
	}
	return text;
}

/*
- (NSUInteger)weekday {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
	return [weekdayComponents weekday];
}
*/

+ (NSString *)dbFormatString {
	return @"yyyy-MM-dd HH:mm:ss";
}

+ (NSDate *)dateFromString:(NSString *)string {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:[NSDate dbFormatString]];
	NSDate *date = [inputFormatter dateFromString:string];
//	[inputFormatter release];
	return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:format];
	NSString *timestamp_str = [outputFormatter stringFromDate:date];
//	[outputFormatter release];
	return timestamp_str;
}

+ (NSString *)stringFromDate:(NSDate *)date {
	return [NSDate stringFromDate:date withFormat:[NSDate dbFormatString]];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
	/* 
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
	
	NSDate *today = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) 
                                                   fromDate:today];
	
	NSDate *midnight = [calendar dateFromComponents:offsetComponents];
	
	NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
	NSString *displayString = nil;
	
	// comparing against midnight
	if ([date compare:midnight] == NSOrderedDescending) {
		if (prefixed) {
			[displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
		} else {
			[displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
		}
	} else {
		// check if date is within last 7 days
		NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
		[componentsToSubtract setDay:-7];
		NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
//		[componentsToSubtract release];
		if ([date compare:lastweek] == NSOrderedDescending) {
			[displayFormatter setDateFormat:@"EEEE"]; // Tuesday
		} else {
			// check if same calendar year
			NSInteger thisYear = [offsetComponents year];
			
			NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) 
														   fromDate:date];
			NSInteger thatYear = [dateComponents year];			
			if (thatYear >= thisYear) {
				[displayFormatter setDateFormat:@"MMM d"];
			} else {
				[displayFormatter setDateFormat:@"MMM d, YYYY"];
			}
		}
		if (prefixed) {
			NSString *dateFormat = [displayFormatter dateFormat];
			NSString *prefix = @"'on' ";
			[displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}
	
	// use display formatter to return formatted date string
	displayString = [displayFormatter stringFromDate:date];
//	[displayFormatter release];
	return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
	return [self stringForDisplayFromDate:date prefixed:NO];
}

@end

#pragma mark -

@implementation NSDate (Misc)

+ (NSDate *)dateWithoutTime
{
  return [[NSDate date] dateAsDateWithoutTime];
}

-(NSDate *)dateByAddingDays:(NSInteger)numDays
{
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:numDays];
  
  NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
//  [comps release];
//  [gregorian release];
  return date;
}

- (NSDate *)dateAsDateWithoutTime
{
  NSString *formattedString = [self formattedDateString];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MMM dd, yyyy"];
  NSDate *ret = [formatter dateFromString:formattedString];
//  [formatter release];
  return ret;
}

- (NSDate *)dateAsDateJustBeforeMidnight
{
	NSDate *tomorrow = [self dateByAddingDays:1];
	NSDate *normalizedTomorrow = [tomorrow dateAsDateWithoutTime];
	return [normalizedTomorrow dateByAddingYears:0 months:0 days:0 hours:0 minutes:-1 seconds:0];
}

- (NSDate *)dateAsDateWithoutSeconds
{
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
	
  NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
	[comps setSecond:0];
	NSDate *retDate = [gregorian dateFromComponents:comps];
//	[gregorian release];
	return retDate;
}

- (NSInteger)differenceInDaysTo:(NSDate *)toDate
{
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
  NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                              fromDate:self
                                                toDate:toDate
                                               options:0];
  NSInteger days = [components day];
//  [gregorian release];
  return days;
}

- (NSInteger)inclusiveDifferenceInDaysTo:(NSDate *)toDate
{
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
  NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                              fromDate:self
                                                toDate:toDate
                                               options:0];
  NSInteger days = [components day] + 1;
//  [gregorian release];
  return days;
}

- (NSString *)formattedDateString
{
  return [self formattedStringUsingFormat:@"MMM dd, yyyy"];
}

- (NSString *)formattedStringUsingFormat:(NSString *)dateFormat
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:dateFormat];
  NSString *ret = [formatter stringFromDate:self];
//  [formatter release];
  return ret;
}

@end

#pragma mark -

@implementation NSDate (NaturalDates) 

- (BOOL)isSameDay:(NSDate*)anotherDate
{
  NSCalendar* calendar = [NSCalendar currentCalendar];
  NSDateComponents* components1 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
  NSDateComponents* components2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
  return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
} 

- (BOOL)isToday
{
  return [self isSameDay:[NSDate date]];
} 

- (BOOL)isYesterday
{
  NSCalendar* calendar = [NSCalendar currentCalendar];
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setDay:-1];
  NSDate *yesterday = [calendar dateByAddingComponents:comps toDate:[NSDate date]  options:0];
//  [comps release];
  return [self isSameDay:yesterday];
} 

- (BOOL)isLastWeek
{
  NSCalendar* calendar = [NSCalendar currentCalendar];
  NSDateComponents *comps = [calendar components:NSWeekCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date] toDate:self options:0];
  NSInteger week = [comps week];
  NSInteger days = [comps day];
  return (0==week && days<=0);
} 

- (NSString *)stringFromDateCapitalized:(BOOL)capitalize;
{
  NSString *label = nil;
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSString *dateFormatPrefix = nil;
  [dateFormatter setDateStyle:NSDateFormatterNoStyle]; // Will display hour only, we are building the day ourselves
  [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
  if([self isToday])
  {
    if(capitalize) dateFormatPrefix = NSLocalizedString(@"Today at", @"");
    else dateFormatPrefix = NSLocalizedString(@"today at", @"");
  }
  else if([self isYesterday])
  {
    if(capitalize) dateFormatPrefix = NSLocalizedString(@"Yesterday at", @"");
    else dateFormatPrefix = NSLocalizedString(@"yesterday at", @"");
  }
  else if([self isLastWeek])
  {
    NSDateFormatter *weekDayFormatter = [[NSDateFormatter alloc] init];
    // We will set the locale to US to have the weekday in english.
    // The NSLocalizedString(weekDayString, @"") below will make it
    // localized.
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [weekDayFormatter setLocale:locale];
//    [locale release];
    [weekDayFormatter setDateFormat:@"EEEE"];
    NSString *weekDayString = [NSString stringWithFormat:@"%@ at", [weekDayFormatter stringFromDate:self]];
    dateFormatPrefix = NSLocalizedString(weekDayString, @"");
//    [weekDayFormatter release];
  }
  else
  {
    [dateFormatter setDateStyle:NSDateFormatterShortStyle]; // Display the date as well
  }
  if (dateFormatPrefix != nil)
  { // We have a day string, add hour only
    label = [NSString stringWithFormat:@"%@ %@", dateFormatPrefix, [dateFormatter stringFromDate:self]];
  }
  else
  { // Use the full date
    label = [dateFormatter stringFromDate:self];
  }
//  [dateFormatter release];
  return label;
} 

@end

#pragma mark -

@implementation NSDate (Calendar)

+ (id)today
{
  NSDate *theDate = [NSDate date];
  
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:theDate];
  [comps setYear:[theDate year]];
  [comps setMonth:[theDate month]];
  [comps setDay:[theDate day]];
  [comps setHour:0];
  [comps setMinute:0];
  [comps setSecond:0];
  return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSInteger)year
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit) fromDate:self];
  return [comps year];
}

- (NSInteger)month
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSMonthCalendarUnit) fromDate:self];
  return [comps month];
}

- (NSInteger)day
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit) fromDate:self];
  return [comps day];
}

- (NSInteger)hour
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit) fromDate:self];
  return [comps hour];
}

- (NSInteger)minute
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSMinuteCalendarUnit) fromDate:self];
  return [comps minute];
}

- (NSInteger)second
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSSecondCalendarUnit) fromDate:self];
  return [comps second];
}

- (NSTimeZone *)timeZone
{
  // Reference the following link to deal with this issue:
  // http://stackoverflow.com/questions/1081647/how-to-convert-time-to-the-timezone-of-the-iphone-device/1082179#1082179

//  NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
//  NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
//  NSTimeZone *targetTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:destinationGMTOffset];
//  return targetTimeZone;
  
  return nil;
}

- (NSInteger)weekday
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSWeekdayCalendarUnit) fromDate:self];
  return [comps weekday];
}

- (NSDate *)firstDayOfCurrentMonth
{
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
  [comps setDay:1];
  
  return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSDate *)firstDayOfCurrentWeek
{
  NSDateComponents *adjustmentComps = [[NSDateComponents alloc] init];
  [adjustmentComps setDay:-([self weekday]-1)];
  NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:adjustmentComps toDate:self options:0];
//  [adjustmentComps release];
  return newDate;
}

- (NSDate *)lastDayOfCurrentMonth
{
  unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
  NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
  [comps setDay:1];
  [comps setMonth:([comps month] + 1)];
  NSDate *firstDateOfNextMonth = [[NSCalendar currentCalendar] dateFromComponents:comps];
  NSDate *lastDayOfMonth = [firstDateOfNextMonth dateByAddingDays:-1];
  return lastDayOfMonth;
}

- (BOOL)lastDayIsThirtieth
{
  NSDate *lastDay = [self lastDayOfCurrentMonth];
  return ([lastDay month] == 30);
}

- (BOOL)lastDayIsThirtyFirst
{
  NSDate *lastDay = [self lastDayOfCurrentMonth];
  return ([lastDay month] == 31);
}

- (NSDate *)dateByAddingYears:(NSInteger)years
                       months:(NSInteger)months
                         days:(NSInteger)days
                        hours:(NSInteger)hours
                      minutes:(NSInteger)minutes
                      seconds:(NSInteger)seconds
{
  NSDateComponents *adjustmentComps = [[NSDateComponents alloc] init];
  [adjustmentComps setYear:years];
  [adjustmentComps setMonth:months];
  [adjustmentComps setDay:days];
  [adjustmentComps setHour:hours];
  [adjustmentComps setMinute:minutes];
  [adjustmentComps setSecond:seconds];
  NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:adjustmentComps toDate:self options:0];
//  [adjustmentComps release];
  return newDate;
}

+ (NSDate *)dateWithYear:(NSInteger)years
                   month:(NSInteger)months
                     day:(NSInteger)days
                    hour:(NSInteger)hours
                  minute:(NSInteger)minutes
                  second:(NSInteger)seconds
                timeZone:(NSTimeZone *)timeZone
{
  NSDateComponents *absoluteComps = [[NSDateComponents alloc] init];
  [absoluteComps setYear:years];
  [absoluteComps setMonth:months];
  [absoluteComps setDay:days];
  [absoluteComps setHour:hours];
  [absoluteComps setMinute:minutes];
  [absoluteComps setSecond:seconds];
  timeZone ? [[NSCalendar currentCalendar] setTimeZone:timeZone] : [[NSCalendar currentCalendar] setTimeZone:[NSTimeZone defaultTimeZone]];
  NSDate *newDate = [[NSCalendar currentCalendar] dateFromComponents:absoluteComps];
//  [absoluteComps release];
  return newDate;
}

@end