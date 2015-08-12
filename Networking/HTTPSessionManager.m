//
//  CMHTTPSessionManager.m
//  CallMe
//
//  Created by Vladimír Čalfa on 31/07/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "HTTPSessionManager.h"

@implementation HTTPSessionManager


- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)urlRequest completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler
{
    //create a completion block that wraps the original
    void (^authFailBlock)(NSURLResponse *response, id responseObject, NSError *error) = ^(NSURLResponse *response, id responseObject, NSError *error)
    {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        NSInteger statuscode = [httpResponse statusCode];
        

        if (statuscode != 200 && [self.errorDelegate respondsToSelector:@selector(sessionManager:statusCode:request:response:responseObject:error:)]) {
            [self.errorDelegate sessionManager:self statusCode:statuscode request:urlRequest response:response responseObject:responseObject error:error];
        }
        
        BOOL isCallOriginalErrorHandler = YES;
        
        if (statuscode != 200 && [self.errorDelegate respondsToSelector:@selector(shouldCallOriginalErrorHandlerSessionManager:statusCode:request:response:responseObject:error:)]) {
            isCallOriginalErrorHandler = [self.errorDelegate shouldCallOriginalErrorHandlerSessionManager:self statusCode:statuscode request:urlRequest response:response responseObject:responseObject error:error];
        }
        
        if (statuscode == 200 || (isCallOriginalErrorHandler && originalCompletionHandler != nil)) {
            originalCompletionHandler(response, responseObject, error);
        }
    };
    
    NSURLSessionDataTask *task = [super dataTaskWithRequest:urlRequest completionHandler:authFailBlock];
    return task;
};


@end
