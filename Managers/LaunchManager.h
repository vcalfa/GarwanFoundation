//
//  LaunchManager.h
//  CallMe
//
//  Created by Martin Ulianko on 19/05/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SilentLoginCompletionHandler)(BOOL success, id responseObject, NSError *error);

@protocol LaunchManagerDelegate;

@interface LaunchManager : NSObject

/**
 maximal number of retry count
 defualt is 3
 */
@property (nonatomic) NSInteger maxRetryCount;

/**
 number of seconds between retry
 default is 10
 */
@property (nonatomic) NSInteger delayBetweenReconnects;

/**
 for loading datas, call services etc
 */
@property (nonatomic, weak) NSObject <LaunchManagerDelegate> *delegate;

- (instancetype)initWithDelegate:(NSObject <LaunchManagerDelegate> *)delegate;
- (void)makeSilentLoginWithCompletion:(SilentLoginCompletionHandler)completionHandler;
@end

@protocol LaunchManagerDelegate <NSObject>
- (void)loadDataWithCompletion:(SilentLoginCompletionHandler)completionHandler;
@end