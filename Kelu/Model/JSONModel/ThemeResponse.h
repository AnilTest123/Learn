//
//  ThemeResponse.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ThemeModel.h"

@interface ThemeResponse : JSONModel

@property (nonatomic, strong) NSMutableArray<ThemeModel> *objects;

#pragma mark - Search
- (ThemeModel *)getThemeModelForThemeTagCode:(NSString *)themeTagCode;

@end
