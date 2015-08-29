//
//  KIP_DataManager.h
//  KPEnterpriseDemo
//
//  Created by Steve Suranie on 7/1/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KIP_TextField.h"

@interface KIP_DataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSManagedObjectContext* syncObjectContext;
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResults;
@property (nonatomic, strong) id results;

+ (KIP_DataManager*) sharedDataManager;

- (NSFetchedResultsController*) getData: (NSString *)strEntity : (NSArray*) arrSortDescriptors : (NSPredicate*) predicate;

- (NSArray*) getDataAsArray : (NSString*) strEntity : (NSArray*) arrSortDescriptors : (NSPredicate*) predicate : (int) limit : (BOOL) returnDistinctResults;

- (void) storeData : (NSDictionary*) dictDataToStore : (BOOL) isUpdate : (NSString*) strEntityName;

- (NSArray*) getAllEntities;

- (void)saveContext;

- (NSString*) setUpQuery : (NSArray*) arrTextFields;

- (void) getJSON : (NSString*) strQuery;

- (UIImage*) getCompanyLogo : (NSString*) strCompanyName;

@end
