//
//  AFCallMeSessionManager.h
//  CallMe
//
//  Created by Martin Ulianko on 16/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^OAuthCompletitionBlock)(BOOL success);

@class OAuthSessionManager;

@protocol OAuthSessionManagerDelegate <NSObject>

@optional
- (void)oAuthSessionManager:(OAuthSessionManager *)sessionManager
					request:(NSURLRequest *)request
	  didReceive401Response:(NSHTTPURLResponse *)response
			 responseObject:(id)responseObject
					  error:(NSError *)error
		  completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler;


@required
- (BOOL)oAuthSessionManager:(OAuthSessionManager *)sessionManager shouldRefreshTokenForResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject error:(NSError *)error;
- (void)oAuthSessionManager:(OAuthSessionManager *)sessionManager refreshTokenForResponse:(NSHTTPURLResponse *)response completionHandler:(OAuthCompletitionBlock)completionHandler;

- (BOOL)oAuthSessionManager:(OAuthSessionManager *)sessionManager shouldReauthenticateForResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject error:(NSError *)error;
- (void)oAuthSessionManager:(OAuthSessionManager *)sessionManager reauthenticateForResponse:(NSHTTPURLResponse *)response completionHandler:(OAuthCompletitionBlock)completionHandler;

- (NSURLRequest *)oAuthSessionManager:(OAuthSessionManager *)sessionManager requestFromOriginalRequest:(NSURLRequest *)request;

- (void)oAuthSessionManager:(OAuthSessionManager *)sessionManager autheticationFailedForRequest:(NSURLRequest *)request;
@end

@interface OAuthSessionManager : AFHTTPSessionManager

@property (nonatomic, weak) id <OAuthSessionManagerDelegate> delegate;

- (void)performOriginalTaskForRquest:(NSURLRequest *)request
	   withOriginalCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler;
@end
