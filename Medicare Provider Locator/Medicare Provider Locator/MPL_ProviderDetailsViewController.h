//
//  MPL_ProviderDetailsViewController.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/27/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIP_Controller.h"
#import "MPL_DottedBorder.h"
#import "KIP_IconButton.h"

@interface MPL_ProviderDetailsViewController : UIViewController

@property (nonatomic, strong) NSDictionary* dictProviderDetails;
@property (nonatomic, strong) KIP_Controller* myController;

- (void) buildDetails; 

@end
