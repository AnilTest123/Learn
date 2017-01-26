//
//  ErrorHandler.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "ErrorHandler.h"
#import "ApiResponseHandler.h"
#import "KeluConstants.h"
@implementation ErrorHandler

+(void)verifySuccessResponseFromResponseOperation:(AFHTTPRequestOperation *)responseOperation WithSuccessCompletionBlock:(void (^)(NSString *))success failureCompletionBlock:(void (^)(NSError *))failure
{
    
    NSDictionary *responseDic ;
    NSError *error;
    if(responseOperation.responseData)
        responseDic = [NSJSONSerialization JSONObjectWithData:responseOperation.responseData options:NSJSONReadingMutableContainers error:&error];
     success(responseOperation.responseString);
}

+(void)fetchErrorFromResponseOperation:(AFHTTPRequestOperation *)responseOperation WithError:(NSError *)error WithfailureCompletionBlock:(void (^)(NSError *))failure
{
    [[ApiResponseHandler sharedApiResponseHandlerInstance].httpManager.operationQueue cancelAllOperations];
    
    NSInteger statusCode = responseOperation.response.statusCode;
    if(statusCode == kUnauthorizedRequest) {
        {
            failure([self getErrorForUnauthorised]);
            return;
        }
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"UnauthorizedRequest" object:nil];
    }
    
    if([responseOperation isCancelled])
    {
        failure(nil);
        return;
    }
    NSDictionary *responseDic;
    if(responseOperation.responseData)
        responseDic = [NSJSONSerialization JSONObjectWithData:responseOperation.responseData options:NSJSONReadingMutableContainers error:nil];
    
    if( ([[responseDic objectForKey:@"errors"] isKindOfClass:[NSDictionary class]] || [[responseDic objectForKey:@"errors"] isKindOfClass:[NSArray class]]) && [[responseDic objectForKey:@"errors"] count])
    {
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        if([[responseDic objectForKey:@"errors"] isKindOfClass:[NSArray class]])
        {
            [details setValue:[[responseDic objectForKey:@"errors"] firstObject] forKey:NSLocalizedDescriptionKey];
        }
        else
        {
            NSDictionary *dictionary = [responseDic objectForKey:@"errors"];
            NSString *errorMessage;
            NSArray *keys = [dictionary allKeys];
            if([[dictionary objectForKey:[keys firstObject]] isKindOfClass:[NSArray class]])
            {
                NSArray *errorArray = [dictionary objectForKey:[keys firstObject]];
                if([errorArray count])
                {
                    errorMessage = [errorArray firstObject];
                }
            }
            else if([[dictionary objectForKey:[keys firstObject]] isKindOfClass:[NSString class]])
            {
                errorMessage = [dictionary objectForKey:[keys firstObject]];
            }
            
            [details setValue:errorMessage forKey:NSLocalizedDescriptionKey];
        }
        
        NSError* newError = [NSError errorWithDomain:@"Error" code:error.code userInfo:details];
        failure(newError);
    }
    else if ([responseDic objectForKey:@"error"])
    {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        if([responseDic objectForKey:@"error_description"])
        {
            [details setValue:[responseDic objectForKey:@"error_description"] forKey:NSLocalizedDescriptionKey];
        }
        else
        {
            [details setValue:[responseDic objectForKey:@"error"] forKey:NSLocalizedDescriptionKey];
        }
        NSError* newError = [NSError errorWithDomain:@"Error" code:error.code userInfo:details];
        failure(newError);
    }
    else
    {
        if(error.code == kUnknownBaseURLError || error.code == -1002)
        {
            failure(nil);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UnauthorizedRequest" object:nil];
            
        }
        else
            failure(error);
    }
}

+(NSError*)getErrorForUnauthorised
{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"Unauthorized" forKey:NSLocalizedDescriptionKey];
    NSError* newError = [NSError errorWithDomain:@"Error" code:401 userInfo:details];
    return newError;
}
@end
