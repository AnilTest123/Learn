//
//  TextModel.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

+ (TextModel *)convertToTextJsonModelFromDBTTextTable:(TextTable *)textTable
{
    TextModel *model = [[TextModel alloc] init];
    model.dest_text = textTable.destText;
    model.text_code = textTable.textCode;
    model.text = textTable.srcText;
    model.lan_key = [textTable.transKey substringWithRange:NSMakeRange(0, 2)];
    model.dest_lan_key = [textTable.transKey substringWithRange:NSMakeRange(3, [textTable.transKey length] - 3)];
    return model;
}

@end
