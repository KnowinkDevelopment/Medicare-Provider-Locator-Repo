//
//  MPL_SearchFormViewController.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 7/26/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_SearchFormViewController.h"

@implementation MPL_SearchFormViewController

- (void) buildSearchForm {
    
    //clean up
    for(id thisObj in self.arrMyObjs) {
        [thisObj removeFromSuperview];
    }
    [self.arrMyObjs removeAllObjects];
    
    //inits
    self.myController = [KIP_Controller sharedController];
    self.arrMyObjs = [[NSMutableArray alloc] init];
    self.arrMyTextFields = [[NSMutableArray alloc] init];
    self.hasPicker = NO;
    
    self.arrSearchFields = [[NSArray alloc] initWithObjects:@"Supplier Type", @"Zip", @"State", nil];
    
    self.svHelp = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height + 1.0, self.view.frame.size.width, 350.0)];
    [self.view addSubview:self.svHelp];
    
    //add instructions and form
    UILabel* lblInstructions = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 10.0, self.view.frame.size.width, 20.0)];
    lblInstructions.text = @"Enter the information you want to search by:";
    lblInstructions.textColor = MPL_BLUE;
    lblInstructions.textAlignment = NSTextAlignmentCenter;
    lblInstructions.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:13.0];
    [self.view addSubview:lblInstructions];
    [self.arrMyObjs addObject:lblInstructions];
    
    UIButton* btnHelp = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [btnHelp setFrame:CGRectMake(self.view.frame.size.width - 50.0, 5.0, 30.0, 30.0)];
    [btnHelp setTintColor:MPL_BLUE];
    [btnHelp addTarget:self action:@selector(showHelp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHelp];
    [self.arrMyObjs addObject:btnHelp];
    
    float textX = 20.0;
    float textY = lblInstructions.frame.origin.y + lblInstructions.frame.size.height + 5.0;
    for(int i=0; i<self.arrSearchFields.count; i++) {
        
        KIP_TextField* txtSearchField = [[KIP_TextField alloc] initWithFrame:CGRectMake(textX, textY, self.view.frame.size.width - 40.0, 30.0)];
        txtSearchField.placeholder = [self.arrSearchFields objectAtIndex:i];
        txtSearchField.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.0];
        txtSearchField.delegate = self;
        txtSearchField.borderStyle = UITextBorderStyleLine;
        txtSearchField.tag = i;
        txtSearchField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:txtSearchField];
        [self.arrMyObjs addObject:txtSearchField];
        [self.arrMyTextFields addObject:txtSearchField];
        
        textY = textY + 35.0;
        
    }
    
    UIButton* btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmit setFrame:CGRectMake(5.0, textY+5.0, 100.0, 24.0)];
    [btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:MPL_BLUE forState:UIControlStateNormal];
    [btnSubmit setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btnSubmit.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.0];
    [btnSubmit addTarget:self action:@selector(submitQuery:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSubmit];
    [self.arrMyObjs addObject:btnSubmit];
    
    UIButton* btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClear setFrame:CGRectMake(btnSubmit.frame.origin.x + btnSubmit.frame.size.width + 2.0, textY+5.0, 100.0, 24.0)];
    [btnClear setTitle:@"Clear" forState:UIControlStateNormal];
    [btnClear setTitleColor:MPL_BLUE forState:UIControlStateNormal];
    [btnClear setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btnClear.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.0];
    [btnClear addTarget:self action:@selector(clearForm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClear];
    [self.arrMyObjs addObject:btnClear];
    
    self.pickerY = textY + 10.0;
}

- (void) submitQuery : (UIButton*) myButton {
    
    if (self.hasPicker) {
        
        [self addSelection:nil];
        [self closePicker];
    }
    
    NSDictionary* dictValidationResults = [self.myController validateSearchForm:self.arrMyTextFields];
    
    if (![[dictValidationResults objectForKey:@"Is Valid"] boolValue]) {
        
        UIAlertController* alertController = [UIAlertController
                                              alertControllerWithTitle:@"Search Form Error"
                                              message:[dictValidationResults objectForKey:@"Error Message"]
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                   }
                                   ];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        NSDictionary* dictUserData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Submit Search Query", @"Action",
                                self.arrMyTextFields, @"Text Fields",
                                 nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rvc" object:self userInfo:dictUserData];
        
    }
    
}

- (void) clearForm : (UIButton*) myButton {
    
    for(UITextField* thisTextField in self.arrMyTextFields) {
        thisTextField.text = @"";
    }
}

