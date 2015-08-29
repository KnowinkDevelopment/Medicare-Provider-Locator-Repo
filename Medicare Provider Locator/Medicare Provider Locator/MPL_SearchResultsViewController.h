//
//  MPL_SearchResultsViewController.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/27/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPL_SupplierCell.h"

@interface MPL_SearchResultsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* arrDatasource;
@property (nonatomic, strong) NSArray* arrSearchResults;

- (void) parseData; 
@end
