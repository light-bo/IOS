//
//  BaseViewController.m
//  YiniuE-Commerce
//
//  Created by 张帅 on 14-10-16.
//  Copyright (c) 2014年 zs. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+CalculateSize.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>
{
    //指示器
    UIActivityIndicatorView *activityIndicatorView;
    UIView *customAlertView;
    UIImageView *actiImgView;
    UIImageView *actiBgImgView;
}

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    //进行一些iOS7的适配
    if (iOS7_VERSIONS_LATTER) {
        //隐藏状态栏
//        [self prefersStatusBarHidden];
        //让iOS7导航控制器不透明
        self.navigationController.navigationBar.translucent = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    /**
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
     */
    
    if (iOS7_VERSIONS_LATTER) {
        //导航栏颜色
        //self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xe92044);
        self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xF8F8F8);
        [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];

    }else{
        self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xF8F8F8);
    }
    //[[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
    //[self.navigationItem setHidesBackButton:YES];

}

- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}

- (BOOL)isSecondViewController
{
    return (self == [self.navigationController.viewControllers objectAtIndex:1]);
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //DLog(@"viewWillAppear");
    
    self.tabBarController.tabBar.hidden = YES;

    //处理滑动返回到rootViewController时当滑动一半松开界面没滑动过去
    if (self.navigationController.viewControllers.count > 1) {
        if ([self isSecondViewController]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"testHideTabbar" object:nil];
        }
    }
    [self pageVisitDataStatistics];
    //[MobClick beginLogPageView:@"BaseViewController"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    DLog(@"当前类名 %@",[self class]);
    //[MobClick endLogPageView:@"BaseViewController"];
}

#pragma mark -- 导航栏标题
- (void)createNaviTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.font = [UIFont systemFontOfSize:21];
    label.textColor = UIColorFromRGB(0x111111);
    label.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = label;
}

#pragma mark -- 导航栏左按钮
- (void)createNaviLeftButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action
{
    //CGRectMake(0, 7, 60, 44)
    UIImage *img;
    if (imageName.length > 0) {
        img = IMAGE(imageName);
    }else{
        img = nil;
    }

    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, frame.size.width-img.size.width)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
//    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor blackColor];
    //button.titleLabel.backgroundColor = UIColorFromRGB(0x848689);
    //button.titleLabel.textColor = UIColorFromRGB(0x848689);
    [button setTitleColor:UIColorFromRGB(0x848689) forState:UIControlStateNormal];

    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBackItem;
    
}

#pragma mark -- 导航栏右按钮
- (void)createNaviRightButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action
{
    //CGRectMake(0, 0, 60, 44)
    UIImage *img;
    if (imageName.length > 0) {
        img = IMAGE(imageName);
    }else{
        img = nil;
    }

    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
//    button.layer.borderWidth = 0.5;
//    button.layer.borderColor = UIColorFromRGB(0xbfbfbf).CGColor;
//    button.layer.cornerRadius = 2.5;
//    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, frame.size.width-img.size.width, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

//    button.backgroundColor = [UIColor blackColor];

    UIBarButtonItem *rightTOViewItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightTOViewItem;
}

- (void)createNaviRightButtonWithTitle:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:STRETCHABLE_IMAGE(imageName)];
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(0, 7, 60, 30);

    UILabel *label = [[UILabel alloc] initWithFrame:imageView.bounds];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromRGB(0x848689);
    label.backgroundColor = UIColorFromRGB(0xF8F8F8);
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = UIColorFromRGB(0xbfbfbf).CGColor;
    label.layer.cornerRadius = 2.5;
    [imageView addSubview:label];

    UIButton *button = [[UIButton alloc] initWithFrame:imageView.bounds];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];

    UIBarButtonItem *rightBackItm = [[UIBarButtonItem alloc] initWithCustomView:imageView];

    self.navigationItem.rightBarButtonItem = rightBackItm;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)string titleColor:(NSInteger)hexValue font:(CGFloat)font backgroundImage:(UIImage *)bgimage image:(UIImage *)image target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:string forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(hexValue) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setBackgroundImage:bgimage forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}

//通用UIView
+ (UIView *)createViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIView *v = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height)];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    [v addSubview:imageView];
    
    return v;
}

