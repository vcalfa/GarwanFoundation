//
//  AFCallMeSessionManager.m
//  CallMe
//
//  Created by Martin Ulianko on 16/04/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "AuthSessionManager.h"

@implementation AuthSessionManager

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)urlRequest completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler
{
	//create a completion block that wraps the original
	void (^authFailBlock)(NSURLResponse *response, id responseObject, NSError *error) = ^(NSURLResponse *response, id responseObject, NSError *error)
	{
		NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
		if([httpResponse statusCode] == 401){
			
			//since there was an error, call you refresh method and then redo the original task
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
				
				if ([self.delegate respondsToSelector:@selector(authSessionManager:receive401ForRequest:response:responseObject:completionHandler:)]) {
					[self.delegate authSessionManager:self receive401ForRequest:urlRequest response:httpResponse responseObject:responseObject completionHandler:originalCompletionHandler];
				}

			});
		}else{
			originalCompletionHandler(response, responseObject, error);
		}
	};
	
	NSURLSessionDataTask *task = [super dataTaskWithRequest:urlRequest completionHandler:authFailBlock];
	return task;
};


- (void)performOriginalTaskForRquest:(NSURLRequest *)request withOriginalCompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))originalCompletionHandler
{
	//now, queue up and execute the original task
	NSURLSessionDataTask *originalTask = [super dataTaskWithRequest:request completionHandler:originalCompletionHandler];
	[originalTask resume];
}

@end
