//
//  list.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *database_key_id;
extern NSString *database_key_title;
extern NSString *database_key_detail;
extern NSString *database_key_count;

/** Database mdoel object. */
@interface Database : NSObject

@property (nonatomic) BOOL debug;

/**
 Database shared instance.
 @return Shared instance of database.
 */
+ (instancetype)sharedInstance;

/**
 List of dictionary items from the database.
 @param itemId Database item id.
 @return List of items.
 */
- (NSArray *)listForItemId:(NSInteger)itemId;

@end
