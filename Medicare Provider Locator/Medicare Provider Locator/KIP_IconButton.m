//
//  KIP_IconButton.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/1/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_IconButton.h"

@implementation KIP_IconButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) buildButton {
    
    UIImage* imgButtonIcon;
    UIImage* imgButtonIconOn;
    switch (self.myIconType) {
            
        case MAP_ICON:
            imgButtonIcon = [UIImage imageNamed:@"img_map_icon.png"];
            imgButtonIconOn = [UIImage imageNamed:@"img_map_icon_on.png"];
            self.strTitle = @"Map";
            break;
        
        case FAVORITE_ICON:
            imgButtonIcon = [UIImage imageNamed:@"img_favorites_icon.png"];
            imgButtonIconOn = [UIImage imageNamed:@"img_favorites_icon_on.png"];
            self.strTitle = @"Fav";
            break;
            
        case ABOUT_ICON:
            imgButtonIcon = [UIImage imageNamed:@"img_about_icon.png"];
            imgButtonIconOn = [UIImage imageNamed:@"img_about_icon_on.png"];
            self.strTitle = @"About";
            break;
            
        case COMMENT_ICON:
            imgButtonIcon = [UIImage imageNamed:@"img_comment_icon.png"];
            imgButtonIconOn = [UIImage imageNamed:@"img_comment_icon_on.png"];
            self.strTitle = @"Comm";
            break;
            
        case WEB_ICON:
            imgButtonIcon = [UIImage imageNamed:@"img_website_icon.png"];
            imgButtonIconOn = [UIImage imageNamed:@"img_website_icon_on.png"];
            self.strTitle = @"Web";
            break;
            
        default:
            break;
    }
    
    UIButton* btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnIcon setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, imgButtonIcon.size.width, imgButtonIcon.size.height)];
    [btnIcon setImage:imgButtonIcon forState:UIControlStateNormal];
    [btnIcon setImage:imgButtonIconOn forState:UIControlStateHighlighted];
    [btnIcon addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnIcon];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x, btnIcon.frame.origin.y + btnIcon.frame.size.height + 1.0, self.frame.size.width, 20.0)];
    lblTitle.text = self.strTitle;
    lblTitle.textColor = MPL_BLUE;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:12.0];
    [self addSubview:lblTitle];
}

- (void) buttonTouched : (UIButton*) myButton {
    
    NSDictionary* dictUserData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Perform Button Action", @"Action",
                                  [NSNumber numberWithInt:self.myIconType], @"Action Type",
                                 nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rvc" object:self userInfo:dictUserData];
}

@end
