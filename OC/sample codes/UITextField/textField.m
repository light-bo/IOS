#pragma mark --textfield 被软键盘遮住问题(方案一)
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 120 - (self.view.frame.size.height - 216.0);//键盘高度 216，textfield 高度 120
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以便下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f,
                                     -offset,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        
    [UIView commitAnimations];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    //恢复视图
    self.view.frame =CGRectMake(0,
                                0,
                                self.view.frame.size.width,
                                self.view.frame.size.height);
}


//软键盘 return 键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark --textfield 被软键盘遮住问题(方案二:监听键盘事件，获取键盘高度进行调整)
//监听键盘事件
[[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(keyboardWillShow:) 
                                             name:UIKeyboardWillShowNotification 
                                           object:nil];

[[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(keyboardWillHide:) 
                                             name:UIKeyboardWillHideNotification
                                           object:nil];

//ios 5.0 以后
[[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(keyboardWillShow:) 
                                             name:UIKeyboardWillChangeFrameNotification 
                                           object:nil];


//获取键盘高度
- (void)keyboardWillShow:(NSNotification *)notification {
    /*
    Reduce the size of the text view so that it's not obscured by the keyboard.
    Animate the resize so that it's in sync with the appearance of the keyboard.
    */

    NSDictionary *userInfo = [notification userInfo];

    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];

    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}

//恢复界面
- (void)keyboardWillHide:(NSNotification *)notification {

    NSDictionary* userInfo = [notification userInfo];

    /*
    Restore the size of the text view (fill self's view).
    Animate the resize so that it's in sync with the disappearance of the keyboard.
    */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
}





