//
//  KIP_TextField.m
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 7/7/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_TextField.h"

@implementation KIP_TextField

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(self.bounds, insets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    self.edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    self.edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}
@end
