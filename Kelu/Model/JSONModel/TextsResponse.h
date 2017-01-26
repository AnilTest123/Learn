//
//  TextsResponse.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TextModel.h"

@interface TextsResponse : JSONModel
@property(nonatomic,strong)NSMutableArray<TextModel> *TextsResponse;
@end
