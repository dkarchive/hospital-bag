//
//  Item+HB.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/5/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "Item.h"

/** Item category. */
@interface Item (HB)

/**
 Property that holds how many items (children items) are left.
 */
@property (nonatomic, readonly) NSInteger left;

@end
