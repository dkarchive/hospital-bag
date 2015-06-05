//
//  Item.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

/**
 Item id.
 */
@property (nonatomic, readonly) NSInteger itemId;

/**
 Item count.
 */
@property (nonatomic, readonly) NSInteger count;

/**
 Item title.
 */
@property (nonatomic, readonly) NSString *title;

/**
 Create a list of items from a list of dictionary items.
 @param list List of dictionary items.
 @param keys Keys for the dictionary items.
 @return List of items.
 */
+ (NSArray *)itemsFromDictionaryList:(NSArray *)list keys:(NSDictionary *)keys;
    
@end
