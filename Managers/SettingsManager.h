//
//  KeychainManager.h
//  CallMe
//
//  Created by Martin Ulianko on 17/03/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DOSingleton/DOSingleton.h>

#define kCurrentUserLoggedInKey                 @"sk.garwan.CurrentUser.loggedIn"
#define kCurrentUserCredentialsKey              @"sk.garwan.CurrentUser.credentials"

@interface SettingsManager : DOSingleton

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, getter=isLoggedIn) BOOL loggedIn;
- (void)resetLoginData;
@end
