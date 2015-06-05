//
//  list.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "Database.h"

// Libraries
#import "FMDB.h"

NSString *database_key_id = @"id";
NSString *database_key_title = @"title";
NSString *database_key_detail = @"detail";
NSString *database_key_count = @"count";

@interface Database ()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation Database

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self)
        return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"babyready" ofType:@"db"];
    
    self.database = [FMDatabase databaseWithPath:path];
    
    if (![self.database open]) {
        return nil;
    }
    
    return self;
}

- (NSArray *)listForItemId:(NSInteger)itemId {
    [self debugLog: [NSString stringWithFormat:@"list for id: %@",@(itemId)] ];
    
    NSString *table = @"items";
    
    FMResultSet *resultSet = [self.database executeQuery: ({
        NSString *keys = @"id, section, sub, ordr";
        [NSString stringWithFormat: @"SELECT %@ FROM %@ WHERE parentid=%@ ORDER BY ordr", keys, table, @(itemId)];
    })];
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    while ([resultSet next]) {
        NSInteger anId = [resultSet intForColumnIndex:0];
        
        NSString *title = [resultSet stringForColumnIndex:1];
        
        NSString *detail = [resultSet stringForColumnIndex:2]?:@"";
        
        NSInteger count = ({
            [self.database intForQuery: ({
                NSString *countQuery = [NSString stringWithFormat:@"SELECT COUNT(section) FROM %@ WHERE parentid=%@", table, @(anId)];
                countQuery;
            })];
        });
        
        [list addObject: ({
            NSDictionary *item = @{
                                   database_key_id: @(anId),
                                   database_key_title: title,
                                   database_key_detail: detail,
                                   database_key_count: @(count),
                                   };
            item;
        }) ];
    }
    
    return list;
}

#pragma mark - Private

- (void)debugLog:(NSString *)log {
    if (self.debug) {
        NSLog(@"database - %@", log);
    }
}

@end
