//
//  MPL_SupplierCell.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/27/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPL_SupplierCell : UITableViewCell

@property (nonatomic, strong) NSDictionary* dictThisProvider;
@property (nonatomic, strong) NSMutableArray* arrMyObjs;

- (void) configureCell; 

@end
