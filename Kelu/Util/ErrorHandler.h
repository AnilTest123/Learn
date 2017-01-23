//
//  ErrorHandler.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface ErrorHandler : NSObject
+ (void)verifySuccessResponseFromResponseOperation:(AFHTTPRequestOperation*)responseOperation WithSuccessCompletionBlock:(void(^)(NSString* responseString))success failureCompletionBlock:(void(^)(NSError* error))failure;

+ (void)fetchErrorFromResponseOperation:(AFHTTPRequestOperation*)responseOperation WithError:(NSError*)error WithfailureCompletionBlock:(void(^)(NSError* error))failure;

@end
