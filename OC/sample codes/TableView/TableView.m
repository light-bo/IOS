//自定义 cell， 使用 xib
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//cell标识符，使cell能够重用
	static NSString *paperCell = @"paperCell";

	//注册自定义Cell的到TableView中，并设置cell标识符为paperCell,该语句应该写在 viewDidLoad 方法之中
	static BOOL isRegNib = NO;
	if (!isRegNib) {
		[tableView registerNib:[UINib nibWithNibName:@"WPaperCell" bundle:nil] forCellReuseIdentifier:paperCell];
		isRegNib = YES;
	}

	//从TableView中获取标识符为paperCell的Cell
	WPaperCell *cell = [tableView dequeueReusableCellWithIdentifier:paperCell];

	//设置单元格属性
	[cell setupCell:_paperList[indexPath.row]];

	return cell;
}




#pragma mark --列表分割线左侧不留空隙
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if(CurrentSystemVersion > 8.0f) {
        // Prevent the cell from inheriting the Table View's margin settings
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}



