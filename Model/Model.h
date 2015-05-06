//
//  Model.h
//  Breweria
//
//  Created by Martin Ulianko on 28/01/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//
#import "Service.h"
#import <DOSingleton/DOSingleton.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void (^ModelCompletitionBlock)(BOOL success, id object, NSError *error);

@interface Model : DOSingleton

@property (nonatomic, strong) Service *service;

+ (instancetype)model;
- (instancetype)init;
- (instancetype)initWithService:(Service *)service;
@end
