//
//  ViewController.m
//  TestAutolayout
//
//  Created by lightning on 15/8/17.
//  Copyright (c) 2015年 com.yiniu.www. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMainView];
}

- (void)createMainView {
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.leftButton setTitle:@"left" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"right" forState:UIControlStateNormal];

    [self.view addSubview:_leftButton];
    [self.view addSubview:_rightButton];
    
    
    
    [self.leftButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSMutableArray *tempConstraint = [NSMutableArray array];
    [tempConstraint addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[_leftButton(==60)]-30-[_rightButton(==60)]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_leftButton, _rightButton)]];
    
    [tempConstraint addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_leftButton(==30)]"
                                                                                options:0 metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_leftButton)]];
    
    [tempConstraint addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_rightButton(==_leftButton)]"
                                                                                options:0 metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_rightButton, _leftButton)]];
    [self.view addConstraints:tempConstraint];
}



@end
