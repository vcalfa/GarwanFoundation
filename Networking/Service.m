//
//  Service.m
//  Breweria
//
//  Created by Martin Ulianko on 28/01/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import "Service.h"

@implementation Service

@synthesize baseURL = _baseURL;

- (instancetype)initWithBaseURL:(NSURL *)baseURL
{
	if (self = [super init]) {
		_baseURL = baseURL;
		[self setup];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAll) name:@"stopAllServices" object:nil];
	}
	
	return self;
}

- (void)setup
{
	self.httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
	self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
	self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
}

- (void)stopAll
{
	[self.httpSessionManager invalidateSessionCancelingTasks:YES];
	[self setup];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
