/*************************************************************************/
//ios7以下的版本设置导航栏背景颜色可以使用
[[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];

//ios7以后：
[[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];

//默认带有一定透明效果，可以使用以下方法去除系统效果
[navigationController.navigationBar setTranslucent:NO];

/*************************************************************************/
