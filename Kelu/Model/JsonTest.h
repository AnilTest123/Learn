//
//  JsonTest.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol JsonTest
@end

@interface JsonTest : JSONModel
@property(nonatomic,strong)NSString<Optional>* userId;
@property(nonatomic,strong)NSString<Optional>* id;
@property(nonatomic,strong)NSString<Optional>* title;
@property(nonatomic,strong)NSString<Optional>* body;
@property(nonatomic,strong)NSString<Optional>* theme;
@end
