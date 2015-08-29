//
//  KIP_Controller.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/22/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIP_DataManager.h"
#import "KIP_DateManager.h"
#import "KIP_StringManager.h"
#import "KIP_FormManager.h"

@interface KIP_Controller : NSObject

@property (nonatomic, strong) KIP_DataManager* myDataManager;
@property (nonatomic, strong) KIP_DateManager* myDateManager;
@property (nonatomic, strong) KIP_StringManager* myStringManager;
@property (nonatomic, strong) KIP_FormManager* myFormManager;

+(KIP_Controller*)sharedController;

- (void) initContollerObjects;

/*data*/
- (NSArray*) getAllEntities;

- (void) storeData : (NSDictionary*) dictDataToStore : (BOOL) isUpdate : (NSString*) strEntityName;

- (NSString*) setUpQuery : (NSArray*) arrTextFields;

- (void) getJSON : (NSString*) strQuery;

- (UIImage*) getCompanyLogo : (NSString*) strCompanyName;

/*date methods*/
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

/*string methods*/

- (NSString*)safeConvertToString:(id)value;

- (CGSize) getStringSize : (CGSize) constrainedToSize : (UIFont*) font : (NSString* ) strToSize;

- (NSString*) makeLowercase : (NSString*) stringToConvert : (BOOL) initialCap : (BOOL) capAllWords;

/* form methods*/

- (NSDictionary*) validateSearchForm : (NSArray*) arrTextFields;

@end
