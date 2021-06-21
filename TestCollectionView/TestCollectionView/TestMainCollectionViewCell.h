//
//  TestMainCollectionViewCell.h
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/10.
//

#import <UIKit/UIKit.h>
#import "TestCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol TestMainCollectionViewCellDelegate <NSObject>
//
//- (void)changeItem:(id)itemData;
//
//@end

@interface TestMainCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

//@property (nonatomic, weak) id<TestMainCollectionViewCellDelegate>  delagte;
@property (nonatomic, weak) id<TestCollectionViewCellDelegate>  cellDelagte;



@end

NS_ASSUME_NONNULL_END
