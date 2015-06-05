//
//  NSNumber+HB.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/5/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "NSNumber+HB.h"

// Models
#import "Item.h"
#import "Database.h"

@implementation NSNumber (HB)

- (NSArray *)hb_itemsForItemId {
    NSArray *raw = [[Database sharedInstance] listForItemId:self.integerValue];
    NSDictionary *keys = @{
                           @"key_id":database_key_id,
                           @"key_count":database_key_count,
                           @"key_title":database_key_title,
                           @"key_detail":database_key_detail,
                           };
    return [Item itemsFromDictionaryList:raw keys:keys];
}

@end
