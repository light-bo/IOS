/*
 *
 * 自定义属性动画 label
 *
 *
 */

//...
@property (nonatomic, strong) POPBasicAnimation *anim;
//...

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.anim = [POPBasicAnimation animation];
    self.anim.duration = 1.5;//动画持续时间
    self.anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//动画时间函数
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.readBlock = ^(id obj,CGFloat values[]){
            UILabel *label = (UILabel *)obj;
            values[0] = [label.text floatValue];
        };
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            //[obj setText:[NSString stringWithFormat:@"%.0f", values[0]]];
            UILabel *label = (UILabel *)obj;
            label.text = [NSString stringWithFormat:@"%.0f", values[0]];
        };
        
        prop.threshold = 0;
    }];
    
    self.anim.property = prop;//自定义属性
    self.anim.fromValue = @(0.0);
}

//...
self.anim.toValue = @([_textField.text floatValue]);
[self.label pop_addAnimation:_anim
                      forKey:@"labelAnimation"];