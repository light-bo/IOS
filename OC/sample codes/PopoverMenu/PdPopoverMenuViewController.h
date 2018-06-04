//
//  PdPopoverMenuViewController.h
//  Loopin
//
//  Created by light_bo on 2017/2/17.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 sample usage:
 
 PdPopoverMenuViewController *popoverMenuVC = [[PdPopoverMenuViewController alloc] init];
 popoverMenuVC.menuItemArray = @[
 [[PdPopoverMenuModel alloc] initWithImageName:@"ico_creat_chat" withMenuName:LANGUAGE(@"ico_create_group")],
 [[PdPopoverMenuModel alloc] initWithImageName:@"ico_fina_chat" withMenuName:LANGUAGE(@"ico_find_group")]
 ];
 
 popoverMenuVC.delegate = self;
 popoverMenuVC.modalPresentationStyle = UIModalPresentationPopover;
 popoverMenuVC.popoverPresentationController.sourceView = _rightCreateBtn;  //rect参数是以view的左上角为坐标原点（0，0）
 popoverMenuVC.popoverPresentationController.sourceRect = _rightCreateBtn.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
 popoverMenuVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向
 popoverMenuVC.popoverPresentationController.delegate = self;
 popoverMenuVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
 
 [self presentViewController:popoverMenuVC animated:YES completion:nil];

 */

@class PdPopoverMenuModel;
@class PdPopoverMenuViewController;

@protocol PdPopoverMenuViewControllerDelegate <NSObject>

@optional
- (void)menuItemDidClicked:(PdPopoverMenuViewController *)menuVC selectedIndex:(NSInteger)selectedIndex;

@end


@interface PdPopoverMenuViewController : UIViewController

@property (nonatomic, strong) NSArray<PdPopoverMenuModel *> *menuItemArray;
@property (nonatomic, weak) id<PdPopoverMenuViewControllerDelegate> delegate;

@end
