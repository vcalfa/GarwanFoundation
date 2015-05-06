//
//  TokenService.m
//  CallMe
//
//  Created by Martin Ulianko on 17/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "TokenService.h"

@implementation TokenService

@synthesize httpSessionManager = _httpSessionManager;

- (void)setup
{
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	self.urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
	
	self.httpSessionManager = [[OAuthSessionManager alloc] initWithBaseURL:self.baseURL sessionConfiguration:configuration];
	self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
	self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
}
@end
