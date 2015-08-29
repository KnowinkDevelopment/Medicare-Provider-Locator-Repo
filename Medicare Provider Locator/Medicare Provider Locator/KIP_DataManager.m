//
//  KIP_DataManager.m
//  KPEnterprise
//
//  Created by Steve Suranie on 7/1/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "KIP_DataManager.h"
#import "KIP_Controller.h"

@implementation KIP_DataManager

+(KIP_DataManager *)sharedDataManager {
    
    static KIP_DataManager* sharedDataManager;
    
    @synchronized(self) {
        
        if (!sharedDataManager)
            
            sharedDataManager = [[KIP_DataManager alloc] init];
        
        return sharedDataManager;
        
    }
}

- (void) storeData : (NSDictionary*) dictDataToStore : (BOOL) isUpdate : (NSString*) strEntityName {
    
    KIP_Controller* myController = [KIP_Controller sharedController];
    
    //get the attributes for this entity
    NSManagedObject* newRecord;
    newRecord = [NSEntityDescription insertNewObjectForEntityForName:strEntityName inManagedObjectContext:self.managedObjectContext];
    
    //get the attributes for this entity - we need to parse the dictionary of data we want to store and convert its contents from NSStrings to whatever type the entity requires
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:strEntityName inManagedObjectContext:self.managedObjectContext];
    NSDictionary* dictAttributes = [entityDesc attributesByName];
    
    for(NSString* strThisKey in dictAttributes) {
        
        //get the attribute description
        NSAttributeDescription* thisAttribute = [dictAttributes objectForKey:strThisKey];
        
        //look for a match in the data keys (the dict we passed) with the entity keys -
        for(NSString* strDataKey in dictDataToStore) {
            
            //found
            if ([strDataKey.lowercaseString isEqualToString:strThisKey.lowercaseString]) {
                
                //get the object we are adding
                id strDataObjToStore = [dictDataToStore objectForKey:strDataKey];
                
                //get the type needed for core data
                int attributeType = [thisAttribute attributeType];
                
                if(attributeType != 700) {
                    
                    //do a conversion
                    if (attributeType == 100 || attributeType == 200 || attributeType == 300) {
                        
                        //convert to integer
                        int attributeIntegerValue = [strDataObjToStore intValue];
                        [newRecord setValue:[NSNumber numberWithInteger:attributeIntegerValue] forKey:strThisKey];
                        
                    } else if (attributeType == 400) {
                        
                        //decimal number
                        //double attributeDouble = [strDataObjToStore doubleValue];
                        NSDecimalNumberHandler *roundPlain = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:5 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                        NSDecimalNumber* decAttributeNumber = [NSDecimalNumber decimalNumberWithDecimal:[strDataObjToStore decimalValue]];
                        NSDecimalNumber* finalNumber = [decAttributeNumber decimalNumberByRoundingAccordingToBehavior:roundPlain];
                        [newRecord setValue:finalNumber forKey:strThisKey];
                        
                    } else if (attributeType == 500) {
                        
                        //double
                        double attributeDouble = [strDataObjToStore doubleValue];
                        [newRecord setValue:[NSNumber numberWithDouble:attributeDouble] forKey:strThisKey];
                        
                    } else if (attributeType == 600) {
                        
                        //float
                        float attributeFloat = [strDataObjToStore floatValue];
                        [newRecord setValue:[NSNumber numberWithFloat:attributeFloat] forKey:strThisKey];
                        
                    } else if (attributeType == 800) {
                        
                        //BOOl
                        BOOL attributeBOOL = [strDataObjToStore boolValue];
                        [newRecord setValue:[NSNumber numberWithBool:attributeBOOL] forKey:strThisKey];
                        
                    } else if (attributeType == 900) {
                        //Date
                        NSDate* thisDate = [myController convertStringToDate:strDataObjToStore];
                        
                        [newRecord setValue:thisDate forKey:strThisKey];
                    }
                    
                    //add it to the new record
                    
                } else {
                    
                    //add the nsstring to the record
                    [newRecord setValue:[myController safeConvertToString:strDataObjToStore] forKey:strThisKey];
                    
                }
            }
        }

        
    }
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    

}

- (NSString*) setUpQuery : (NSArray*) arrTextFields {
    
    NSArray* arrSupplierDemographics = [NSArray arrayWithObjects: @"zip", @"company_name", @"state", nil];
    
    NSMutableString* strQuery = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@?", kBaseURL]];
    
    for(KIP_TextField* thisTextField in arrTextFields) {
        
        NSString* strKV;
        if (thisTextField.text.length > 0) {
            
            if (thisTextField.tag == 0) {
                
                for(NSString* strThisKey in SUPPLIER_TYPES) {
                    
                    if ([[SUPPLIER_TYPES objectForKey:strThisKey] isEqualToString:thisTextField.text]) {
                        
                        strKV = [NSString stringWithFormat:@"%@=%@", strThisKey, @"true"];
                        [strQuery appendString:strKV];
                    }
                }
                
                
                
            } else  {
                
                if (thisTextField.tag-1 == 5) {
                    
                    NSString* strState = thisTextField.text;
                    NSInteger stateNameIndex = [ARR_STATE_NAMES indexOfObject:strState];
                    NSString* strStateAbbrev = [ARR_STATE_ABBREVIATIONS objectAtIndex:stateNameIndex];
                    
                    strKV = [NSString stringWithFormat:@"&%@=%@", [arrSupplierDemographics objectAtIndex:thisTextField.tag-1], strStateAbbrev];
                    [strQuery appendString:strKV];
                    
                } else {
                
                    strKV = [NSString stringWithFormat:@"&%@=%@", [arrSupplierDemographics objectAtIndex:thisTextField.tag-1], thisTextField.text];
                    [strQuery appendString:strKV];
                    
                }
                
            }
        }
        
    }
    
    return strQuery;
}

