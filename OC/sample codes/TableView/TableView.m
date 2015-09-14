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



