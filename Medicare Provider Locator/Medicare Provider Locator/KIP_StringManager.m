//
//  KIP_StringManager.m
//  SPI_PAC
//
//  Created by Steve Suranie on 10/3/13.
//  Copyright (c) 2013 Steve Suranie. All rights reserved.
//
//###Singleton###

#import "KIP_StringManager.h"

@implementation KIP_StringManager

+(KIP_StringManager *)sharedStringManager {
    
    static KIP_StringManager* sharedStringManager;
    
    @synchronized(self) {
        
        if (!sharedStringManager)
            
            sharedStringManager = [[KIP_StringManager alloc] init];
        
        return sharedStringManager;
        
    }
    
}

// A Brian Bettencourt function from FocusATI. In some cases(ex: product_cd), data being stored
// as string is coming back from JSON calls as a number. We use this function
// to safely convert it to a string.
- (NSString *)safeConvertToString:(id)value {

    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *val = (NSNumber*)value;
        return [val stringValue];
    }
    
    if(value == nil) {
        return @"";
    }
    
    return value;
}

- (CGSize) getStringSize : (CGSize) constrainedToSize : (UIFont*) font : (NSString* ) strToSize {
    
    
    //get the iOS of the device
    
    CGSize stringSize;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
    
        CGRect stringRect = [strToSize boundingRectWithSize:constrainedToSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:font}
                                              context:nil];
        stringSize = stringRect.size;
        
    } else {
        
        stringSize = [strToSize sizeWithFont:font constrainedToSize:constrainedToSize lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return stringSize;
}

- (NSString*) makeLowercase : (NSString*) stringToConvert : (BOOL) initialCap : (BOOL) capAllWords {
    
    stringToConvert = [stringToConvert lowercaseString];
    
    if (initialCap) {
        
        NSArray* arrWords = [stringToConvert componentsSeparatedByString:@" "];
        NSString* strFirstWord = [[arrWords objectAtIndex:0] capitalizedString];
        NSMutableString* strNewString = [[NSMutableString alloc] initWithString:strFirstWord];
        
        for(int i=0; i<arrWords.count; i++) {
            if (i>0) {
                [strNewString appendString:[NSString stringWithFormat:@" %@", [arrWords objectAtIndex:i]]];
            }
        }
        
        return strNewString;
        
    }
    
    if (capAllWords) {
        
        stringToConvert = [stringToConvert capitalizedString];
    }
    
    return stringToConvert;
}

@end
