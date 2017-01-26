//
//  APIResponseHandler.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "ApiResponseHandler.h"
#import "ErrorHandler.h"

@interface ApiResponseHandler()

@property (nonatomic, strong) NSString *baseURL;

@end

@implementation ApiResponseHandler

static ApiResponseHandler *sharedApiResponseHandlerInstance = nil;
static dispatch_once_t dispatchOnce;

+ (ApiResponseHandler *)sharedApiResponseHandlerInstance{
    
    if (sharedApiResponseHandlerInstance == nil) {
        dispatch_once(&dispatchOnce, ^{
            sharedApiResponseHandlerInstance=[[ApiResponseHandler alloc]init];
            sharedApiResponseHandlerInstance.baseURL = @"http://yapp-env.elasticbeanstalk.com/api/";
        });
    }
    return sharedApiResponseHandlerInstance;
}

+ (void)resetSharedInstance
{
    sharedApiResponseHandlerInstance = nil;
    dispatchOnce = 0;
}

-(AFHTTPRequestOperationManager *)httpManager
{
    if(_httpManager)
        return _httpManager;
    else
    {   _httpManager = [KeluAFHTTPRequestOperationManager manager];
        return _httpManager;
    }
}


#pragma mark - Generic Method
-(void)performHttpOperationWithType:(NSString*)httpType WithBaseURL:(NSString*)baseURL withEndPoint:(NSString*)endPoint withParameteres:(NSMutableDictionary*)parameters SuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    //Not using base URL because its different in different scenario and hence combining all
    NSString *url = [[NSURL URLWithString:endPoint relativeToURL:[NSURL URLWithString:baseURL]] absoluteString];
    self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //Make sure the requestSerializer is AFHTTPRequestSerializer as the parameters needs to be added as part of URL;
    if([httpType isEqualToString:@"PUT"])
    {
        self.httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else
    {
        self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    
    if([httpType isEqualToString:@"POST"])
    {
        [_httpManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ErrorHandler verifySuccessResponseFromResponseOperation:operation WithSuccessCompletionBlock:success failureCompletionBlock:failure];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ErrorHandler fetchErrorFromResponseOperation:operation WithError:error WithfailureCompletionBlock:failure];
        }];
    }
    else if([httpType isEqualToString:@"GET"])
    {
        [_httpManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ErrorHandler verifySuccessResponseFromResponseOperation:operation WithSuccessCompletionBlock:success failureCompletionBlock:failure];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ErrorHandler fetchErrorFromResponseOperation:operation WithError:error WithfailureCompletionBlock:failure];
        }];
    }
    
    else if([httpType isEqualToString:@"PUT"])
    {
        [_httpManager PUT:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ErrorHandler verifySuccessResponseFromResponseOperation:operation WithSuccessCompletionBlock:success failureCompletionBlock:failure];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ErrorHandler fetchErrorFromResponseOperation:operation WithError:error WithfailureCompletionBlock:failure];
        }];
    }
    
    else if([httpType isEqualToString:@"DELETE"])
    {
        [_httpManager DELETE:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ErrorHandler verifySuccessResponseFromResponseOperation:operation WithSuccessCompletionBlock:success failureCompletionBlock:failure];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ErrorHandler fetchErrorFromResponseOperation:operation WithError:error WithfailureCompletionBlock:failure];
        }];
    }
}


- (void)registerUserWith:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    [self performHttpOperationWithType:@"POST" WithBaseURL:self.baseURL withEndPoint:@"createuser/" withParameteres:parameters SuccessCompletionBlock:success withFailureCompletionBlock:failure];
}

- (void)signInUserWith:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    [self performHttpOperationWithType:@"POST" WithBaseURL:self.baseURL withEndPoint:@"user/login/" withParameteres:parameters SuccessCompletionBlock:success withFailureCompletionBlock:failure];
}

#pragma mark - Fetch Text 
- (void)fetchTextWithParams:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    [self performHttpOperationWithType:@"GET" WithBaseURL:self.baseURL withEndPoint:@"textsresponse/get_tag_texts/" withParameteres:parameters SuccessCompletionBlock:success withFailureCompletionBlock:failure];
}

#pragma mark - Languages
- (void)fetchLanguagesWithParams:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    [self performHttpOperationWithType:@"GET" WithBaseURL:self.baseURL withEndPoint:@"language/get_available_languages/" withParameteres:parameters SuccessCompletionBlock:success withFailureCompletionBlock:failure];
}

#pragma mark - Themes
- (void)fetchThemesWithParams:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    [self performHttpOperationWithType:@"GET" WithBaseURL:self.baseURL withEndPoint:@"locationtags/" withParameteres:parameters SuccessCompletionBlock:success withFailureCompletionBlock:failure];
}

@end
