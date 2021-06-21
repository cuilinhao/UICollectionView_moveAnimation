//
//  TestCollectionViewCell.h
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol TestCollectionViewCellDelegate  <NSObject>

///编辑时，删除item
- (void)setUpPFEvenMoreEditCellWithDeleteApp:(id)itemData;

@end

@interface TestCollectionViewCell : UICollectionViewCell


@property (nonatomic, weak) id <TestCollectionViewCellDelegate> delegate;

- (void)_updateCellData:(id)model;



@end

NS_ASSUME_NONNULL_END
