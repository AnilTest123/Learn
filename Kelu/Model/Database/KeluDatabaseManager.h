//
//  KeluDatabaseManager.h
//  Kelu
//
//  Created by Anil Chopra on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageTable.h"
#import "ThemeTable.h"
#import "TextTable.h"

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
+ (NSString *)getSelectQueryForTableName:(NSString *)tableName withWhereValue:(NSString *)value forField:(NSString *)field;
+ (NSString *)getSelectQueryForTableName:(NSString *)tableName withWhereInValues:(NSArray *)inValues whereEqualValue:(NSString *)equalValue forInField:(NSString *)inField andEqualField:(NSString *)equalField;

@end
