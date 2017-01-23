//
//  APIResponseHandler.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface ApiResponseHandler : NSObject
+ (ApiResponseHandler *)sharedApiResponseHandlerInstance;
@property(nonatomic,strong)AFHTTPRequestOperationManager *httpManager;
#pragma mark - Domain Validation
-(void)fetchTestDataWithsuccessCompletionBlock:(void(^)(NSString* responseData))success failureCompletionBlock:(void(^)(NSError* error))failure;
@end
