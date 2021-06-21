//
//  TestLifeCollectionViewCell.h
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/10.
//

#import <UIKit/UIKit.h>
#import "TestCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN


typedef void (^addItemBlock)(id model) ;

//@protocol TestLifeCollectionViewCellDelegate <NSObject>
//
//- (void)changelifeCell:(id)itemData;
//
//@end

@interface TestLifeCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<TestCollectionViewCellDelegate>  cellDelagte;

@property (nonatomic, copy) addItemBlock addBlock;

@end

NS_ASSUME_NONNULL_END
