//
//  TextThemeTable.h
//  Kelu
//
//  Created by Anil Chopra on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Table Names
static NSString *const kTextThemeTableName = @"FT_T_TAGTEXT";

#pragma mark - Theme Table Field Names
static NSString *const kTextTheme_Weight = @"WEIGHT";
static NSString *const kTextTheme_Key = @"KEY";
static NSString *const kTextTheme_TagText = @"TAG_TEXT";
static NSString *const kTextTheme_TagCode = @"TAG_CODE";
static NSString *const kTextTheme_TextCode = @"TEXT_CODE";
static NSString *const kTextTheme_TransKey = @"TRANS_KEY";

@interface TextThemeTable : NSObject

@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *tagText;
@property (nonatomic, strong) NSString *tagCode;
@property (nonatomic, strong) NSString *textCode;
@property (nonatomic, strong) NSString *transKey;

+ (NSArray *)getTextModelForThemeTag:(NSString *)themeTag withSelectedLanguage:(NSString *)language dbManager:(KeluDatabaseManager *)dbManager;

@end
