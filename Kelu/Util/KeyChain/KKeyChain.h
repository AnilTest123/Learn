//
//  JiffleKeyChain.h
//  Jiffle
//
//  Created by Anil Chopra on 30/06/16.
//  Copyright © 2016 Jiffle. All rights reserved.
//

#import "JNKeychain.h"

@interface KKeyChain : NSObject

+ (BOOL)saveKeyChainValue:(NSString*)value forKey:(NSString*)key;
+ (NSString*)loadKeyChainValueForKey:(NSString*)key;
@end
