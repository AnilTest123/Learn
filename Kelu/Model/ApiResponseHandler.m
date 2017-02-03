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

- (void)fetchSoudFileAndStoreForTextWithUrl:(NSURL *)fileUrl  fileSavePath:(NSString *)fileSavePath withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure
{
    // Step 1: create NSURL with full path to downloading file
    // for example try this: NSString *fileUrl = @"https://pbs.twimg.com/profile_images/2331579964/jrqzn4q29vwy4mors75s_400x400.png";
    // And create NSURLRequest object with our URL
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    
    // Step 2: save downloading file's name
    // For example our fileName string is equal to 'jrqzn4q29vwy4mors75s_400x400.png'
    
    // Step 3: create AFHTTPRequestOperation object with our request
    AFHTTPRequestOperation *downloadRequest = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Step 4: set handling for answer from server and errors with request
    [downloadRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // here we must create NSData object with received data...
        NSData *data = [[NSData alloc] initWithData:responseObject];
        // ... and save this object as file
        // Here 'pathToFile' must be path to directory 'Documents' on your device + filename, of course
        [data writeToFile:fileSavePath atomically:YES];
        success(fileSavePath);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"file downloading error : %@", [error localizedDescription]);
        failure(error);
    }];
    
    // Step 5: begin asynchronous download
    [downloadRequest start];
}

@end
