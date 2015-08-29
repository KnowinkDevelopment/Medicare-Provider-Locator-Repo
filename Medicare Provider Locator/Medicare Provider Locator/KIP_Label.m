//
//  KIP_Label.m
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 7/4/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_Label.h"

@implementation KIP_Label


- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
