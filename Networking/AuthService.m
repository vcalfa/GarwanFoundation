//
//  TokenService.m
//  CallMe
//
//  Created by Martin Ulianko on 17/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "AuthService.h"

@implementation AuthService

@synthesize httpSessionManager = _httpSessionManager;

- (void)setup
{
	self.httpSessionManager = [[AuthSessionManager alloc] initWithBaseURL:self.baseURL];
	self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
	self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
}

@end
