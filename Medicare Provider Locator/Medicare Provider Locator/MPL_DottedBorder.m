//
//  MPL_DottedBorder.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/30/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_DottedBorder.h"

@implementation MPL_DottedBorder

- (id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.myBorder = [CAShapeLayer layer];
    self.myBorder.strokeColor = [UIColor colorWithRed:67/255.0f green:37/255.0f blue:83/255.0f alpha:1].CGColor;
    self.myBorder.fillColor = nil;
    self.myBorder.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:self.myBorder];
    
    self.myBorder.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.myBorder.frame = self.bounds;
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
