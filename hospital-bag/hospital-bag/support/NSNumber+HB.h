//
//  NSNumber+HB.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/5/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

/** NSNumber category. */
@interface NSNumber (HB)

/**
 List of items for an item id.
 @return List of items.
 */
- (NSArray *)hb_itemsForItemId;

@end
