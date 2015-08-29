//
//  KIP_StringManager.h
//  SPI_PAC
//
//  Created by Steve Suranie on 10/3/13.
//  Copyright (c) 2013 Steve Suranie. All rights reserved.
//
//###Singleton###

#import <Foundation/Foundation.h>


@interface KIP_StringManager : NSObject

+ (KIP_StringManager*) sharedStringManager;

- (NSString*)safeConvertToString:(id)value;

- (CGSize) getStringSize : (CGSize) constrainedToSize : (UIFont*) font : (NSString* ) strToSize;

- (NSString*) makeLowercase : (NSString*) stringToConvert : (BOOL) initialCap : (BOOL) capAllWords;

@end
