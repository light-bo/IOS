//
//  PdCollectionViewWaterFlowLayout.m
//  Loopin
//
//  Created by light_bo on 2017/6/16.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdCollectionViewWaterFlowLayout.h"

@interface PdCollectionViewWaterFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *maxYDict;
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end



@implementation PdCollectionViewWaterFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _maxYDict = [NSMutableDictionary new];
        _attrsArray = [NSMutableArray new];
    }
    
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


// contentsize 的高度为最长的那一列的高度
- (CGSize)collectionViewContentSize {
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

//每次布局之前的准备
- (void)prepareLayout {
    [super prepareLayout];
    
    //清空最大的Y值
    for (int i = 0; i < self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    //计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect )rect {
    return self.attrsArray;
}

//Item 的布局属性, 往当前比较短的那一列放置 cell
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //假设最短的那一列为第0列
    __block NSString *minColumn = @"0";
    //找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    //计算尺寸
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin)/self.columnsCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];;
    
    //计算位置
    CGFloat x = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    
    //更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    //创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}

@end
