//
//  KIP_FormManager.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/26/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIP_TextField.h"

@interface KIP_FormManager : NSObject

+ (KIP_FormManager*) sharedFormManager;

- (NSDictionary*) validateSearchForm : (NSArray*) arrTextFields;

@end
