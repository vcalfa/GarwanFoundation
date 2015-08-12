//
//  CMHTTPSessionManager.h
//  CallMe
//
//  Created by Vladimír Čalfa on 31/07/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class HTTPSessionManager;

@protocol SessionManagerErrorProtocol <NSObject>

- (BOOL)shouldCallOriginalErrorHandlerSessionManager:(HTTPSessionManager*)sessionManager statusCode:(NSInteger)statusCode request:(NSURLRequest *)urlRequest response:(NSURLResponse*)response responseObject:(id)object error:(NSError*)error;

- (void)sessionManager:(HTTPSessionManager*)sessionManager statusCode:(NSInteger)statusCode request:(NSURLRequest *)urlRequest response:(NSURLResponse*)response responseObject:(id)object error:(NSError*)error;

@end

@interface HTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, weak) id <SessionManagerErrorProtocol> errorDelegate;

@end
