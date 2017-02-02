//
//  ThemeModel.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel

+ (ThemeModel *)convertToThemeJsonModelFromDBThemeTable:(ThemeTable *)themeTable
{
    ThemeModel *model = [[ThemeModel alloc] init];
    model.weight = themeTable.themeWeight;
    model.tag_code = themeTable.themeTagCode;
    model.tag = themeTable.themeTagText;
    model.trans_key = themeTable.themeTransKey;
    model.lan_key = [KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey];
    return model;
}

@end
