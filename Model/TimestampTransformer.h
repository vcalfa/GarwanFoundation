//
//  DateValueTransformer.h
//  CallMe
//
//  Created by Martin Ulianko on 20/03/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimestampTransformer : NSObject

+ (NSValueTransformer *)timestampValueTransformer;
@end
