//
//  MPL_SupplierCell.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/27/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_SupplierCell.h"

@implementation MPL_SupplierCell

- (void)awakeFromNib {

    self.arrMyObjs = [[NSMutableArray alloc] init];
}

- (void) configureCell {
    
    if (self.arrMyObjs.count > 0) {
        for(id thisObj in self.arrMyObjs) {
            [thisObj removeFromSuperview];
        }
    }
    [self.arrMyObjs removeAllObjects];
    
    UIView* vData = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    
    UILabel* lblCompanyName = [[UILabel alloc] initWithFrame:CGRectMake(3.0, 3.0, vData.frame.size.width, 20.0)];
    lblCompanyName.text = [self.dictThisProvider objectForKey:@"company_name"];
    lblCompanyName.textColor = MPL_BLUE;
    lblCompanyName.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:15.0];
    [vData addSubview:lblCompanyName];
    
    UILabel* lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(3.0, lblCompanyName.frame.origin.y + lblCompanyName.frame.size.height + 2.0, vData.frame.size.width, 20.0)];
    lblAddress.text = [self.dictThisProvider objectForKey:@"address"];
    lblAddress.textColor = [UIColor darkGrayColor];
    lblAddress.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:12.0];
    [vData addSubview:lblAddress];
    
    UILabel* lblCityStateZip = [[UILabel alloc] initWithFrame:CGRectMake(3.0, lblAddress.frame.origin.y + lblAddress.frame.size.height + 2.0, vData.frame.size.width, 20.0)];
    lblCityStateZip.text = [NSString stringWithFormat:@"%@, %@ %@", [self.dictThisProvider objectForKey:@"city"], [self.dictThisProvider objectForKey:@"state"], [self.dictThisProvider objectForKey:@"zip"]];
    lblCityStateZip.textColor = [UIColor darkGrayColor];
    lblCityStateZip.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:12.0];
    [vData addSubview:lblCityStateZip];
    
    [self addSubview:vData];
    
    [self.arrMyObjs addObject:vData];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
