//
//  ThemeTable.h
//  Kelu
//
//  Created by Anil Chopra on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Table Names
static NSString *const kThemeTableName = @"FT_T_TAG";

#pragma mark - Theme Table Field Names
static NSString *const kTheme_ThemeWeight = @"TAG_WEIGHT";
static NSString *const kTheme_TagCode = @"TAG_CODE";
static NSString *const kTheme_TagText = @"TAG_TEXT";
static NSString *const kTheme_TransKey = @"TRANS_KEY";

@interface ThemeTable : NSObject

@property (nonatomic, strong) NSString *themeWeight;
@property (nonatomic, strong) NSString *themeTagCode;
@property (nonatomic, strong) NSString *themeTagText;
@property (nonatomic, strong) NSString *themeTransKey;

@end
