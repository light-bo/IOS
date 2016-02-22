//draw shadow to image
- (UIImage *)addShadowToImage:(UIImage *)image {
    float shadowWidth = 1;
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(imageWidth+shadowWidth, imageHeight+shadowWidth));
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    [[UIColor grayColor] setFill];
    
    UIRectFill(CGRectMake(imageWidth, 0, shadowWidth, imageHeight+shadowWidth));
    UIRectFill(CGRectMake(0, imageHeight, imageWidth+shadowWidth, shadowWidth));
    
    return UIGraphicsGetImageFromCurrentImageContext();
}