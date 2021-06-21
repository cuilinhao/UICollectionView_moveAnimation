//
//  ViewController.m
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/8.
//

#import "ViewController.h"
#import "Masonry.h"

#import "TestModel.h"
#import "MJExtension.h"
#import "TestCollectionViewCell.h"
#import "TestMainCollectionViewCell.h"
#import "TestLifeCollectionViewCell.h"



@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewCell *dragIV ;

@property (nonatomic, strong) TestMainCollectionViewCell *mainCell;

@end

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


@implementation ViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)cellArray
{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
       
    [self _initUI];

    [self _loadData];
    
}

- (void)_initUI
{
 
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //上下间距
    flowLayout.minimumLineSpacing = 10.0;
    flowLayout.minimumInteritemSpacing = 5.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(width, 200);
   

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, width, height - 50) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //collectionView.collectionViewLayout = flowLayout;
    
    self.collectionView = collectionView;
    
    
    [collectionView registerClass:[TestMainCollectionViewCell class] forCellWithReuseIdentifier:@"cell_main"];
    [collectionView registerClass:[TestLifeCollectionViewCell class] forCellWithReuseIdentifier:@"cell_life"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    //codeTest
    collectionView.backgroundColor = UIColor.systemGreenColor;
    
}

- (void)_loadData
{
    self.dataArray = [[NSMutableArray alloc] initWithArray:[self getDataArray]];
    [self.collectionView reloadData];
}

- (NSArray *)getDataArray
{
    return [TestModel mj_objectArrayWithFilename:@"test2.plist"];
}

- (NSArray *)get_main_DataArray
{
    return [TestModel mj_objectArrayWithFilename:@"test3.plist"];
}

- (NSArray *)get_life_DataArray
{
    return [TestModel mj_objectArrayWithFilename:@"test4.plist"];
}



#pragma mark - TestCellDelegate

///编辑时，删除item
- (void)setUpPFEvenMoreEditCellWithDeleteApp:(id)itemData
{
    TestModel *model = (TestModel *)itemData;
    //[self.dataArray addObject:model];
    //[self.collectionView reloadData];
    
    [self.mainCell.dataArray addObject:model];
    [self.mainCell.collectionView reloadData];
}


#pragma mark - Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return self.dataArray.count;
//    }
//    NSArray *arr = [self get_life_DataArray];
//    return arr.count;
    
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        TestMainCollectionViewCell *mainCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_main" forIndexPath:indexPath];
        self.mainCell = mainCell;
        
        
        return mainCell;
    }else {
        TestLifeCollectionViewCell *lifeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_life" forIndexPath:indexPath];
//        //lifeCell.delagte = self.mainCell;
//        lifeCell.addBlock = ^(id  _Nonnull model) {
//            TestModel *mm = (TestModel *)model;
//            [self.mainCell.dataArray addObject:mm];
//            [self.mainCell.collectionView reloadData];
//        };
        
        lifeCell.cellDelagte = self;
        
        return lifeCell;
    }
    
    return nil;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(width, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}


#pragma mark didselect

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"12323");
}


#pragma mark -header & flooter View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = UIColor.systemPinkColor;
        return headerView;
    }else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.backgroundColor = UIColor.systemPurpleColor;
        return footerView;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(width, 40);
    }
    return CGSizeMake(width, 0.1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(width, 40);
}

@end
