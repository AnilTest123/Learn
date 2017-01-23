//
//  APIResponseHandler.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "ApiResponseHandler.h"
#import "ErrorHandler.h"

@implementation ApiResponseHandler
static ApiResponseHandler *sharedApiResponseHandlerInstance = nil;
static dispatch_once_t dispatchOnce;

+ (ApiResponseHandler *)sharedApiResponseHandlerInstance{
    
    if (sharedApiResponseHandlerInstance == nil) {
        dispatch_once(&dispatchOnce, ^{
            sharedApiResponseHandlerInstance=[[ApiResponseHandler alloc]init];
        });
    }
    return sharedApiResponseHandlerInstance;
}

#pragma mark - Fetch Test Data
-(void)fetchTestDataWithsuccessCompletionBlock:(void(^)(NSString* responseData))success failureCompletionBlock:(void(^)(NSError* error))failure
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    AFHTTPRequestOperationManager *httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com"]];
    
    httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    [httpClient GET:@"posts" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        dispatch_sync(t, ^{
            
           
        });
        
        [ErrorHandler verifySuccessResponseFromResponseOperation:operation WithSuccessCompletionBlock:success failureCompletionBlock:failure];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ErrorHandler fetchErrorFromResponseOperation:operation WithError:error WithfailureCompletionBlock:failure];
    }];
}
@end
