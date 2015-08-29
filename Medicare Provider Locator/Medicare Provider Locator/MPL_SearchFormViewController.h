//
//  MPL_SearchFormViewController.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/26/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIP_TextField.h"
#import "KIP_Label.h"
#import "KIP_Controller.h"

@interface MPL_SearchFormViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView* myPickerView;
@property (nonatomic, strong) NSMutableArray* arrMyObjs;
@property (nonatomic, strong) KIP_TextField* currentTextField;
@property (nonatomic, strong) NSArray* arrSearchFields;
@property (nonatomic, assign) SEARCH_FIELD_PICKER_TYPE currentPickerType;
@property (nonatomic, assign) float pickerY;
@property (nonatomic, strong) NSArray* arrPickerDataSource;
@property (nonatomic, strong) UIView* vPickerWrapper;
@property (nonatomic, assign) int selectedSupplier;
@property (nonatomic, assign) int selectedState;
@property (nonatomic, strong) NSMutableArray* arrMyTextFields;
@property (nonatomic, strong) KIP_Controller* myController;
@property (nonatomic, assign) BOOL hasPicker;
@property (nonatomic, strong) NSString* strCachedQuery;
@property (nonatomic, strong) UIScrollView* svHelp;

- (void) buildSearchForm;


@end
