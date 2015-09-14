- (void)setLeftBarButtonItem {
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"< 前一天"
		                                                           style:UIBarButtonItemStylePlain
		                                                          target:self
		                                                          action:@selector(previousDayClicked)];
	self.navigationItem.leftBarButtonItem = leftButton;

	//设置导航栏上标题的颜色为白色
	[self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
		                                     [UIColor whiteColor], NSForegroundColorAttributeName, nil]
		                                                 forState:UIControlStateNormal];
}
