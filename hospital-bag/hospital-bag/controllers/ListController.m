//
//  ListController.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "ListController.h"

// Categories
#import "Item+HB.h"
#import "NSArray+HB.h"
#import "NSNumber+HB.h"

// Defines
#import "HBDefines.h"

// Frameworks
@import StoreKit;

// Libraries
#import "KLCPopup.h"
#import "SVProgressHUD.h"

// Models
#import "Item.h"
#import "UserData.h"

NSString *list_appName = @"Hospital Bag";
NSString *list_cellId = @"cellId";
NSInteger list_hospitalBagDatabaseId = 103;

@interface ListController () <SKStoreProductViewControllerDelegate>
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *babyReadyButton;
@end

@implementation ListController

- (instancetype)init {
    self = [super init];
    if (!self)return nil;
    
    //init
    self.footerView = [[UIView alloc] init];
    self.babyReadyButton = [[UIButton alloc] init];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bear"] style:UIBarButtonItemStylePlain target:self action:@selector(list_actionBabyReady)];
    
    //subviews
    [self.footerView addSubview:self.babyReadyButton];
    self.tableView.tableFooterView = self.footerView;
    self.navigationItem.leftBarButtonItem = barButton;
    
    //setup
    self.tableView.rowHeight = 50;
    
    self.footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.babyReadyButton.layer.cornerRadius = 6;
    self.babyReadyButton.layer.borderWidth = 0.5;
    self.babyReadyButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.babyReadyButton.titleLabel.font = [UIFont fontWithName:hb_font size:18];
    self.babyReadyButton.titleLabel.numberOfLines = 2;
    self.babyReadyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.babyReadyButton setTitle:@"Brought to you by\nBaby Ready" forState:UIControlStateNormal];
    [self.babyReadyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.babyReadyButton addTarget:self action:@selector(list_actionBabyReady) forControlEvents:UIControlEventTouchUpInside];
    
    [self list_loadDataSourceForItemId:list_hospitalBagDatabaseId];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.footerView.frame = ({
        CGRect frame = self.view.bounds;
        NSInteger rowHeight = 50;
        NSInteger navigationBar = 64;
        frame.size.height -= (rowHeight * 4 + navigationBar); // fill space below the first rows
        frame;
    });
    
    self.babyReadyButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{
                            @"button":self.babyReadyButton,
                            @"superview":self.footerView
                            };
    NSDictionary *metrics = @{
                              @"width":@180,
                              @"height":@56,
                              };
    [self.footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[button(width)]" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [self.footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[button(height)]" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = [self.title isEqualToString:@""] || !self.title ? list_appName : self.title;
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.title = @"";
}

#pragma mark - Private

- (void)list_actionBabyReady {
    [SVProgressHUD show];
    NSInteger appId = 583359854;
    
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSDictionary *parameters = @{ SKStoreProductParameterITunesItemIdentifier : @(appId) };
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
        [SVProgressHUD dismiss];
        if (result) {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
        else {
            NSLog(@"Problem loading app store controller, error=%@",error.localizedDescription);
        }
    }];
    
}

- (void)list_loadDataSourceForItemId:(NSInteger)itemId {
    if (itemId!=list_hospitalBagDatabaseId) {
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    self.dataSource = @(itemId).hb_itemsForItemId;
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:list_cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:list_cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [self list_font];
        cell.detailTextLabel.font = [self list_font];
        cell.textLabel.numberOfLines = 0;
    }
    
    Item *item = self.dataSource[indexPath.row];
    [self list_setupCell:cell item:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = self.dataSource[indexPath.row];
    
    if (item.count>0) {
        ListController *controller = [[ListController alloc] init];
        controller.title = item.title;
        [controller list_loadDataSourceForItemId:item.itemId];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else {
        [UserData toggleItemId:item.itemId];
        
        NSIndexPath *update = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [tableView reloadRowsAtIndexPaths:@[update] withRowAnimation:
         [UserData isToggledItemId:item.itemId]?UITableViewRowAnimationLeft:UITableViewRowAnimationRight
         ];
        
        // display completion alert
        NSArray *listOfIds = self.dataSource.hb_idsForItems;
        if ([UserData isToggledList:listOfIds]) {
            KLCPopup *popup = [KLCPopup popupWithContentView: ({
                UIColor *(^color)(CGFloat red, CGFloat green, CGFloat blue) = ^UIColor *(CGFloat red, CGFloat green, CGFloat blue) {
                    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
                };
                
                UIView *contentView = [[UIView alloc] init];
                UILabel *label = [[UILabel alloc] init];
                
                [contentView addSubview:label];
                
                contentView.backgroundColor = color(30, 220, 95);
                contentView.layer.cornerRadius = 4;
                
                label.textColor = color(17, 117, 30);
                label.font = [self list_font];
                label.numberOfLines = 3;
                label.text = ({
                    NSString *message = [NSString stringWithFormat:@"🎉\nYou've completed the list %@.", self.title];
                    message;
                });
                label.textAlignment = NSTextAlignmentCenter;
                
                contentView.frame = CGRectMake(0.0, 0.0, 200.0, 120.0);
                label.frame = ({
                    CGRect frame = contentView.bounds;
                    CGFloat pad = 10;
                    frame.origin = CGPointMake(pad, pad);
                    frame.size.width -= pad * 2;
                    frame.size.height -= pad * 2;
                    frame;
                });
                
                contentView;
            }) ];
            [popup show];
        }
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGRect rect = ({
//        Item *item = self.dataSource[indexPath.row];
//        NSDictionary *attributes = @{NSFontAttributeName:[self list_font]};
//        NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:item.title attributes:attributes];
//
//        CGFloat width = self.view.frame.size.width;
//        CGFloat paddingLeft = 16;
//        CGFloat paddingRight = 28;
//
//        [attributed boundingRectWithSize:CGSizeMake(width - paddingLeft - paddingRight, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    });
//
//    CGFloat height = ({
//        CGFloat paddingVertical = 15;
//        rect.size.height + paddingVertical * 2;
//    });
//
//    CGFloat heightMinimum = 50;
//    return height > heightMinimum?height:heightMinimum;
//}

#pragma mark Helpers

- (UIFont *)list_font {
    return [UIFont fontWithName:hb_font size:18];
}

- (void)list_setupCell:(UITableViewCell *)cell item:(Item *)item {
    void (^updateCell)(UITableViewCell *cell, BOOL toggle) = ^void(UITableViewCell *cell, BOOL toggle) {
        NSString *text = cell.textLabel.text;
        cell.textLabel.text = toggle?[NSString stringWithFormat:@"✓ %@", text]:text;
        cell.textLabel.textColor = toggle?[UIColor lightGrayColor]:[UIColor blackColor];
    };
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.left>0 ? @(item.left).stringValue : nil;
    updateCell(cell, [UserData isToggledItemId:item.itemId]);
    cell.accessoryType = item.count>0?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    
    // update cell if all children are toggled
    if (cell.accessoryType==UITableViewCellAccessoryDisclosureIndicator) {
        NSArray *list = ({
            NSArray *items = @(item.itemId).hb_itemsForItemId;
            items.hb_idsForItems;
        });
        
        updateCell(cell, [UserData isToggledList:list]);
    }
}

#pragma mark - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
