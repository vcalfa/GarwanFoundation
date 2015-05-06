//
//  TokenService.h
//  CallMe
//
//  Created by Martin Ulianko on 17/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "Service.h"
#import "OAuthSessionManager.h"

@interface TokenService : Service

@property (nonatomic, strong) OAuthSessionManager *httpSessionManager;

@end
