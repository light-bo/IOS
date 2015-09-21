//去除字符串首尾的空格和回车符
NSString *string = @"";
NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
