//
//  DateValueTransformer.m
//  CallMe
//
//  Created by Martin Ulianko on 20/03/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "TimestampTransformer.h"
#import <Mantle/Mantle.h>

@implementation TimestampTransformer

+ (NSValueTransformer *)timestampValueTransformer
{
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber *timestamp) {
		return timestamp ? [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]] : nil;
	} reverseBlock:^id(NSDate *date) {
		return @([date timeIntervalSince1970]);
	}];
}
@end
