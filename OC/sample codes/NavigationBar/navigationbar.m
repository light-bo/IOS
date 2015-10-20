/*
 * 
 *
 * ios 6.0以后设置导航栏全透明
 *
 */
[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                              forBarMetrics:UIBarMetricsDefault];
  
//隐藏导航栏底部细线  
[self.navigationController.navigationBar setShadowImage:[UIImage new]];

//显示导航栏底部细线（默认）
self.navigationController.navigationBar setShadowImage:nil]
