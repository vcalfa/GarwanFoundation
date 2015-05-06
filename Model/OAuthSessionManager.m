//
//  AFCallMeSessionManager.m
//  CallMe
//
//  Created by Martin Ulianko on 16/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "OAuthSessionManager.h"

@implementation OAuthSessionManager

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)urlRequest completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler
{
	//create a completion block that wraps the original
	void (^authFailBlock)(NSURLResponse *response, id responseObject, NSError *error) = ^(NSURLResponse *response, id responseObject, NSError *error)
	{
		NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
		if([httpResponse statusCode] == 401){
			
			//since there was an error, call you refresh method and then redo the original task
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
			
				
				// leave the job on delegate
				if ([self.delegate respondsToSelector:@selector(oAuthSessionManager:request:didReceive401Response:responseObject:error:completionHandler:)]) {
					[self.delegate oAuthSessionManager:self request:urlRequest didReceive401Response:httpResponse responseObject:responseObject error:error completionHandler:originalCompletionHandler];
				}
				
				// we care about this mess
				else {
					
					// refresh token
					if ([self.delegate oAuthSessionManager:self shouldRefreshTokenForResponse:httpResponse responseObject:responseObject error:error]) {
						[self.delegate oAuthSessionManager:self refreshTokenForResponse:httpResponse completionHandler:^(BOOL success) {
							
							// success
							// we try perform original task again
							if (success) {
								[self performOriginalTaskForRquest:urlRequest withOriginalCompletionHandler:originalCompletionHandler];
							}
							
							// failed
							// we try reauthentificate or logout
							else if ([self.delegate oAuthSessionManager:self shouldReauthenticateForResponse:httpResponse responseObject:responseObject error:error]){
								[self reauthenticateWithCredentialsForResponse:httpResponse  request:urlRequest completionHandler:originalCompletionHandler];
							}
							else {
								[self authetificationFailedForRequest:urlRequest];
							}
						}];
					}
					
					// reautheticate
					else if ([self.delegate oAuthSessionManager:self shouldReauthenticateForResponse:httpResponse responseObject:responseObject error:error]){
						[self reauthenticateWithCredentialsForResponse:httpResponse request:urlRequest completionHandler:originalCompletionHandler];
					}
					
					// logout
					else {
						[self authetificationFailedForRequest:urlRequest];
					}
				}
			});
		}else{
			originalCompletionHandler(response, responseObject, error);
		}
	};
	
	NSURLSessionDataTask *task = [super dataTaskWithRequest:urlRequest completionHandler:authFailBlock];
	return task;
};

- (void)reauthenticateWithCredentialsForResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler
{
	[self.delegate oAuthSessionManager:self reauthenticateForResponse:response completionHandler:^(BOOL success) {
		if (success) {
			[self performOriginalTaskForRquest:request withOriginalCompletionHandler:originalCompletionHandler];
		}
		else {
			[self authetificationFailedForRequest:request];
		}
	}];
}

- (void)authetificationFailedForRequest:(NSURLRequest *)request
{
	[self.delegate oAuthSessionManager:self autheticationFailedForRequest:request];
}

- (void)performOriginalTaskForRquest:(NSURLRequest *)request withAccessToken:(NSString *)accessToken withOriginalCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler
{
	request = [self.delegate oAuthSessionManager:self requestFromOriginalRequest:request];

	//now, queue up and execute the original task
	NSURLSessionDataTask *originalTask = [super dataTaskWithRequest:request completionHandler:originalCompletionHandler];
	[originalTask resume];
}
@end
