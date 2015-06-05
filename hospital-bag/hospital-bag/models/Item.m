//
//  Item.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "Item.h"

@interface Item ()
@property (nonatomic) NSInteger itemId;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@end

@implementation Item

+ (NSArray *)itemsFromDictionaryList:(NSArray *)list keys:(NSDictionary *)keys {
    NSString *key_id = keys[@"key_id"];
    NSString *key_count = keys[@"key_count"];
    NSString *key_title = keys[@"key_title"];
    NSString *key_detail = keys[@"key_detail"];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in list) {
        Item *anItem = [[Item alloc] init];
        
        anItem.itemId = ({
            NSNumber *number = item[key_id];
            number.integerValue;
        });
        anItem.count = ({
            NSNumber *number = item[key_count];
            number.integerValue;
        });
        anItem.title = item[key_title];
        anItem.detail = item[key_detail];
        
        [temp addObject:anItem];
    }
    
    return temp.copy;
}

@end
