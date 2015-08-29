//
//  KIP_Controller.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/22/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_Controller.h"

@implementation KIP_Controller

+(KIP_Controller *)sharedController {
    
    static KIP_Controller* sharedController;
    
    @synchronized(self) {
        
        if (!sharedController)
            
            sharedController = [[KIP_Controller alloc] init];
        
        return sharedController;
        
    }
    
}

- (void) initContollerObjects {
    
    self.myDataManager = [KIP_DataManager sharedDataManager];
    self.myDateManager = [KIP_DateManager sharedDateManager];
    self.myStringManager = [KIP_StringManager sharedStringManager];
    self.myFormManager = [KIP_FormManager sharedFormManager];
}

#pragma mark - Data Methods

- (NSArray*) getAllEntities {
    return [self.myDataManager getAllEntities];
}

- (void) storeData : (NSDictionary*) dictDataToStore : (BOOL) isUpdate : (NSString*) strEntityName {
    [self.myDataManager storeData:dictDataToStore :isUpdate :strEntityName];
}

- (NSString*) setUpQuery : (NSArray*) arrTextFields {
    
    return [self.myDataManager setUpQuery:arrTextFields];
}

- (void) getJSON : (NSString*) strQuery {
    
    return [self.myDataManager getJSON:strQuery];
    
}

- (UIImage*) getCompanyLogo : (NSString*) strCompanyName {
    
    if (!self.myDataManager) {
        self.myDataManager = [KIP_DataManager sharedDataManager];
    }
    
    return [self.myDataManager getCompanyLogo:strCompanyName];

}


#pragma mark - Date Methods

- (NSString*) convertDateToString : (NSDate*) dateToConvert {
    
    return [self.myDateManager convertDateToString:dateToConvert];
}

- (NSString*) convertTimeToString : (NSDate*) timeToConvert {
    
    return [self.myDateManager convertTimeToString:timeToConvert];
}

- (NSDate*) convertStringToDate : (NSString*) strToConvert {
    
    return [self.myDateManager convertStringToDate:strToConvert];
    
}

- (NSDate*) convertStringToDateAndTime:(NSString *)strToConvert {
   
    return [self.myDateManager convertStringToDateAndTime:strToConvert];
}

- (NSString*) convertDateAndTimeToString : (NSDate*) dateToConvert {
   
    return [self.myDateManager convertDateAndTimeToString:dateToConvert];
}

- (NSInteger) getDayNumber:(NSDate *)thisDate {
    
    return [self.myDateManager getDayNumber:thisDate];
    
}

- (NSString*) getDayName:(NSDate *)thisDate {
   
    return [self.myDateManager getDayName:thisDate];
}

- (int) getDayIndex:(NSDate *)thisDate  {
   
    return [self.myDateManager getDayIndex:thisDate];
    
}

- (NSString*) getAbbreviatedMonth :(NSDate *)thisDate {
   
    return [self.myDateManager getAbbreviatedMonth:thisDate];
    
}

- (NSString*) getMonthName : (NSDate *)thisDate  {
   
    return [self.myDateManager getMonthName:thisDate];
    
}

- (NSInteger) getMonthInterger : (NSDate*) thisDate {
  
    return [self.myDateManager getMonthInterger:thisDate];
    
}

- (int) getDaysInMonth : (NSDate*) dateToCheck {
   
    return [self.myDateManager getDaysInMonth:dateToCheck];
}

- (NSDate*) getFirstDayOfMonth : (NSDate*) dateToCheck {
   
    return [self.myDateManager getFirstDayOfMonth:dateToCheck];
    
}

- (NSDate*) getAMonth : (NSDate*) dateToCheck : (int) modifier {
   
    return [self.myDateManager getAMonth:dateToCheck:modifier];
}

- (NSInteger) getYear:(NSDate *)thisDate {
   
    return [self.myDateManager getYear:thisDate];
}

- (BOOL) compareDates : (NSDate*) firstDate : (NSDate*) secondDate : (NSString*) strComparisonRule {
 
    return [self.myDateManager compareDates:firstDate :secondDate :strComparisonRule];
}

- (BOOL) compareMonthDayYear : (NSDate*) firstDate : (NSDate*) secondDate {
  
    return [self.myDateManager compareMonthDayYear:firstDate :secondDate];
}

- (BOOL) checkIfStringIsDate : (NSString*) strToCheck {
   
    return [self.myDateManager checkIfStringIsDate:strToCheck];
}

- (NSDate*) getStartOfDay {
    
    return [self.myDateManager getStartOfDay];
}

- (NSDate*) getEndOfDay {
    
    return [self.myDateManager getEndOfDay];
}

- (NSArray*) getStartAndEndOfWeek : (NSDate*) dateToCheck {
    
    return [self.myDateManager getStartAndEndOfWeek:dateToCheck];
}

- (NSDate*) getNewDate : (NSDate*) fromDate : (int) range {
    
    return [self.myDateManager getNewDate:fromDate :range];
}

#pragma mark - String Methods

- (NSString*)safeConvertToString:(id)value {
    
    return [self.myStringManager safeConvertToString:value];
}

#pragma mark - Form Methods

- (NSDictionary*) validateSearchForm : (NSArray*) arrTextFields {
    
    return [self.myFormManager validateSearchForm:arrTextFields];
}



@end
