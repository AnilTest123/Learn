//
//  JiffleKeyChain.m
//  Jiffle
//
//  Created by Anil Chopra on 30/06/16.
//  Copyright © 2016 Jiffle. All rights reserved.
//

#import "KKeyChain.h"

@implementation KKeyChain

+ (BOOL)saveKeyChainValue:(NSString*)value forKey:(NSString*)key
{
    // Create NSData object
    NSData *nsdata = [value
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    if([JNKeychain saveValue:base64Encoded forKey:key])
        return YES;
    return NO;
}

+ (NSString*)loadKeyChainValueForKey:(NSString*)key
{
    NSString*base64Encoded = [JNKeychain loadValueForKey:key];
    if(!base64Encoded)
        return @"";
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded?base64Decoded:@"";
}

@end
