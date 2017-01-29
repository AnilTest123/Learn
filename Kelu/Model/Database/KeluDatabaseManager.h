//
//  KeluDatabaseManager.h
//  Kelu
//
//  Created by Nagarajan SD on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageTable.h"

@interface KeluDatabaseManager : NSObject

#pragma mark - Shared Instance
+ (KeluDatabaseManager *)sharedDatabaseManagerInstance;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

#pragma mark - Database Operation methods
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;

#pragma mark - Query String Generation
+ (NSString *)getSelectQueryForTableName:(NSString *)tableName;

@end
