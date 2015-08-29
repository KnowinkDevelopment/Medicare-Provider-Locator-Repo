//
//  MPL_SplashScreenViewController.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/13/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPL_SplashScreenViewController : UIViewController

@property (nonatomic, strong) UIImageView* ivTopSplash;
@property (nonatomic, strong) UIImageView* ivBottomSplash;


- (void) buildSplashScreen;

- (void) animateSplashScreen;

@end
