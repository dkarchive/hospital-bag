//
//  UserData.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/2/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "UserData.h"

NSString *ud_toggled = @"ud_toggled";

@implementation UserData

+ (BOOL)isToggledItemId:(NSInteger)itemId {
    NSNumber *item = @(itemId);    
    NSArray *list = [self list];
    
    return [list containsObject:item];
}

+ (BOOL)isToggledList:(NSArray *)list {
    __block NSInteger compared = 0;
    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *item = (NSNumber *)list[idx];
        if ([self isToggledItemId:item.integerValue]) {
            compared++;
        }
    }];
    
    return list.count==compared;
}

+ (void)toggleItemId:(NSInteger)itemId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:({
        NSArray *original = [self list];
        NSMutableArray *temp = original.mutableCopy;
        NSNumber *item = @(itemId);
        [temp containsObject:item]?[temp removeObject:item]:[temp addObject:item];
        temp.copy;
    }) forKey:ud_toggled];
    [defaults synchronize];
}

#pragma mark - Private

+ (NSArray *)list {
    NSArray *temp = [[NSUserDefaults standardUserDefaults] objectForKey:ud_toggled];
    if (!temp)
        return [[NSMutableArray alloc] init];
    
    return temp;
}

@end
