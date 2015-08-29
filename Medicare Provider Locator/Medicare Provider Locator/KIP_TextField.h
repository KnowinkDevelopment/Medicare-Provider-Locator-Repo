//
//  KIP_TextField.h
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 7/7/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIP_TextField : UITextField

@property (nonatomic, strong) UIView* myParentCell;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) BOOL isDate;

@end
