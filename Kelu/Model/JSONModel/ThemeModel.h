//
//  ThemeModel.h
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ThemeModel

@end

@interface ThemeModel : JSONModel

@property(nonatomic,strong)NSString<Optional>*id;
@property(nonatomic,strong)NSString<Optional>*lan_key;
@property(nonatomic,strong)NSString<Optional>*location_id;
@property(nonatomic,strong)NSString<Optional>*resource_uri;
@property(nonatomic,strong)NSString<Optional>*tag;
@property(nonatomic,strong)NSString<Optional>*tag_code;
@property(nonatomic,strong)NSString<Optional>*weight;

@end
