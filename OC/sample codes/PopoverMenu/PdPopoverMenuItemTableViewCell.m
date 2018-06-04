//
//  PdPopoverMenuItemTableViewCell.m
//  Loopin
//
//  Created by light_bo on 2017/2/17.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdPopoverMenuItemTableViewCell.h"
#import "UIFont+Custom.h"
#import "PdPopoverMenuModel.h"

@interface PdPopoverMenuItemTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *menuTitleLabel;

@end

@implementation PdPopoverMenuItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubViews];
    }
    
    
    return self;
}

- (void)configSubViews {
    _iconImageView = [UIImageView new];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _menuTitleLabel = [UILabel new];
    _menuTitleLabel.font = [UIFont mediumSystemFontOfSize:15];
    _menuTitleLabel.textColor = Pd_Content_Color;
    [self addSubview:_menuTitleLabel];
    [_menuTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)setUpData:(PdPopoverMenuModel *)menuItemMoel {
    _iconImageView.image = [UIImage imageNamed:menuItemMoel.iconImageName];
    _menuTitleLabel.text = menuItemMoel.menuName;
}



@end
