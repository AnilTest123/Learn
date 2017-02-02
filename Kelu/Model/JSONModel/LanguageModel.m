//
//  LanguageModel.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "LanguageModel.h"

@implementation LanguageModel

+(LanguageModel*)convertToLangugeJsonModelFromDBLanguageTable:(LanguageTable*)languageTable
{
    LanguageModel *model = [[LanguageModel alloc] init];
    model.lan_key = languageTable.languageKey;
    model.language = languageTable.languageText;
    return model;
}

@end