//通用UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame backgroundColor:(UIColor *)color text:(NSString *)text font:(CGFloat)font textAg:(NSTextAlignment)alignment textColor:(NSInteger)hexValue
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = color;
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    label.textColor = UIColorFromRGB(hexValue);
    
    return label;
}

//通用UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)string font:(CGFloat)font textAg:(NSTextAlignment)alignment textColor:(NSInteger)hexValue
{
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.placeholder = string;
    tf.textAlignment = alignment;
    tf.textColor = UIColorFromRGB(hexValue);
    tf.font = [UIFont systemFontOfSize:font];
    
    return tf;
}

- (UIImage *)stretchableImage:(UIImage *)image
{
    NSInteger leftCapWidth = image.size.width*0.5f;
    NSInteger topCapHeight = image.size.height*0.5f;
    UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    return stretchImage;
}

+ (UILabel *)smallPicWithFrame:(CGRect)frame withBorder:(BOOL)yesOrNo
{
    UILabel *small = [[UILabel alloc] initWithFrame:frame];
    small.backgroundColor = UIColorFromRGB(0xd7001d);
    small.layer.cornerRadius = frame.size.width/2;
    small.layer.masksToBounds = YES;
    small.textAlignment = NSTextAlignmentCenter;
    small.textColor = [UIColor whiteColor];
    small.font = [UIFont systemFontOfSize:11.0];

    //添加边框
    if (yesOrNo == YES) {
        CALayer * layer = [small layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = 1.0f;
    }

    //添加四个边阴影
//    small.layer.shadowColor = [UIColor whiteColor].CGColor;
//    small.layer.shadowOffset = CGSizeMake(0, 0);
//    small.layer.shadowOpacity = 0.5;
//    small.layer.shadowRadius = 10.0;

    return small;
}

//设置文本,带下划线
- (NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString withUnderlineStyle:(NSUnderlineStyle)underlineStyle withForegroundColor:(NSInteger)integer withLocation:(NSUInteger)loc withLength:(NSUInteger)len
{
    NSNumber *valuUnderline = [NSNumber numberWithInteger:underlineStyle];
    NSRange rangeAll = NSMakeRange(loc, len);
    //UIColor *foregroundColor = [UIColor blueColor];
    UIColor *foregroundColor = UIColorFromRGB(integer);
    NSMutableAttributedString *as = [attributedString mutableCopy];
    //[as addAttributes:@{NSForegroundColorAttributeName:fcolor} range:NSMakeRange(0, as.length)];
    
    [as beginEditing];
    [as addAttribute:NSUnderlineStyleAttributeName value:valuUnderline range:rangeAll];
    [as addAttribute:NSForegroundColorAttributeName value:foregroundColor range:rangeAll];
    [as endEditing];
    
    return as;
}

//不带下划线
- (NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString withTextColor:(NSInteger)integer withLocation:(NSUInteger)loc withLength:(NSUInteger)len
{
    NSRange rangeAll = NSMakeRange(loc, len);
    //UIColor *foregroundColor = [UIColor blueColor];
    UIColor *foregroundColor = UIColorFromRGB(integer);
    NSMutableAttributedString *as = [attributedString mutableCopy];
    //[as addAttributes:@{NSForegroundColorAttributeName:fcolor} range:NSMakeRange(0, as.length)];
    
    [as beginEditing];
    [as addAttribute:NSForegroundColorAttributeName value:foregroundColor range:rangeAll];
    
    [as endEditing];
    
    return as;
}

//设置字体
- (NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString withTextColor:(NSInteger)integer withFont:(CGFloat)font withLocation:(NSUInteger)loc withLength:(NSUInteger)len
{
    NSRange rangeAll = NSMakeRange(loc, len);
    //UIColor *foregroundColor = [UIColor blueColor];
    UIColor *foregroundColor = UIColorFromRGB(integer);
    //加粗
    UIFont *textFont = [UIFont boldSystemFontOfSize:font];
    NSMutableAttributedString *as = [attributedString mutableCopy];
    //[as addAttributes:@{NSForegroundColorAttributeName:fcolor} range:NSMakeRange(0, as.length)];

    [as beginEditing];
    [as addAttribute:NSForegroundColorAttributeName value:foregroundColor range:rangeAll];
    [as addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(loc, len)];
    [as endEditing];

    return as;
}

/**
 *  指示器
 */
- (void)showActivityIndicatorView:(UIView *)view withFrame:(CGRect)rect
{
    actiImgView = [[UIImageView alloc] initWithFrame:view.bounds];
    actiImgView.backgroundColor = [UIColor clearColor];
    actiImgView.userInteractionEnabled = NO;
    [view addSubview:actiImgView];

    //指示器
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame = rect;
    //[activityIndicatorView setCenter:view.center];
    [actiImgView addSubview:activityIndicatorView];

    [activityIndicatorView startAnimating];
}

- (void)createActivityIndicatorView:(UIView *)view
{
    actiBgImgView = [[UIImageView alloc] initWithFrame:view.bounds];
    actiBgImgView.backgroundColor = [UIColor clearColor];
    actiBgImgView.userInteractionEnabled = NO;
    [view addSubview:actiBgImgView];

    //指示器
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame = CGRectMake(actiBgImgView.frame.size.width/2-32/2, actiBgImgView.frame.size.height/2-32/2-49, 32, 32);
//    [activityIndicatorView setCenter:bgView.center];
    [actiBgImgView addSubview:activityIndicatorView];

    [activityIndicatorView startAnimating];
}

- (void)activityIndicatorViewStop
{
    [activityIndicatorView stopAnimating];

    activityIndicatorView.hidesWhenStopped = YES;

    [actiImgView removeFromSuperview];
    [actiBgImgView removeFromSuperview];
}

#pragma mark -- 类似alertView自定义view
/**
 *  1.添加在哪个view上
 *  2.左右按钮文本
 *  3.提示文本
 *  4.方法
 */
- (void)customAlertViewWithView:(UIView *)view frame:(CGRect)frame message:(NSString *)message leftButtonTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle leftBtnAction:(SEL)leftAction rightBtnAction:(SEL)rightAction
{
    //UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:<#(NSString *)#> message:<#(NSString *)#> delegate:<#(id)#> cancelButtonTitle:<#(NSString *)#> otherButtonTitles:<#(NSString *), ...#>, nil];

    customAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    customAlertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [view.window addSubview:customAlertView];

    //CGRectMake(kScreenWidth/2-600/2/2, kScreenHeight/2-250/2/2, 600/2, 250/2)
    UIView *showView = [[UIView alloc] initWithFrame:frame];
    showView.backgroundColor = [UIColor whiteColor];
    showView.layer.cornerRadius = 5.0;
    [customAlertView addSubview:showView];

    //提示文本
    UILabel *tipsLabel = [BaseViewController createLabelWithFrame:CGRectMake(10, 0, showView.frame.size.width-20, showView.frame.size.height-140/2) backgroundColor:[UIColor clearColor] text:message font:15.0 textAg:NSTextAlignmentCenter textColor:0x333333];
    tipsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipsLabel.numberOfLines = 0;
    [showView addSubview:tipsLabel];

    //分割线
    UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(showView.frame.size.width/2-520/2/2, CGRectGetMaxY(tipsLabel.frame), 520/2, 0.5)];
    lineLbl.backgroundColor = UIColorFromRGB(0xcccccc);
    [showView addSubview:lineLbl];

    //取消按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];//[BaseViewController createButtonWithFrame:CGRectMake(34/2, showView.frame.size.height-102/2, 230/2, 70/2) title:leftBtnTitle titleColor:0xadadad font:15.0 backgroundImage:nil image:nil target:self action:leftAction tag:2001];
    leftBtn.frame = CGRectMake(34/2, CGRectGetMaxY(lineLbl.frame)+36/2, 230/2, 70/2);
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColorFromRGB(0xadadad) forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    leftBtn.backgroundColor = UIColorFromRGB(0xf8f8f8);
    leftBtn.layer.cornerRadius = 3.0;
    [leftBtn addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:leftBtn];
    //加边框
    CALayer * detailLayer = [leftBtn layer];
    detailLayer.borderColor = [UIColorFromRGB(0xcccccc) CGColor];
    detailLayer.borderWidth = 0.5f;

    //确定按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];//[BaseViewController createButtonWithFrame:CGRectMake(showView.frame.size.width-34/2-230/2, showView.frame.size.height-102/2, 230/2, 70/2) title:rightBtnTitle titleColor:0xffffff font:15.0 backgroundImage:nil image:nil target:self action:rightAction tag:2002];
    rightBtn.frame = CGRectMake(showView.frame.size.width-34/2-230/2, CGRectGetMaxY(lineLbl.frame)+36/2, 230/2, 70/2);
    [rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    rightBtn.backgroundColor = UIColorFromRGB(0xe45252);
    rightBtn.layer.cornerRadius = 3.0;
    [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:rightBtn];

    //将自适应向布局约束的转化关掉(根据情况有时需要有时不需要)
    //[leftBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[rightBtn setTranslatesAutoresizingMaskIntoConstraints:NO];

    //创建一个存放约束的数组
    //NSMutableArray *tempConstraints = [NSMutableArray array];

    /*
     创建水平方向的约束:在水平方向,leftButton距离父视图左侧的距离为80，leftButton宽度为60,rightButton和leftButton之间的距离为30，rightButton宽60
     */
    //[tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-17-[leftBtn(==115)]-35-[rightButton(==115)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBtn,rightBtn)]];

    /*
     创建竖直方向的约束:在竖直方向上,leftButton距离父视图顶部30，leftButton高度30

     */
    //[tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[leftBtn(==70/2)-34/2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBtn)]];

    /*
     竖直方向的约束:在竖直方向上，rightButton距离其父视图顶部30，高度与leftButton的高度相同
     */
    //[tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[rightBtn(==leftBtn)-34/2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBtn,leftBtn)]];

    //给视图添加约束
    //[showView addConstraints:tempConstraints];
}

- (void)hideCustomAlertView
{
    [customAlertView removeFromSuperview];
}

#pragma mark -- 去掉最后一个字符
-(NSString*) removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}

#pragma mark -- 自定义搜索框
- (UITextField *)createCustomSearchTF:(CGRect)frame leftImage:(NSString *)imgName placeholder:(NSString *)placeholder
{
    /**
    CustomSearchBar *searchBarTF = [[CustomSearchBar alloc] initWithFrame:frame];
    searchBarTF.backgroundColor = UIColorFromRGB(0xffffff);
    searchBarTF.placeholder = placeholder;
    searchBarTF.font = [UIFont systemFontOfSize:13];
    if (iOS7_VERSIONS_LATTER) {
        [searchBarTF setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    }

    //设置左边的放大镜
    UIImageView *leftView=[[UIImageView alloc]init];
    leftView.image=IMAGE(imgName);
    searchBarTF.leftView=leftView;
    //设置leftViewMode
    searchBarTF.leftViewMode=UITextFieldViewModeAlways;
    //设置放大镜距离左边的间距，设置leftView的内容居中
    leftView.contentMode=UIViewContentModeCenter;
     */

    UITextField *searchBarTF = [[UITextField alloc] initWithFrame:frame];
    if (iOS7_VERSIONS_LATTER) {
        [searchBarTF setTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    }
    //设置键盘返回键风格为搜索
    [searchBarTF setReturnKeyType:UIReturnKeySearch];
    //设置背景图片
    searchBarTF.backgroundColor = UIColorFromRGB(0xffffff);
    //searchBar.textAlignment=NSTextAlignmentCenter;//说明：这是设置文字水平居中
    //设置文字内容垂直居中
    searchBarTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    //设置文字内容水平居左
    searchBarTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    //设置左边的放大镜
    UIImageView *leftView=[[UIImageView alloc]init];
    leftView.image=IMAGE(imgName);
    searchBarTF.leftView=leftView;
    //设置leftView的frame
    leftView.frame = CGRectMake(0, 0, 30, 35);
    //设置leftViewMode
    searchBarTF.leftViewMode=UITextFieldViewModeAlways;
    //设置放大镜距离左边的间距，设置leftView的内容居中
    leftView.contentMode=UIViewContentModeCenter;

    //设置placeholder字体颜色
    searchBarTF.placeholder = placeholder;
    searchBarTF.font = [UIFont systemFontOfSize:13.0];
    
    //设置边框
    searchBarTF.layer.borderColor = UIColorFromRGB(0xbfbfbf).CGColor;
    searchBarTF.layer.borderWidth = 0.5;

    return searchBarTF;
}

- (BOOL)parentVC:(NSString *)viewControllerClass
{
    BOOL vc = [[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[viewControllerClass class]];

    return vc;
}

#pragma mark -- 网络不给力提示
- (UIView *)networkIsNotConnectedTipsView:(UIView *)view prompt:(NSString *)prompt
{
    UIView *networkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    networkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [view addSubview:networkView];

    UILabel *tipsLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, networkView.frame.size.width, networkView.frame.size.height)];
    tipsLbl.text = prompt;
    tipsLbl.textAlignment = NSTextAlignmentCenter;
    tipsLbl.textColor = [UIColor whiteColor];
    tipsLbl.font = [UIFont systemFontOfSize:15.0];
    tipsLbl.backgroundColor = [UIColor clearColor];
    [networkView addSubview:tipsLbl];

    //可拓展添加点击事件,UIControl

    return networkView;
}

#pragma mark -- 无网络时的view
- (UIView *)customNoNetworkViewWithView:(UIView *)view promptImg:(NSString *)imgName promptTxt:(NSString *)promptTxt setBtnTitle:(NSString *)title action:(SEL)action
{
    UIView *noNetworkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBar_HEIGHT-kTabBar_HEIGHT-kStatus_HEIGHT)];
    noNetworkView.backgroundColor = [UIColor whiteColor];
    [view addSubview:noNetworkView];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-120/2/2, 200/2, 120/2, 82/2)];
    imageView.image = IMAGE(imgName);
    [noNetworkView addSubview:imageView];

    UILabel *promptLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+50/2, kScreenWidth, 21)];
    promptLbl.font = [UIFont systemFontOfSize:14.0];
    promptLbl.textColor = UIColorFromRGB(0x666666);
    promptLbl.text = promptTxt;
    promptLbl.textAlignment = NSTextAlignmentCenter;
    [noNetworkView addSubview:promptLbl];

    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(kScreenWidth/2-220/2/2, CGRectGetMaxY(promptLbl.frame)+20/2, 220/2, 80/2);
    [refreshBtn setTitle:title forState:UIControlStateNormal];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    refreshBtn.backgroundColor = ButtonColorForE92044;
    refreshBtn.layer.cornerRadius = 3.0;
    [refreshBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [noNetworkView addSubview:refreshBtn];

    return noNetworkView;
}

