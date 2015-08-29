//
//  KIP_AnnontationView.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/7/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_AnnontationView.h"

@implementation KIP_AnnontationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    
    return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:16.0];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    
    return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14.0];
}

#pragma clang diagnostic pop


@end
