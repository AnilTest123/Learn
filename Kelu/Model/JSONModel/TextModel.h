//
//  TextModel.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TextModel

@end

@interface TextModel : JSONModel
@property(nonatomic,strong)NSString<Optional>*dest_lan_key;
@property(nonatomic,strong)NSString<Optional>*dest_text;
@property(nonatomic,strong)NSString<Optional>*id;
@property(nonatomic,strong)NSString<Optional>*lan_key;
@property(nonatomic,strong)NSString<Optional>*resource_uri;
@property(nonatomic,strong)NSString<Optional>*sound_file_url;
@property(nonatomic,strong)NSString<Optional>*text;
@property(nonatomic,strong)NSString<Optional>*text_code;
@end
