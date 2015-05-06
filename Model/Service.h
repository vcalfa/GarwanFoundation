//
//  Service.h
//  Breweria
//
//  Created by Martin Ulianko on 28/01/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NSString *const kServiceHost;
NSString *const kServiceVersion;

@interface Service : NSObject

@property (nonatomic, strong, readonly) NSString *serviceHost;
@property (nonatomic, strong, readonly) NSString *serviceVersion;
@property (nonatomic, strong, readonly) NSURL *baseURL;
@property (nonatomic, strong) AFURLSessionManager *urlSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;

- (NSString *)baseURLString;
- (NSString *)serviceURLStringWithString:(NSString *)actionPath;
- (void)stopAll;
@end
