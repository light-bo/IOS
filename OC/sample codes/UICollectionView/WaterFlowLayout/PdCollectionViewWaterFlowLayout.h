//
//  PdCollectionViewWaterFlowLayout.h
//  Loopin
//
//  Created by light_bo on 2017/6/16.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PdCollectionViewWaterFlowLayout;


@protocol PdCollectionViewWaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(PdCollectionViewWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end



@interface PdCollectionViewWaterFlowLayout : UICollectionViewFlowLayout


/**
 瀑布流总列数
 */
@property (nonatomic, assign) NSInteger columnsCount;


/**
 每一列的间距
 */
@property (nonatomic, assign) float columnMargin;



/**
 每一行的间距
 */
@property (nonatomic, assign) float rowMargin;


@property (nonatomic, weak) id<PdCollectionViewWaterFlowLayoutDelegate> delegate;

@end
