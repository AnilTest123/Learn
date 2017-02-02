//
//  KeluAFHTTPRequestOperationManager.m
//  Kelu
//
//  Created by Anil Chopra on 25/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "KeluAFHTTPRequestOperationManager.h"

@implementation KeluAFHTTPRequestOperationManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url])
    {
        semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

@end
