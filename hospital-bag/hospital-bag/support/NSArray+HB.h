//
//  NSArray+HB.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/5/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Array category. */
@interface NSArray (HB)

/**
 List of ids from a list of items.
 @return List of ids.
 */
- (NSArray *)hb_idsForItems;

@end
