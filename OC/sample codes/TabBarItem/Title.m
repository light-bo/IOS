- (void)setViewControllerTabBarItemAttributes:(UIViewController*)vc {
	//设置 tabBarItem 标题的显示位置（居中），
	//其中 UIOffsetMake 的第一个参数调整标题的水平位置，第二个参数调整标题的垂直位置
	[vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -7)];

	if([vc isKindOfClass:[SellViewController class]]) {
		vc.title = @"销售";
	} else if([vc isKindOfClass:[vc class]]) {
		vc.title = @"用户";
	}

	//设置标签页标题在不同状态下的字体的颜色
	[vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
		[UIFont systemFontOfSize:TabBarItem_Title_Font_size], NSFontAttributeName,
		[UIColor grayColor], NSForegroundColorAttributeName, nil]
			forState:UIControlStateNormal];

	[vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
		[UIFont systemFontOfSize:TabBarItem_Title_Font_size], NSFontAttributeName,
		[UIColor whiteColor], NSForegroundColorAttributeName, nil]
			forState:UIControlStateSelected];
}
