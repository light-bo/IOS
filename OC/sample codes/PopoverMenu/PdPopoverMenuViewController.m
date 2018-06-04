//
//  PdPopoverMenuViewController.m
//  Loopin
//
//  Created by light_bo on 2017/2/17.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdPopoverMenuViewController.h"
#import "PdPopoverMenuItemTableViewCell.h"
#import "NSString+Custom.h"
#import "PdPopoverMenuModel.h"

static NSString *kMenuItemCellId = @"PdPopoverMenuItemTableViewCell";
static float kRowHeight = 50;

@interface PdPopoverMenuViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@end




@implementation PdPopoverMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
}


- (void)configSubViews {
    [self configTableView];
}


- (void)configTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = kRowHeight;
    [_tableView registerClass:[PdPopoverMenuItemTableViewCell class] forCellReuseIdentifier:kMenuItemCellId];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark --tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PdPopoverMenuItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuItemCellId forIndexPath:indexPath];
    
    PdPopoverMenuModel *model = _menuItemArray[indexPath.row];
    [cell setUpData:model];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(menuItemDidClicked: selectedIndex:)]) {
        [self.delegate menuItemDidClicked:self selectedIndex:indexPath.row];
    }
}

//重写preferredContentSize，让 popover 返回你期望的大小
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = [self queryItemMaxWidth] + 85;
        tempSize.height = _menuItemArray.count * kRowHeight - 1;//-1 是去掉最后 cell 下面的横线
        return tempSize;
    }else {
        return [super preferredContentSize];
    }
}


- (void)setPreferredContentSize:(CGSize)preferredContentSize{
    super.preferredContentSize = preferredContentSize;
}



#pragma mark --列表分割线左侧不留空隙
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if([UIDevice systemVersion] >= 8.0) {
        // Prevent the cell from inheriting the Table View's margin settings
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}


- (NSInteger)queryItemMaxWidth {
    float maxWidth = 0;
    for (PdPopoverMenuModel *popOverMenuModel in _menuItemArray) {
        float tempWidth = [popOverMenuModel.menuName textWidthWithFontSize:15];
        if (tempWidth > maxWidth) {
            maxWidth = tempWidth;
        }
    }
    
    return maxWidth;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
 
}



@end
