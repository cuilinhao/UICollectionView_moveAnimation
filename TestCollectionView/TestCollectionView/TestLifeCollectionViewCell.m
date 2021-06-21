//
//  TestLifeCollectionViewCell.m
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/10.
//

#import "TestLifeCollectionViewCell.h"

#import "TestModel.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "TestCollectionViewCell.h"


@interface TestLifeCollectionViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation TestLifeCollectionViewCell


#pragma mark - lazy Load

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5.0;
        flowLayout.minimumInteritemSpacing = 10.0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(20, 30);
        
        //CGFloat width = [UIScreen mainScreen].bounds.size.width;
        //CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        //codeTest
        _collectionView.backgroundColor = UIColor.systemGreenColor;
        
    }
    
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
        [self _loadData];
        
    }
    return self;
}

- (void)_initUI
{
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (void)_loadData
{
    self.dataArray = [[NSMutableArray alloc] initWithArray:[self getDataArray]];
    [self.collectionView reloadData];
}

- (NSArray *)getDataArray
{
    return [TestModel mj_objectArrayWithFilename:@"test.plist"];
}


#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[TestCollectionViewCell alloc] init];
       
    }
    cell.delegate = self.cellDelagte;
    [cell _updateCellData:[self.dataArray objectAtIndex:indexPath.row]];
    
    
    //长按手势
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick:)];
    [cell addGestureRecognizer:tap];
    
    //cell.contentView.backgroundColor = [UIColor systemRedColor];
    if (indexPath.row % 2 == 0) {
      //  cell.contentView.backgroundColor = UIColor.systemBlueColor;
    }
    
    
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//MARK:==
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"————移动之后会调用---");
    
    NSMutableArray *tempArr = [self.dataArray mutableCopy];
    //目标item 减去 拖拽的item
    // 2 -  0
    NSInteger activeRange = destinationIndexPath.item - sourceIndexPath.item;
    
    BOOL moveForward = activeRange > 0 ;
    NSInteger  originIndex = 0;
    NSInteger targetIndex = 0;
    
    for (NSInteger i = 1; i <= labs(activeRange); i++) {
        //删除的item、 是在前面 还是在后面
        NSInteger moveDirection = moveForward ? 1 : -1;
        //移动的item
        //  0 + 1
        originIndex = sourceIndexPath.item + i * moveDirection;
        //目标item
        // 1  - 1
        targetIndex = originIndex - 1 *moveDirection;
        
        NSLog(@"_______iiiii_____%ld______%ld", (long)originIndex, (long)targetIndex);
        [tempArr exchangeObjectAtIndex:originIndex withObjectAtIndex:targetIndex];
    }
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[tempArr mutableCopy]];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 50+10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}


#pragma mark - >>>>

- (void)tapclick:(UILongPressGestureRecognizer *)gr
{
    
    CGPoint point = [gr locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    switch (gr.state) {
        case UIGestureRecognizerStateBegan:
        {//开始移动
            if (!indexPath) {
                break;
            }
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {//移动中 更新坐标位置
            //Interactive 互动
            [_collectionView updateInteractiveMovementTargetPosition:point];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {//结束移动
            [_collectionView endInteractiveMovement];
        }
            break;
        default:
        {
            //取消移动
            [_collectionView cancelInteractiveMovement];
        }
            break;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"12323");
    TestModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
//    if ([self.delagte respondsToSelector:@selector(changelifeCell:)]) {
//        [self.delagte changelifeCell:model];
//    }
    if (self.addBlock) {
        self.addBlock(model);
    }
    
}


@end
