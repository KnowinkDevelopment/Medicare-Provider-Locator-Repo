//
//  KIP_DateManager.m
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 6/30/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_DateManager.h"

@implementation KIP_DateManager

+(KIP_DateManager *)sharedDateManager {
    
    static KIP_DateManager* sharedDateManager;
    
    @synchronized(self) {
        
        if (!sharedDateManager)
            
            sharedDateManager = [[KIP_DateManager alloc] init];
        
        return sharedDateManager;
        
    }
}


- (NSString*) convertDateToString : (NSDate*) dateToConvert {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    
    //convert date back to string
    return [dateFormatter stringFromDate:dateToConvert];
    
}

- (NSString*) convertTimeToString : (NSDate*) timeToConvert {
    
    NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.locale = twelveHourLocale;
    [dateFormatter setDateFormat:@"HH:mm aa"];
    
    //convert date back to string
    return [dateFormatter stringFromDate:timeToConvert];
    
}

- (NSDate*) convertStringToDate : (NSString*) strToConvert {
 
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    return [dateFormatter dateFromString:strToConvert];
}

- (NSDate*) convertStringToDateAndTime : (NSString*) strToConvert {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];

    if ([strToConvert containsString:@"Time"]) {
        [dateFormatter setDateFormat:@"MM/dd/yy, HH:mm:ss aa zzzz"];
    } else {
        [dateFormatter setDateFormat:@"MM/dd/yy HH:mm aa"];
    }
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];    
    
    return [dateFormatter dateFromString:strToConvert];
}

- (NSString*) convertDateAndTimeToString : (NSDate*) dateToConvert {
    
    return [NSDateFormatter localizedStringFromDate:dateToConvert
                dateStyle:NSDateFormatterShortStyle
            timeStyle:NSDateFormatterFullStyle];
}

- (NSInteger) getDayNumber : (NSDate*) thisDate {
    
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:thisDate];
    
    return [dateComponents day];
    
}

- (NSString*) getDayName : (NSDate*) thisDate {
    
    //create a date formatter
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    //get the index of the day (this is 1-7 based)
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:thisDate];
    int weekdayNum = (int)[dateComponents weekday];
    return [[dateFormatter weekdaySymbols] objectAtIndex:weekdayNum-1];
    
}

- (int) getDayIndex : (NSDate*) thisDate {
    
    //get the index of the day (this is 1-7 based)
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:thisDate];
    return (int)[dateComponents weekday];
    
}


- (NSString*) getAbbreviatedMonth : (NSDate*) thisDate {
    
    //create a date formatter
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    //get the index of the month (this is 1-12 based)
    NSInteger monthInt =  [self getMonthInterger:thisDate];
    
    //return the short month name (0 based so substract 1 from monthInt)
    return [[dateFormatter shortMonthSymbols] objectAtIndex:monthInt-1];

}

- (NSString*) getMonthName : (NSDate*) thisDate {
    
    //create a date formatter
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    //get the index of the month (this is 1-12 based)
    NSInteger monthInt =  [self getMonthInterger:thisDate];
    
    //return the  month name (0 based so substract 1 from monthInt)
    return [[dateFormatter monthSymbols] objectAtIndex:monthInt-1];
}

- (int) getDaysInMonth : (NSDate*) dateToCheck {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:dateToCheck];
    
    return (int)days.length;
    
}

- (NSDate*) getFirstDayOfMonth : (NSDate*) dateToCheck {
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:dateToCheck];
    [dateComponents setDay:1];
    
     return [calendar dateFromComponents:dateComponents];
}

- (NSDate*) getAMonth : (NSDate*) dateToCheck : (int) modifier {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [NSDateComponents new];
    dateComponents.month = modifier;
    return [calendar dateByAddingComponents:dateComponents toDate:dateToCheck options:0];
    
}





- (NSInteger) getYear : (NSDate*) thisDate {
    
    //create a date formatter
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:thisDate];
    return [dateComponents year];
    
    
}

- (NSInteger) getMonthInterger : (NSDate*) thisDate {
    
    //get the index of the month (this is 1-12 based)
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:thisDate];
    return [dateComponents month];
    
}

