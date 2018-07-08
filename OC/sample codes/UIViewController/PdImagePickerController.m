//
//  PdImagePickerController.m
//  Loopin
//
//  Created by light_bo on 2017/7/18.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdImagePickerController.h"

@interface PdImagePickerController ()

@property (nonatomic, assign) PdImagePickerControllerType imagePickerControllerType;

@end


@implementation PdImagePickerController


- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<PdImagePickerControllerDelegate>)delegate pickerType:(PdImagePickerControllerType)pickerType {
    self = [super initWithMaxImagesCount:maxImagesCount delegate:delegate];
    if (self) {
        _imagePickerControllerType = pickerType;
        
        [self configImagePickerController];
    }
    
    return self;
}

- (void)configImagePickerController {
    self.naviBgColor = [UIColor whiteColor];
    self.naviTitleColor = Pd_Subtitle_Color;
    self.naviTitleFont = [UIFont semiBoldSystemFontOfSize:17];
    self.barItemTextColor = Pd_Subtitle_Color     ;
    self.isStatusBarDefault = YES;
    
    switch (_imagePickerControllerType) {
        case PdImagePickerControllerTypeConfigShowcase: {
            self.allowCrop =  YES;
            self.autoDismiss = NO;
            self.processHintStr = LANGUAGE(@"ico_photo_loading");
            
            float cropRectY = (0.11 * Pd_Screen_Height) <= Pd_Top_Bar_Height? Pd_Top_Bar_Height + 10: 0.11 * Pd_Screen_Height;
            float cropRectHeight = Pd_Screen_Height - 2 * cropRectY;
            float cropRectWidth = cropRectHeight * 9 / 16;
            float cropRectX = (Pd_Screen_width - cropRectWidth) / 2;
            
            self.cropRect = CGRectMake(cropRectX, cropRectY, cropRectWidth, cropRectHeight);
            self.photoWidth = 720;
        }
            break;
            
        case PdImagePickerControllerTypeUploadAvatar: {
            self.allowPickingVideo = NO;
            self.allowCrop = YES;
        }
            break;
        case PdImagePickerControllerTypeUploadOrigin: {
            self.cropRect = CGRectMake(0, 0, Pd_Screen_width, Pd_Screen_Height);
        }
            
            break;
            
        default:
            break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置返回图标的颜色
    self.navigationBar.tintColor = Pd_Grey_Back_Image_Color;
}


#pragma mark - memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
