//
//  PdImagePickerController.h
//  Loopin
//
//  Created by light_bo on 2017/7/18.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <TZImagePickerController/TZImagePickerController.h>


typedef NS_ENUM(NSInteger, PdImagePickerControllerType) {
    PdImagePickerControllerTypeConfigShowcase, //老版本 设置 showcase
    PdImagePickerControllerTypeUploadAvatar,
    PdImagePickerControllerTypeUploadOrigin//不裁剪
};



@protocol PdImagePickerControllerDelegate <TZImagePickerControllerDelegate>
@end


@interface PdImagePickerController : TZImagePickerController

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<PdImagePickerControllerDelegate>)delegate pickerType:(PdImagePickerControllerType)pickerType;

@end
