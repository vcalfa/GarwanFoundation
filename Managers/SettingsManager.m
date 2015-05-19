//
//  KeychainManager.m
//  CallMe
//
//  Created by Martin Ulianko on 17/03/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "SettingsManager.h"
#import <KeychainItemWrapper/KeychainItemWrapper.h>

@implementation SettingsManager

@dynamic username;
@dynamic password;

- (NSString *)username
{
	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kCurrentUserCredentialsKey accessGroup:nil];
	NSString *keychainUserName = [keychain objectForKey:(__bridge id)kSecAttrAccount];
	return ([keychainUserName isEqualToString:@""])?nil:keychainUserName;
}

- (void)setUsername:(NSString *)username
{
	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kCurrentUserCredentialsKey accessGroup:nil];
	[keychain setObject:username forKey:(__bridge id)kSecAttrAccount];
}

- (NSString *)password
{
	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kCurrentUserCredentialsKey accessGroup:nil];
	NSString *keychainPassword = [keychain objectForKey:(__bridge id)kSecValueData];
	return ([keychainPassword isEqualToString:@""])?nil:keychainPassword;}

- (void)setPassword:(NSString *)password
{
	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kCurrentUserCredentialsKey accessGroup:nil];
	[keychain setObject:password forKey:(__bridge id)kSecValueData];
}

- (BOOL)isLoggedIn
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:kCurrentUserLoggedInKey];
}

- (void)setLoggedIn:(BOOL)loggedIn
{
	[[NSUserDefaults standardUserDefaults] setBool:loggedIn forKey:kCurrentUserLoggedInKey];
}


- (void)resetLoginData
{
	//reset creditians
	KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kCurrentUserCredentialsKey accessGroup:nil];
	[keychain resetKeychainItem];
	
	[self setLoggedIn:NO];
}

@end
