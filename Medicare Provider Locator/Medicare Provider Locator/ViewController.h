//
//  ViewController.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/17/15.
//  Copyright (c) 2015 Knowink Publishing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *vNavBar;
@property (strong, nonatomic) IBOutlet UIButton *btnHome;

- (IBAction)reloadHomeView:(id)sender;


@end

