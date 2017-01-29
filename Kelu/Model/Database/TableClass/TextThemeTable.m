//
//  TextThemeTable.m
//  Kelu
//
//  Created by Nagarajan SD on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "TextThemeTable.h"
#import "TextModel.h"

@interface TextThemeTable()
{
    
}

@end

@implementation TextThemeTable

+ (NSArray *)getTextModelForThemeTag:(NSString *)themeTag withSelectedLanguage:(NSString *)language dbManager:(KeluDatabaseManager *)dbManager
{
    NSArray *arrayOfTextCode = [self getArrayOfTextCodeForThemeTag:themeTag dbManager:dbManager];
    NSString *whereEqualValue = [NSString stringWithFormat:@"\"EN2%@\"", language];
    NSString *whereEqualField = kText_TransKey;
    NSString *whereInField = kText_TextCode;
    NSString *query = [KeluDatabaseManager getSelectQueryForTableName:kTextTableName withWhereInValues:arrayOfTextCode whereEqualValue:whereEqualValue forInField:whereInField andEqualField:whereEqualField];
    
    NSArray *arrayOfTextTableRecords = [[NSArray alloc] initWithArray:[dbManager loadDataFromDB:query]];
    NSArray *arrayOfTextModel = [self convertToArrayOfTextJsonModelFromArrayOfDBTextTable:arrayOfTextTableRecords dbManager:dbManager];
    return arrayOfTextModel;
    
}

+ (NSArray *)getArrayOfTextCodeForThemeTag:(NSString *)themeTag dbManager:(KeluDatabaseManager *)dbManager
{
    NSString *whereEqualValue = [NSString stringWithFormat:@"\"%@\"", themeTag];
    NSString *query = [KeluDatabaseManager getSelectQueryForTableName:kTextThemeTableName withWhereValue:whereEqualValue forField:kTextTheme_TagCode];
    
    NSArray *arrayOfTextThemeTableRecords = [[NSArray alloc] initWithArray:[dbManager loadDataFromDB:query]];
    NSMutableArray *arrayOfTextCode = [[NSMutableArray alloc] init];
    for (int count = 0; count < [arrayOfTextThemeTableRecords count]; count++)
    {
        TextThemeTable *textThemeTable = [self createThemeTableObjectWithObject:[arrayOfTextThemeTableRecords objectAtIndex:count] dbManager:dbManager];
        [arrayOfTextCode addObject:[NSString stringWithFormat:@"%@", textThemeTable.textCode]];
    }
    return arrayOfTextCode;
}

+ (TextThemeTable *)createThemeTableObjectWithObject:(NSArray *)object dbManager:(KeluDatabaseManager *)dbManager
{
    NSInteger indexOfWeight = [dbManager.arrColumnNames indexOfObject:kTextTheme_Weight];
    NSInteger indexOfKey = [dbManager.arrColumnNames indexOfObject:kTextTheme_Key];
    NSInteger indexOfTagText = [dbManager.arrColumnNames indexOfObject:kTextTheme_TagText];
    NSInteger indexOfTagCode = [dbManager.arrColumnNames indexOfObject:kTextTheme_TagCode];
    NSInteger indexOfTextCode = [dbManager.arrColumnNames indexOfObject:kTextTheme_TextCode];
    NSInteger indexOfTransKey = [dbManager.arrColumnNames indexOfObject:kTextTheme_TransKey];
    
    TextThemeTable *textThemeTable = [[TextThemeTable alloc] init];
    textThemeTable.weight = [object objectAtIndex:indexOfWeight];
    textThemeTable.key = [object objectAtIndex:indexOfKey];
    textThemeTable.tagText = [object objectAtIndex:indexOfTagText];
    textThemeTable.tagCode = [object objectAtIndex:indexOfTagCode];
    textThemeTable.textCode = [object objectAtIndex:indexOfTextCode];
    textThemeTable.transKey = [object objectAtIndex:indexOfTransKey];
    return textThemeTable;
}

+ (NSArray *)convertToArrayOfTextJsonModelFromArrayOfDBTextTable:(NSArray *)arrayOfTextTableRecords dbManager:(KeluDatabaseManager *)dbManager
{
    NSMutableArray *convertedTextModel = [[NSMutableArray alloc] init];
    for (int count = 0; count < [arrayOfTextTableRecords count]; count++)
    {
        TextTable *textTable = [self convertToTextTableFromObject:[arrayOfTextTableRecords objectAtIndex:count] withDBManager:dbManager];
        TextModel *textModel = [TextModel convertToTextJsonModelFromDBTTextTable:textTable];
        [convertedTextModel addObject:textModel];
    }
    return convertedTextModel;
}

+ (TextTable *)convertToTextTableFromObject:(NSArray *)object withDBManager:(KeluDatabaseManager *)dbManager
{
    NSInteger indexOfDestText = [dbManager.arrColumnNames indexOfObject:kText_DestText];
    NSInteger indexOfTextKey = [dbManager.arrColumnNames indexOfObject:kText_TextKey];
    NSInteger indexOfTextCode = [dbManager.arrColumnNames indexOfObject:kText_TextCode];
    NSInteger indexOfTransKey = [dbManager.arrColumnNames indexOfObject:kText_TransKey];
    NSInteger indexOfSrcText = [dbManager.arrColumnNames indexOfObject:kText_SrcText];
    NSInteger indexOfTextWeight = [dbManager.arrColumnNames indexOfObject:kText_Weight];
    
    TextTable *textTable = [[TextTable alloc] init];
    textTable.destText = [object objectAtIndex:indexOfDestText];
    textTable.textKey = [object objectAtIndex:indexOfTextKey];
    textTable.textCode = [object objectAtIndex:indexOfTextCode];
    textTable.transKey = [object objectAtIndex:indexOfTransKey];
    textTable.srcText = [object objectAtIndex:indexOfSrcText];
    textTable.textWeight = [object objectAtIndex:indexOfTextWeight];
    
    return textTable;
}

@end
