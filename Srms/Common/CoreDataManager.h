//
//  CoreDataManager.h
//  CoreData2
//
//  Created by sunhuayu on 15/12/21.
//  Copyright © 2015年 sunhuayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject


+ (CoreDataManager *)shareManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;


- (NSURL *)applicationDocumentsDirectory;

@end













