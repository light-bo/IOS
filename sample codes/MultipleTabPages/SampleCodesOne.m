/**
 * the codes support iOS 7.0 and later iOS version.
 *
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	UITabBarController *tabBarController = [[UITabBarController alloc] init];

	UIImage *unselecteImage = [[UIImage imageNamed:@"01"]
		                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//采用图片的原始格式，系统不对图片进行处理

	UIImage *selectedImage = [[UIImage imageNamed:@"02"]
						   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

	ViewController *vc1 = [[ViewController alloc] init];
	vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"微信" image:unselecteImage selectedImage:selectedImage];
	//...

	ViewControllerTwo *vc2 = [[ViewControllerTwo alloc] init];
	vc2.title = @"通讯录";
	//...

	ViewControllerThree *vc3 = [[ViewControllerThree alloc] init];
	vc3.title = @"发现";
	//...

	ViewControllerFour *vc4 = [[ViewControllerFour alloc] init];
	vc4.title = @"我";
	//...

	NSArray *viewControllers = [NSArray arrayWithObjects:vc1, vc2, vc3, vc4, nil];
	tabBarController.viewControllers = viewControllers;

	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tabBarController];


	self.window.rootViewController = nc;
	[self.window setTintColor:[UIColor greenColor]];


	[self.window makeKeyAndVisible];

	return YES;
}

