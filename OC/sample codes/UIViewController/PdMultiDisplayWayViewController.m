//
//  PdPresentViewController.m
//  Loopin
//
//  Created by light_bo on 2017/1/16.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdMultiDisplayWayViewController.h"
#import "UIViewController+PDKit.h"


@interface PdMultiDisplayWayViewController ()

@property (nonatomic, strong) UIImageView *customNavigationBar;
@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) UILabel *navigationBarTitleLabel;
@property (nonatomic, strong) UIImageView *navigationBarTitleImageView;
@property (nonatomic, strong) UIButton *closeBtn;


@end


@implementation PdMultiDisplayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTopBar];
}

- (void)configTopBar {
    if ([self displayViewControllerWithPushWay]) {
        [self configNavigationBarArrowBackBtn:self withAction:@selector(backBtnClicked)];
        [self configNavigationBarTitle:[self navigationBarTitle]];
    } else {
        [self configCustomNavigationBar];
    }
}

- (void)configCustomNavigationBar {
    _customNavigationBar = [UIImageView new];
    _customNavigationBar.userInteractionEnabled = YES;
    _customNavigationBar.image = [UIImage imageNamed:@"navigationbackImage"];
    [self.view addSubview:_customNavigationBar];
    [_customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(Pd_NavigationBar_Height));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(Pd_StatusBar_Height);
    }];
    
    _shadowImageView = [UIImageView new];
    _shadowImageView.image = [UIImage imageNamed:@"navigationShow"];
    [self.view addSubview:_shadowImageView];
    [_shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.left.equalTo(_customNavigationBar.mas_left);
        make.right.equalTo(_customNavigationBar.mas_right);
        make.top.equalTo(_customNavigationBar.mas_bottom);
    }];
    
    if ([self navigationBarTitleIsTitleText]) {
        _navigationBarTitleLabel = [UILabel new];
        _navigationBarTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navigationBarTitleLabel.font = [UIFont systemFontOfSize:17];
        _navigationBarTitleLabel.textColor = Pd_Title_Color_Vc;//字体颜色
        _navigationBarTitleLabel.backgroundColor = [UIColor clearColor];
        _navigationBarTitleLabel.text = [self navigationBarTitle];
        [_customNavigationBar addSubview:_navigationBarTitleLabel];
        [_navigationBarTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_customNavigationBar.mas_centerX);
            make.centerY.equalTo(_customNavigationBar.mas_centerY);
        }];
    } else {
        _navigationBarTitleImageView = [UIImageView new];
        _navigationBarTitleImageView.image = [self navigationBarTitleImage];
        [_customNavigationBar addSubview:_navigationBarTitleImageView];
        [_navigationBarTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_customNavigationBar.mas_centerX);
            make.centerY.equalTo(_customNavigationBar.mas_centerY);
        }];
    }

    if (![self displayViewControllerWithPushWay]) {
        _closeBtn = [UIButton new];
        [_closeBtn setImage:[UIImage imageNamed:@"loopin_present_close"] forState:UIControlStateNormal];
        _closeBtn.hidden = ![self displayCloseBtn];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [_customNavigationBar addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@44);
            make.left.equalTo(_customNavigationBar.mas_left).offset(9);
            make.centerY.equalTo(_customNavigationBar.mas_centerY);
        }];
    }
}


#pragma mark - close btn
- (void)closeBtnClicked {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

#pragma mark - 返回按钮
- (void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 自定义注入方法
/**
 *  是否以 push 的方式显示该 viewcontroller
 *
 */
- (BOOL)displayViewControllerWithPushWay {
    return YES;
}


/**
 *  导航栏使用的标题是否是文本或者是图片
 *
 */
- (BOOL)navigationBarTitleIsTitleText {
    return YES;
}


/**
 * 导航栏标题文本
 *
 */
- (NSString *)navigationBarTitle {
    return nil;
}


/**
 * 导航栏标题图片
 *
 */
- (UIImage *)navigationBarTitleImage {
    return nil;
}


/**
 * present 显示状态下是否显示关闭按钮
 *
 */
- (BOOL)displayCloseBtn {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
