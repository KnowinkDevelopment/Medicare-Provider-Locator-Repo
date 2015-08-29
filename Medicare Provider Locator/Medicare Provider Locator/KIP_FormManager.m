//
//  KIP_FormManager.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/26/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_FormManager.h"

@implementation KIP_FormManager

+(KIP_FormManager *)sharedFormManager {
    
    static KIP_FormManager* sharedFormManager;
    
    @synchronized(self) {
        
        if (!sharedFormManager)
            
            sharedFormManager = [[KIP_FormManager alloc] init];
        
        return sharedFormManager;
        
    }
}

- (NSDictionary*) validateSearchForm : (NSArray*) arrTextFields {

    BOOL isValid = YES;
    NSString* strValidationDescrition = @"Success";
    NSString* strErrMsg;
    int blankFieldCount = 0;
    
    for(KIP_TextField* thisTextField in arrTextFields) {
        
        if (thisTextField.text.length == 0 || [thisTextField.text isEqualToString:@""]) {
            
            blankFieldCount = blankFieldCount + 1;
        }
        
    }
    
    if (blankFieldCount == arrTextFields.count) {
        
        isValid = NO;
        strErrMsg = @"You must enter text in at least one field.";
        strValidationDescrition = @"Failed";
        
    }
    
    
   return [[NSDictionary alloc] initWithObjectsAndKeys:
                                 strValidationDescrition, @"Validation Results",
                                  [NSNumber numberWithBool:isValid], @"Is Valid",
                                  strErrMsg, @"Error Message",
                                 nil];
}


@end
