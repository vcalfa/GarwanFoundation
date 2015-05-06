//
//  Service.m
//  Breweria
//
//  Created by Martin Ulianko on 28/01/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import "Service.h"

@interface Service()
@end

@implementation Service

- (instancetype)init
{
	if (self = [super init]) {
		[self setup];		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAll) name:@"stopAllServices" object:nil];
	}
	
	return self;
}

- (void)setup
{
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	self.urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
	
	self.httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL sessionConfiguration:configuration];
	self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
	self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
}

- (void)stopAll
{
	[self.urlSessionManager invalidateSessionCancelingTasks:YES];
	[self.httpSessionManager invalidateSessionCancelingTasks:YES];

	[self setup];
}

- (NSURL *)baseURL
{
	return [NSURL URLWithString:[kServiceHost stringByAppendingString:kServiceVersion]];
}

- (NSString *)baseURLString
{
	return [self.serviceHost stringByAppendingString:self.serviceVersion];
}

- (NSString *)serviceURLStringWithString:(NSString *)actionPath
{
	return [[self baseURLString] stringByAppendingString:actionPath];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