- (UIView *)customNoNetworkViewNoTabbarViewWithView:(UIView *)view promptImg:(NSString *)imgName promptTxt:(NSString *)promptTxt setBtnTitle:(NSString *)title action:(SEL)action
{
    UIView *noNetworkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBar_HEIGHT-kStatus_HEIGHT)];
    noNetworkView.backgroundColor = [UIColor whiteColor];
    [view addSubview:noNetworkView];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-120/2/2, 200/2, 120/2, 82/2)];
    imageView.image = IMAGE(imgName);
    [noNetworkView addSubview:imageView];

    UILabel *promptLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+50/2, kScreenWidth, 21)];
    promptLbl.font = [UIFont systemFontOfSize:14.0];
    promptLbl.textColor = UIColorFromRGB(0x666666);
    promptLbl.text = promptTxt;
    promptLbl.textAlignment = NSTextAlignmentCenter;
    [noNetworkView addSubview:promptLbl];

    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(kScreenWidth/2-220/2/2, CGRectGetMaxY(promptLbl.frame)+20/2, 220/2, 80/2);
    [refreshBtn setTitle:title forState:UIControlStateNormal];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    refreshBtn.backgroundColor = ButtonColorForE92044;
    refreshBtn.layer.cornerRadius = 3.0;
    [refreshBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [noNetworkView addSubview:refreshBtn];

    return noNetworkView;
}

-(void)pageVisitDataStatistics
{
    PageVisitDataStatistics *pageVisitDataStatistics = [[PageVisitDataStatistics alloc] initWithHost:nil andApi:nil];
    pageVisitDataStatistics.pageName = [NSString stringWithUTF8String:object_getClassName(self)];
    pageVisitDataStatistics.pageType = @"";
    pageVisitDataStatistics.params = nil;
    [[DataStatisticsManage shareInstance] sendStatistics:pageVisitDataStatistics];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