- (BOOL) compareDates : (NSDate*) firstDate : (NSDate*) secondDate : (NSString*) strComparisonRule {
    
    BOOL meetsRule = YES;
    
    if ([strComparisonRule isEqualToString:@"Less Than Next"] || [strComparisonRule isEqualToString:@"Greater Than Previous"]) {
        
        if ([firstDate compare:secondDate] == 1) {
            meetsRule = NO;
        }
    
    } else if ([strComparisonRule isEqualToString:@"Is Equal"]) {
        
        if (![firstDate compare:secondDate] == NSOrderedSame) {
            
            meetsRule = NO;
        }
    }
    
    return meetsRule;
}

- (BOOL) compareMonthDayYear : (NSDate*) firstDate : (NSDate*) secondDate {
    
    BOOL isSame = NO;
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSComparisonResult dateComparison = [calendar compareDate:firstDate toDate:secondDate toUnitGranularity:NSCalendarUnitDay];
    
    if (dateComparison == NSOrderedSame) {
        isSame = YES;
    }
    
    return isSame;
    
}

- (BOOL) checkIfStringIsDate : (NSString*) strToCheck {
    
    BOOL isDate = NO;
    
    NSError* error;
    NSDataDetector* thisDataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeDate error:&error];
    
    NSArray* arrMatches = [thisDataDetector matchesInString:strToCheck
                                         options:0
                                           range:NSMakeRange(0, [strToCheck length])];
    
    for (NSTextCheckingResult* match in arrMatches) {
        if ([match resultType] == NSTextCheckingTypeDate) {
            isDate = YES;
        }
    }
    
    return isDate;
}

- (NSDate*) getStartOfDay {
    
    NSDate* today = [[NSDate alloc] init];
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    [currentCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    NSDateComponents* dateComponents = [currentCalendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear fromDate:today];
    
    NSInteger thisMonth = [dateComponents month];
    NSInteger thisDay = [dateComponents day];
    NSInteger thisYear = [dateComponents year];
    
    NSDateComponents* dayComponents = [[NSDateComponents alloc] init];
    [dayComponents setDay:thisDay];
    [dayComponents setMonth:thisMonth];
    [dayComponents setYear:thisYear];

    return [currentCalendar dateFromComponents:dayComponents];
    
}

- (NSDate*) getEndOfDay {
    
    NSDate* today = [[NSDate alloc] init];
    
    NSCalendar* currentCalendar = [NSCalendar currentCalendar];
    [currentCalendar setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    NSDateComponents* dateComponents = [currentCalendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear fromDate:today];
    
    NSInteger thisMonth = [dateComponents month];
    NSInteger thisDay = [dateComponents day];
    NSInteger thisYear = [dateComponents year];
    
    NSDateComponents* endOdDayComponents = [[NSDateComponents alloc] init];
    [endOdDayComponents setDay:thisDay];
    [endOdDayComponents setMonth:thisMonth];
    [endOdDayComponents setYear:thisYear];
    [endOdDayComponents setHour:23];
    [endOdDayComponents setMinute:59];
    [endOdDayComponents setSecond:59];

    return [currentCalendar dateFromComponents:endOdDayComponents];
}

- (NSArray*) getStartAndEndOfWeek : (NSDate*) dateToCheck {
    
    NSMutableArray* arrStartAndEndDates = [[NSMutableArray alloc] init];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *startOfTheWeek;
    NSDate *endOfWeek;
    NSTimeInterval interval;
    [cal rangeOfUnit:NSCalendarUnitWeekOfMonth
           startDate:&startOfTheWeek
            interval:&interval
             forDate:dateToCheck];
    //startOfWeek holds now the first day of the week, according to locale (monday vs. sunday)
    
    endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
    // holds 23:59:59 of last day in week.
    
    [arrStartAndEndDates addObject:startOfTheWeek];
    [arrStartAndEndDates addObject:endOfWeek];
    
    return arrStartAndEndDates;
}

- (NSDate*) getNewDate : (NSDate*) fromDate : (int) range {
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* fromComponents = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:fromDate];
    NSInteger theDay = [fromComponents day];
    NSInteger theMonth = [fromComponents month];
    NSInteger theYear = [fromComponents year];
    
    // now build a NSDate object for yourDate using these components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:theDay];
    [components setMonth:theMonth];
    [components setYear:theYear];
    NSDate* thisDate = [calendar dateFromComponents:components];
    
    // now build a NSDate object for the next day
    NSDateComponents* offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:range];
    NSDate* newDate = [calendar dateByAddingComponents:offsetComponents toDate:thisDate options:0];
    
    return newDate;
}



    


@end
