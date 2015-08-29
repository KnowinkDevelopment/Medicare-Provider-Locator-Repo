//
//  MPL_SearchResultsViewController.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/27/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_SearchResultsViewController.h"

@interface MPL_SearchResultsViewController ()

@end

@implementation MPL_SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrDatasource = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) parseData {
    
    NSMutableArray* arrCompanyNames = [[NSMutableArray alloc] init];
    
    for(id thisObj in self.arrSearchResults) {
        
        if ([thisObj isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary* dictThisSupplier = (NSDictionary*)thisObj;
            
            if ([dictThisSupplier objectForKey:@"company_name"] != nil) {
                [arrCompanyNames addObject:[dictThisSupplier objectForKey:@"company_name"]];
            }
        }
    }
    
    self.arrDatasource = arrCompanyNames;
    
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrDatasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableAttributedString* strAtttributedText;
    
    // Define general attributes for the entire text
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: cell.textLabel.textColor,
                              NSFontAttributeName: cell.textLabel.font
                              };
    
    NSDictionary* dictProviderData = [self.arrSearchResults objectAtIndex:[indexPath row]];
    
    NSString* strCustomerDemographics = [NSString stringWithFormat:@"%@\n%@\n%@, %@ %@", [[dictProviderData objectForKey:@"company_name"] capitalizedString], [dictProviderData objectForKey:@"address"], [dictProviderData objectForKey:@"city"], [dictProviderData objectForKey:@"state"], [dictProviderData objectForKey:@"zip"]];
    
    NSRange newLineRange = [strCustomerDemographics rangeOfString: @"\n"];
    NSRange firstLineRange = NSMakeRange(0, newLineRange.location);
    NSRange restOfTextRange = NSMakeRange(newLineRange.location + 1, strCustomerDemographics.length-newLineRange.location-1);
    
    strAtttributedText = [[NSMutableAttributedString alloc] initWithString:strCustomerDemographics attributes:attribs];
    
    
    [strAtttributedText setAttributes:@{NSForegroundColorAttributeName:MPL_BLUE} range:firstLineRange];
    
    [strAtttributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor], NSFontAttributeName:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:12.0]} range:restOfTextRange];
    
    cell.textLabel.attributedText = strAtttributedText;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSDictionary* dictUserData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 [self.arrSearchResults objectAtIndex:[indexPath row]], @"Provider Data",
                                  @"Show Provider Details", @"Action",
                                 nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rvc" object:self userInfo:dictUserData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
