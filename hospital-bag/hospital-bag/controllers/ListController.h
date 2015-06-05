//
//  ListController.h
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import <UIKit/UIKit.h>

/** List controller. */
@interface ListController : UITableViewController

/**
 Load (display) controller data source.
 @param itemId Database item id.
 */
- (void)list_loadDataSourceForItemId:(NSInteger)itemId;

@end

