//
//  LaunchManager.m
//  CallMe
//
//  Created by Martin Ulianko on 19/05/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "LaunchManager.h"

#define LaunchManagerErrorDomain @"LaunchManagerErrorDomain"

@interface LaunchManager()
@property (nonatomic) NSInteger actualReconnnectCount;
@property (nonatomic, copy) SilentLoginCompletionHandler handler;
@end

@implementation LaunchManager

- (instancetype)initWithDelegate:(NSObject<LaunchManagerDelegate> *)delegate
{
	if (self = [super init]) {
		self.delegate = delegate;
		self.maxRetryCount = 3;
		self.delayBetweenReconnects = 10;
		self.actualReconnnectCount = 0;
	}
	return self;
}

- (void)makeSilentLoginWithCompletion:(SilentLoginCompletionHandler)completionHandler
{
	self.actualReconnnectCount = 0;
	[self startWithCompletionHandler:completionHandler];
}

- (void)startWithCompletionHandler:(SilentLoginCompletionHandler)completionHandler
{
	__block LaunchManager *bself = self;
	__block SilentLoginCompletionHandler cHandler = completionHandler;
	self.handler = ^(BOOL success, id responseObject, NSError *error)
	{
		if (success) {
			completionHandler(success, responseObject, error);
		}
		else {
			[bself performSelector:@selector(startWithCompletionHandler:) withObject:cHandler afterDelay:bself.delayBetweenReconnects];
		}
	};
	if (self.actualReconnnectCount < self.maxRetryCount) {
		self.actualReconnnectCount++;
		[self.delegate loadDataWithCompletion:self.handler];
	}
	else {
		NSError *error = [[NSError alloc] initWithDomain:LaunchManagerErrorDomain
													code:0
												userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Unexpected error, max retry count reached", nil),
														   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Max retry count reached", nil)}];
		completionHandler(NO, nil, error);
	}
}


@end
