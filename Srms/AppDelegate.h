//
//  AppDelegate.h
//  Srms
//
//  Created by ohm on 16/5/31.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 登录界面
- (void)loginController;
//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;
//

@end

