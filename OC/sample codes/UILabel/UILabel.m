UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 300, 200)];

label.numberOfLines = 0;
label.backgroundColor = [UIColor colorWithRed:235/255.0
                                        green:235/255.0
                                         blue:235/255.0
                                        alpha:1];

NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"1321313123211273127318273819273817381738713712837173812731837128371297319737131719371273187328193721731793\n"];


//设置字体颜色
[text addAttribute:NSForegroundColorAttributeName
             value:[UIColor redColor]
             range:NSMakeRange(0, text.length)];


//设置缩进、行距
NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

style.headIndent = 30;//缩进
style.firstLineHeadIndent = 0;
style.lineSpacing = 10;//行距

[text addAttribute:NSParagraphStyleAttributeName
             value:style
             range:NSMakeRange(0, text.length)];
