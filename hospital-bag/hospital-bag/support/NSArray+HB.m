//
//  NSArray+HB.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/5/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "NSArray+HB.h"

// Models
#import "Item.h"

@implementation NSArray (HB)

- (NSArray *)hb_idsForItems {
    __block NSMutableArray *temp = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        [temp addObject:@(obj.itemId)];
    }];
    
    return temp.copy;
}


@end
