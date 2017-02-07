//
//  APIResponseHandler.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeluAFHTTPRequestOperationManager.h"

@interface ApiResponseHandler : NSObject

@property (nonatomic, strong) KeluAFHTTPRequestOperationManager *httpManager;

#pragma mark - Shared Instance
+ (ApiResponseHandler *)sharedApiResponseHandlerInstance;

#pragma mark - Reset
+ (void)resetSharedInstance;

#pragma mark - API Calls

#pragma mark Register User
-(void)registerUserWith:(NSMutableDictionary*)user withSuccessCompletionBlock:(void(^)(NSString*responseData))success
withFailureCompletionBlock:(void(^)(NSError*error))failure;
- (void)signInUserWith:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure;

#pragma mark - Text
- (void)fetchTextWithParams:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure;
#pragma mark - Languages
- (void)fetchLanguagesWithParams:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure;
#pragma mark - Themes
- (void)fetchThemesWithParams:(NSMutableDictionary *)parameters withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure;

- (void)fetchSoudFileAndStoreForTextWithUrl:(NSURL *)fileUrl  fileSavePath:(NSString *)fileSavePath withSuccessCompletionBlock:(void (^)(NSString *))success withFailureCompletionBlock:(void (^)(NSError *))failure;
@end
