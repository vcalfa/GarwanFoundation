//
//  AFCallMeSessionManager.h
//  CallMe
//
//  Created by Martin Ulianko on 16/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFOAuth2Manager/AFHTTPRequestSerializer+OAuth2.h>
#import "HTTPSessionManager.h"

typedef void (^OAuthCompletitionBlock)(BOOL success);

@class AuthSessionManager;

@protocol AuthSessionManager <NSObject>
@required

- (void)authSessionManager:(AuthSessionManager *)sessionManager
	  receive401ForRequest:(NSURLRequest *)urlRequest
				  response:(NSHTTPURLResponse *)response
			responseObject:(id)responseObject
		 completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler;

@end

@interface AuthSessionManager : HTTPSessionManager

@property (nonatomic, weak) id <AuthSessionManager> delegate;

- (void)performOriginalTaskForRquest:(NSURLRequest *)request withOriginalCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler;
@end
