//
//  LanguageModel.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol LanguageModel

@end

@interface LanguageModel : JSONModel

@property(nonatomic,strong)NSString<Optional>*id;
@property(nonatomic,strong)NSString<Optional>*lan_key;
@property(nonatomic,strong)NSString<Optional>*language;
@property(nonatomic,strong)NSString<Optional>*resource_uri;

+(LanguageModel*)convertToLangugeJsonModelFromDBLanguageTable:(LanguageTable*)languageTable;

@end
