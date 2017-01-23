//
//  JsonTestData.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JsonTest.h"

@interface JsonTestData : JSONModel
@property(nonatomic,strong)NSMutableArray<JsonTest>*test;
@end
