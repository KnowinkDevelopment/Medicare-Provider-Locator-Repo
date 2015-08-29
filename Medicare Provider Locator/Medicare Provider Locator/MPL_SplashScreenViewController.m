//
//  MPL_SplashScreenViewController.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/13/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_SplashScreenViewController.h"

@interface MPL_SplashScreenViewController ()

@end

@implementation MPL_SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) buildSplashScreen {
    
    UIImage* imgSplashTop = [UIImage imageNamed:@"img_mpl_splashtop.png"];
    UIImage* imgSplashBottom = [UIImage imageNamed:@"img_mplsplashbottom.png"];
    
    self.ivTopSplash = [[UIImageView alloc] initWithImage:imgSplashTop];
    [self.ivTopSplash setFrame:CGRectMake(0.0, 0.0, imgSplashTop.size.width, imgSplashTop.size.height)];
    [self.view addSubview:self.ivTopSplash];
    
    self.ivBottomSplash = [[UIImageView alloc] initWithImage:imgSplashBottom];
    [self.ivBottomSplash setFrame:CGRectMake(0.0, self.ivTopSplash.frame.size.height, imgSplashBottom.size.width, imgSplashBottom.size.height)];
    [self.view addSubview:self.ivBottomSplash];
    
    
}

- (void) animateSplashScreen {
    
    //get frame of both images
    CGRect topSplashFrame = self.ivTopSplash.frame;
    CGRect bottomSplashFrame = self.ivBottomSplash.frame;
    
    CGRect topDestinationFrame = CGRectMake(topSplashFrame.origin.x, 0.0-topSplashFrame.size.height, topSplashFrame.size.width, topSplashFrame.size.height);
    CGRect bottomDestinationFrame = CGRectMake(bottomSplashFrame.origin.x, self.view.frame.size.height +bottomSplashFrame.size.height, bottomSplashFrame.size.width, bottomSplashFrame.size.height);
    
    [UIView animateWithDuration:.75
                     animations:^(void) {
                         
                         self.ivTopSplash.frame = topDestinationFrame;
                         self.ivBottomSplash.frame = bottomDestinationFrame;
                     }
     
                     completion:^(BOOL finished) {
                         
                         NSDictionary* dictUserData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Splash Screen Animation Finished", @"Action",
                                 nil];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"rvc" object:self userInfo:dictUserData];
                     }
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