- (NSArray*) getSupplierArray {
    
    NSMutableArray* arrSupplierDescriptions = [[NSMutableArray alloc] init];
    
    for (NSString* strThisKey in SUPPLIER_TYPES) {
        [arrSupplierDescriptions addObject:[SUPPLIER_TYPES objectForKey:strThisKey]];
    }
    
    return [arrSupplierDescriptions sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - Help

- (void) showHelp : (UIButton*) myButton {
 
    
}

#pragma mark - Picker Methods

- (void) addPicker {
    
    //clean up
    if (self.myPickerView) {
        [self.myPickerView removeFromSuperview];
    }
    
    if (self.currentPickerType == SUPPLIER_PICKER) {
        self.arrPickerDataSource = [self getSupplierArray];
    } else if (self.currentPickerType == STATE_PICKER) {
        self.arrPickerDataSource = ARR_STATE_NAMES;
    }
    
    self.hasPicker = YES;
    
    self.vPickerWrapper = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.pickerY, self.view.frame.size.width, 300.0)];
    
    self.myPickerView = [[UIPickerView alloc] init];
    [self.myPickerView setFrame:CGRectMake(0.0, 0.0, self.vPickerWrapper.frame.size.width, 216.0)];
    self.myPickerView.delegate = self;
    self.myPickerView.dataSource = self;
    self.myPickerView.userInteractionEnabled = YES;
    [self.myPickerView reloadAllComponents];
    [self.myPickerView selectRow:0 inComponent:0 animated:YES];
    self.myPickerView.showsSelectionIndicator = YES;
    [self.vPickerWrapper addSubview:self.myPickerView];
    
    UIButton* btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:CGRectMake(self.vPickerWrapper.frame.size.width - 75.0, self.myPickerView.frame.size.height + 5.0, 50.0, 20.0)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setBackgroundColor:MPL_BLUE];
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btnDone.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0];
    [btnDone addTarget:self action:@selector(addSelection:) forControlEvents:UIControlEventTouchUpInside];
    [self.vPickerWrapper addSubview:btnDone];
    [self.vPickerWrapper bringSubviewToFront:btnDone];
    
    [self.view addSubview:self.vPickerWrapper];
    
}

- (void) addSelection : (UIButton*) myButton {
    
    if (self.currentPickerType == SUPPLIER_PICKER) {
        
        NSArray* arrSuppliers = [self getSupplierArray];
        self.currentTextField.text = [arrSuppliers objectAtIndex:self.selectedSupplier];
        
    } else if (self.currentPickerType == STATE_PICKER) {
        
        self.currentTextField.text = [ARR_STATE_NAMES objectAtIndex:self.selectedState];
        
    }
    
    [self closePicker];
}

- (void) closePicker {
    
    [UIView animateWithDuration:.25
     
                     animations:^(void) {
                         
                         self.vPickerWrapper.alpha = 0.0;
                         
                     }
     
                     completion:^(BOOL finished) {
                         
                         [self.vPickerWrapper removeFromSuperview];
                         self.hasPicker = NO;
                         
                     }
     ];
    
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    //Return the number of rows in the component
    return self.arrPickerDataSource.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    KIP_Label* lblTitle = [[KIP_Label alloc] init];
    lblTitle.text = [self.arrPickerDataSource objectAtIndex:row];
    lblTitle.textColor = [UIColor grayColor];
    lblTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:16.0];
    
    return lblTitle;
    
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.currentPickerType == SUPPLIER_PICKER) {
        self.selectedSupplier = (int)row;
    } else if (self.currentPickerType == STATE_PICKER) {
        self.selectedState = (int)row;
    }
   
}


#pragma mark - TextField Methods

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.currentTextField) {
        
        self.currentTextField = nil;
        self.currentTextField = (KIP_TextField*)textField;
        
    } else {
        
        self.currentTextField = (KIP_TextField*)textField;
        
    }
    
    if (self.currentTextField.tag == 0 || self.currentTextField.tag == self.arrSearchFields.count-1) {
        
        //kill the editing
        [self.view endEditing:YES];
        [textField resignFirstResponder];
        
        //set the picker type
        if (self.currentTextField.tag == 0) {
            self.currentPickerType = SUPPLIER_PICKER;
        } else if (self.currentTextField.tag == self.arrSearchFields.count-2) {
            self.currentPickerType = STATE_PICKER;
        }
        
        [self addPicker];
        
    } else {
        
        if (self.hasPicker) {
            [self closePicker];
        }
        
    }
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    //kill the editing
    [self.view endEditing:YES];
    [textField resignFirstResponder];
}

@end
