//
//  KIP_IconButton.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/1/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIP_IconButton : UIView

@property (nonatomic, strong) UIImage* imgIcon;
@property (nonatomic, strong) NSString* strTitle;
@property (nonatomic, strong) UIImage* imgHighlighted;
@property (nonatomic, assign) DETAIL_BUTTON_ICON_TYPE myIconType;

- (void) buildButton; 


@end
