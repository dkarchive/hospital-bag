//
//  UserData.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/2/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

/** User data model. */
@interface UserData : NSObject

/**
 Whether an item is toggled (mark done).
 @param itemId Id of the item.
 @return A Boolean that represents if the item is toggled.
 */
+ (BOOL)isToggledItemId:(NSInteger)itemId;

/**
 Whether a list of items are toggled (mark done).
 @param list List of item ids.
 @return A Boolean that represents if the list is toggled.
 */
+ (BOOL)isToggledList:(NSArray *)list;

/**
 Toggle an item.
 @param itemId Id of the item to toggle.
 */
+ (void)toggleItemId:(NSInteger)itemId;

@end
