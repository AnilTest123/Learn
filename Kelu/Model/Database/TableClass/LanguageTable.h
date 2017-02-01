//
//  LanguageTable.h
//  Kelu
//
//  Created by Nagarajan SD on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Table Names
static NSString *const kLanguageTableName = @"FT_T_LANGUAGES";

#pragma mark - Language Table Field Names
static NSString *const kLanguage_LangugeKey = @"LAN_KEY";
static NSString *const kLanguage_LangugeText = @"LAN_TEXT";

@interface LanguageTable : NSObject

@property (nonatomic, strong) NSString *languageKey;
@property (nonatomic, strong) NSString *languageText;

@end
