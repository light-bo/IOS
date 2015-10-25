//将时间戳转化为可读字符串
+ (NSString *)formatCreateTime:(NSString *)timestamp {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy MM dd HH:mm:ss"];//设置时间显示格式
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"CN"]];//设置时区

    NSDate *dates = [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]/1000];
    
    NSTimeInterval late = [dates timeIntervalSince1970];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];

    NSString *timeString = @"";
    
    NSTimeInterval timeInterval = now - late;
    
    if (timeInterval/3600 < 1) {
        //一个小时内
        timeString = [NSString stringWithFormat:@"%f", timeInterval/60];

        NSInteger min = [timeString integerValue];
        if(min <= 0) {
            timeString = @"刚刚";
        } else {
            timeString = [NSString stringWithFormat:@"%d分钟前", min];
        }
    } else if (timeInterval/3600>1 && timeInterval/86400<1) {
        //超过一小时（24 小时内）
        NSTimeInterval cha = now - late;
        int hours = ((int)cha) % (3600 * 24) / 3600;
        timeString = [NSString stringWithFormat:@"%d小时前",hours];
    } else if (timeInterval/86400>1) {
        //超过 24 小时
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YY-MM-dd"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:dates]];
    }
    
    return timeString;
}