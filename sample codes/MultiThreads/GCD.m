/**
 *
 * 异步执行后台程序，并且更新 GUI
 *
 *
 *
 /
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_group_t group = dispatch_group_create();

dispatch_group_async(group, queue, ^{
	[NSThread sleepForTimeInterval:1];
	NSLog(@"completed task one!");
});

dispatch_group_async(group, queue, ^{
	[NSThread sleepForTimeInterval:1];
	NSLog(@"completed task two!");
});

dispatch_group_async(group, queue, ^{
	[NSThread sleepForTimeInterval:1];
	NSLog(@"completed task three!");
});

dispatch_group_notify(group, dispatch_get_main_queue(), ^{
	NSLog(@"all tasks is completed!");
});

