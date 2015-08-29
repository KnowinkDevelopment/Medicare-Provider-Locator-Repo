//
//  MPL_ProviderDetailsViewController.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/27/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_ProviderDetailsViewController.h"

@interface MPL_ProviderDetailsViewController ()

@end

@implementation MPL_ProviderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myController = [[KIP_Controller alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void) buildDetails {
    
    MPL_DottedBorder* vInfoWrapper = [[MPL_DottedBorder alloc] initWithFrame:CGRectMake(10.0, 10.0, self.view.frame.size.width - 20.0, self.view.frame.size.height - 75.0)];
    vInfoWrapper.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:240.0f/255.0f blue:236.0f/255.0f alpha:1.0];
    
    //display company logo
    UIImage* imgLogo = [self.myController getCompanyLogo:[self.dictProviderDetails objectForKey:@"company_name"]];
    
    float labelY = 30.0;
    
    UIImageView* ivLogo = [[UIImageView alloc] initWithImage:imgLogo];
    [ivLogo setFrame:CGRectMake(10.0, 30.0, imgLogo.size.width, imgLogo.size.height)];
    [vInfoWrapper addSubview:ivLogo];
    labelY = ivLogo.frame.origin.y + ivLogo.frame.size.height + 10.0;
    
    //demographics
    UILabel* lblCompanyName = [[UILabel alloc] initWithFrame:CGRectMake(10.0, labelY, 340.0, 20.0)];
    lblCompanyName.text = [[self.dictProviderDetails objectForKey:@"company_name"] capitalizedString];
    lblCompanyName.textColor = MPL_BLUE;
    lblCompanyName.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:22.0];
    [vInfoWrapper addSubview:lblCompanyName];
    
    UILabel* lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(10.0, lblCompanyName.frame.origin.y + lblCompanyName.frame.size.height + 5.0, 200.0, 20.0)];
    lblAddress.text = [[self.dictProviderDetails objectForKey:@"address"] capitalizedString];
    lblAddress.textColor = [UIColor blackColor];
    lblAddress.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:18.0];
    [vInfoWrapper addSubview:lblAddress];
    
    NSString* strCity = [[self.dictProviderDetails objectForKey:@"city"] stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    UILabel* lblCityStateZip = [[UILabel alloc] initWithFrame:CGRectMake(10.0, lblAddress.frame.origin.y + lblAddress.frame.size.height + 5.0, 200.0, 20.0)];
    lblCityStateZip.text = [NSString stringWithFormat:@"%@, %@ %@", [strCity capitalizedString], [[self.dictProviderDetails objectForKey:@"state"]capitalizedString], [[self.dictProviderDetails objectForKey:@"zip"]capitalizedString]];
    lblCityStateZip.textColor = [UIColor blackColor];
    lblCityStateZip.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:18.0];
    [vInfoWrapper addSubview:lblCityStateZip];
    
    
    UITextView* txtPhone = [[UITextView alloc] initWithFrame:CGRectMake(10.0, lblCityStateZip.frame.origin.y + lblCityStateZip.frame.size.height + 5, 200.0, 30.0)];
    txtPhone.text = [[self.dictProviderDetails objectForKey:@"phone"] stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];;
    txtPhone.textColor = [UIColor blackColor];
    txtPhone.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:18.0];
    txtPhone.editable = NO;
    txtPhone.backgroundColor = [UIColor clearColor];
    txtPhone.dataDetectorTypes = UIDataDetectorTypeAll;
    [vInfoWrapper addSubview:txtPhone];
    
    UILabel* lblServices = [[UILabel alloc] initWithFrame:CGRectMake(10.0, txtPhone.frame.origin.y + txtPhone.frame.size.height + 5.0, 200.0, 20.0)];
    lblServices.text = @"Services:";
    lblServices.textColor = [UIColor blackColor];
    lblServices.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:18.0];
    [vInfoWrapper addSubview:lblServices];
    
    NSArray* arrProviderServices = [self getServices];
    float scrollContentH = 0.0;
    
    UIScrollView* svScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10.0, lblServices.frame.origin.y + lblServices.frame.size.height, self.view.frame.size.width - 40.0, 230.0)];
    svScroll.backgroundColor = [UIColor clearColor];
    
    labelY = 10.0;
    for(int i=0; i<arrProviderServices.count; i++) {
        
        UILabel* lblService = [[UILabel alloc] initWithFrame:CGRectMake(5.0, labelY, svScroll.frame.size.width, 20.0)];
        lblService.text = [arrProviderServices objectAtIndex:i];
        lblService.textColor = [UIColor blackColor];
        lblService.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:14.0];
        [svScroll addSubview:lblService];
        
        labelY = labelY + 22.0;
        scrollContentH = scrollContentH + 24.0;
    }
    
    [vInfoWrapper addSubview:svScroll];
    
   
    
    UIView* vButtonWrapper = [[UIView alloc] initWithFrame:CGRectMake(10.0, svScroll.frame.origin.y + svScroll.frame.size.height, vInfoWrapper.frame.size.width-40.0, 43.0)];
    
    float buttonX = 0.0;
    for(int i=0; i<ARR_ICON_BUTTONS.count; i++) {
        
        KIP_IconButton* thisButton = [[KIP_IconButton alloc] initWithFrame:CGRectMake(buttonX, 0.0, 42.0, 42.0)];
        thisButton.myIconType = i;
        thisButton.strTitle = [ARR_ICON_BUTTONS objectAtIndex:i];
        [thisButton buildButton];
        [vButtonWrapper addSubview:thisButton];
        
        buttonX = buttonX + 20;
        
    }
    
    [vInfoWrapper addSubview:vButtonWrapper];
    [self.view addSubview:vInfoWrapper];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*) getServices {
    
    //get the services available
    NSMutableArray* arrServiceKeys = [[NSMutableArray alloc] init];
    for(NSString* strThisKey in self.dictProviderDetails) {
        if ([[self.dictProviderDetails objectForKey:strThisKey] isKindOfClass:[NSNumber class]]) {
            
            if ([[self.dictProviderDetails objectForKey:strThisKey] boolValue] == YES) {
                [arrServiceKeys addObject:strThisKey];
            }
        }
        
    }
    
    NSMutableArray* arrServiceTitles = [[NSMutableArray alloc] init];
    for (NSString* strThisServiceKey in arrServiceKeys) {
        if ([SUPPLIER_TYPES objectForKey:strThisServiceKey]) {
            [arrServiceTitles addObject:[SUPPLIER_TYPES objectForKey:strThisServiceKey]];
        }
    }
    
    NSArray* arrServicesSorted = [arrServiceTitles sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return arrServicesSorted;
    
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
