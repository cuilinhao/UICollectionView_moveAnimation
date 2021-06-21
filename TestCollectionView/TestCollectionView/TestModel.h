//
//  TestModel.h
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSNumber * h;//高度

@property (nonatomic, strong) NSNumber * w;//宽度

@property (nonatomic, strong) NSString * img;//图片url

@property (nonatomic, strong) NSString * price;//价格



@end

NS_ASSUME_NONNULL_END
