//
//  TextTable.h
//  Kelu
//
//  Created by Anil Chopra on 29/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Table Names
static NSString *const kTextTableName = @"FT_T_TEXT";

#pragma mark - Theme Table Field Names
static NSString *const kText_DestText = @"DEST_TEXT";
static NSString *const kText_TextKey = @"TXT_KEY";
static NSString *const kText_TextCode = @"TEXT_CODE";
static NSString *const kText_TransKey = @"TRANS_KEY";
static NSString *const kText_SrcText = @"SRC_TEXT";
static NSString *const kText_Weight = @"TXT_WEIGHT";

@interface TextTable : NSObject

@property (nonatomic, strong) NSString *destText;
@property (nonatomic, strong) NSString *textKey;
@property (nonatomic, strong) NSString *textCode;
@property (nonatomic, strong) NSString *transKey;
@property (nonatomic, strong) NSString *srcText;
@property (nonatomic, strong) NSString *textWeight;

@end
