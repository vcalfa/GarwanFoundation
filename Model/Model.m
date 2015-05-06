//
//  Model.m
//  Breweria
//
//  Created by Martin Ulianko on 28/01/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (instancetype)model
{
	return [self sharedInstance];
}

- (instancetype)init
{
	return [self initWithService:[[Service alloc] init]];
}

- (instancetype)initWithService:(Service *)service
{
	if (self = [super init]) {
		self.service = service;
	}
	
	return self;
}

@end
