//
//  Item+HB.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/5/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "Item+HB.h"

// Categories
#import "NSArray+HB.h"
#import "NSNumber+HB.h"

// Models
#import "UserData.h"

@implementation Item (HB)

- (NSInteger)left {
    NSArray *items = @(self.itemId).hb_itemsForItemId;
    NSArray *children = items.hb_idsForItems;
    
    return ({
        NSInteger count = self.count;
        for (NSNumber *idNumber in children) {
            if ([UserData isToggledItemId:idNumber.integerValue]) {
                count--;
            }
        }
        count;
    });
}

@end
