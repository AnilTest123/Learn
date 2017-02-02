//
//  KeluAFHTTPRequestOperationManager.h
//  Kelu
//
//  Created by Anil Chopra on 25/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface KeluAFHTTPRequestOperationManager : AFHTTPRequestOperationManager
{
    dispatch_semaphore_t semaphore;
}

@end
