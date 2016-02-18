//instantiate a class by specific class name
NSString *className = @"...";
Class class = NSClassFromString(className);

if(class) {
    UIViewController *ctrl = class.new;
    ctrl.title = _titles[indexPath.row];
    [self.navigationController pushViewController:ctrl animated:YES];
}