//
//  Service.h
//  Breweria
//
//  Created by Martin Ulianko on 28/01/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "HTTPSessionManager.h"

@interface Service : NSObject

@property (nonatomic, strong, readonly) NSURL *baseURL;
@property (nonatomic, strong) HTTPSessionManager *httpSessionManager;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;
- (void)stopAll;
- (void)setServiceErrorHandler:(id<SessionManagerErrorProtocol>)errorHandler;

@end