- (void) getJSON : (NSString*) strQuery {
    
    //set up the url for webservice
    NSURL* urlRequest = [NSURL URLWithString:strQuery];
    
    // create a dispatch queue, first argument is a C string (note no "@"), second is always NULL
    dispatch_queue_t jsonParsingQueue = dispatch_queue_create("jsonParsingQueue", NULL);
    
    // execute a task on that queue asynchronously
    dispatch_async(jsonParsingQueue, ^{
        
        [self doSomeJSONReadingAndParsing:urlRequest];
        
        // once this is done, if you need to you can call
        // some code on a main thread (delegates, notifications, UI updates...)
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.results) {
                
                NSDictionary* dictUserData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 self.results, @"Results",
                                @"Parse Results", @"Action", 
                                 nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"rvc" object:self userInfo:dictUserData];
                
            }
        });
    });
    
    
}

- (void) doSomeJSONReadingAndParsing : (NSURL*) urlRequest {
    
    //set up an error
    NSError* error = nil;
   
    //get the response
    NSString* strResponse = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"%@\n\n%@", urlRequest, error);
    } else {
        
        //response is good, convert returned string to nsdata
        NSData* jsonData = [strResponse dataUsingEncoding:NSUTF8StringEncoding];
        
        //deserialize json (nsdata) into an array of dictionaries
        id results = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&error];
        
        if (error) {
            NSLog(@"%@\n\n%@", urlRequest, error);
        } else {
            self.results =  results;
        }
        
    }

    
}

- (UIImage*) getCompanyLogo : (NSString*) strCompanyName {
    
    UIImage* imgLogo;
    
    if ([strCompanyName containsString:@"CVS"] ||[strCompanyName containsString:@"Cvs"]) {
        imgLogo = [UIImage imageNamed:@"img_Provider_01_CVS"];
    } else if ([strCompanyName containsString:@"Meyer"] ||[strCompanyName containsString:@"MEYER"]) {
        imgLogo = [UIImage imageNamed:@"img_Provider_02_FredMeyer.png"];
    } else if ([strCompanyName containsString:@"Geneva"] ||[strCompanyName containsString:@"GENEVA"]) {
        imgLogo = [UIImage imageNamed:@"img_Provider_03_GenevaWoods.png"];
    } else if ([strCompanyName containsString:@"Sams West"] ||[strCompanyName containsString:@"SAMS WEST"]) {
        imgLogo = [UIImage imageNamed:@"img_Provider_04_SamWest.png"];
    } else {
        imgLogo = [UIImage imageNamed:@"img_mpl_full_logo.png"];
    }
    
    return imgLogo;
}

- (NSArray*) getAllEntities {
    
    //only try if we have a MOM
    if (self.managedObjectModel) {
        return [self.managedObjectModel entities];
    }
        
    return nil;
}


- (NSFetchedResultsController*) getData: (NSString *)strEntity : (NSArray*) arrSortDescriptors : (NSPredicate*) predicate {
    
    //make sure we have our core data stack initialized
    if (!self.managedObjectModel) {
        self.managedObjectModel = [self managedObjectModel];
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:strEntity];
    
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    if (arrSortDescriptors) {
        [fetchRequest setSortDescriptors:arrSortDescriptors];
    }
    
    self.fetchedResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return self.fetchedResults;
}

- (NSArray*) getDataAsArray : (NSString*) strEntity : (NSArray*) arrSortDescriptors : (NSPredicate*) predicate : (int) limit : (BOOL) returnDistinctResults {
    
    //set up a fetch request
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    //set up an entity descripton
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:strEntity inManagedObjectContext:self.managedObjectContext];
    
    //add it to the request
    [fetchRequest setEntity:entityDesc];
    
    //add any passed predicates
    if (predicate) {
        
        [fetchRequest setPredicate:predicate];
    }
    
    //set the limit if needed
    if(limit > 0) {
        [fetchRequest setFetchLimit:limit];
    }
    
    //only return distinct results
    if (returnDistinctResults) {
        [fetchRequest setReturnsDistinctResults:YES];
    }
    
    if (arrSortDescriptors) {
        [fetchRequest setSortDescriptors:arrSortDescriptors];
    }
    
    NSError* error = nil;
    NSArray* arrResults;
    
    
    arrResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", [NSString stringWithFormat:@"Error querying %@", fetchRequest.entity.name]);
    }
    return arrResults;

}

#pragma mark - Core Data Stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.kip.KPEnterpriseDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Medicare_Provider_Locator" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Medicare_Provider_Locator.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
