#pragma mark --选择图片（一般用于选择用户头像）

//初始化
===============================================================================

UIImagePickerController *picker = [[UIImagePickerController alloc] init];
picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

picker.delegate = self;

//设置选择后的图片可被编辑
picker.allowsEditing = YES;

[self.navigationController presentViewController:picker animated:YES completion:nil];

================================================================================



//delegate 处理
================================================================================

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //获取到编辑后的照片
        UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        //修改编辑后的图片的大小
        editedImage = [UIImage scaleToSize:editedImage size:(CGSize){160, 160}];
        
        
        //设置照片
        [self.avatarImageView setImage:editedImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    HBLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

================================================================================