//
//  KIP_DateManager.h
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 6/30/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIP_DateManager : NSObject

+ (KIP_DateManager*) sharedDateManager;

- (NSString*) convertDateToString : (NSDate*) dateToConvert;

- (NSString*) convertTimeToString : (NSDate*) timeToConvert;

- (NSDate*) convertStringToDateAndTime : (NSString*) strToConvert;

- (NSDate*) convertStringToDate : (NSString*) strToConvert;

- (NSString*) convertDateAndTimeToString : (NSDate*) dateToConvert;

- (NSInteger) getDayNumber : (NSDate*) thisDate;

- (NSString*) getAbbreviatedMonth : (NSDate*) thisDate;

- (NSString*) getMonthName : (NSDate*) thisDate;

- (NSInteger) getMonthInterger : (NSDate*) thisDate;

- (int) getDaysInMonth : (NSDate*) dateToCheck;

- (NSDate*) getFirstDayOfMonth : (NSDate*) dateToCheck;

- (NSDate*) getAMonth : (NSDate*) dateToCheck : (int) modifier;

- (NSInteger) getYear : (NSDate*) thisDate;

- (NSString*) getDayName : (NSDate*) thisDate;

- (int) getDayIndex : (NSDate*) thisDate;

- (NSDate*) getStartOfDay;

- (NSDate*) getEndOfDay;

- (BOOL) compareDates : (NSDate*) firstDate : (NSDate*) secondDate : (NSString*) strComparisonRule;

- (BOOL) compareMonthDayYear : (NSDate*) firstDate : (NSDate*) secondDate; 

- (BOOL) checkIfStringIsDate : (NSString*) strToCheck;

- (NSArray*) getStartAndEndOfWeek : (NSDate*) dateToCheck;

- (NSDate*) getNewDate : (NSDate*) fromDate : (int) range;



@end
