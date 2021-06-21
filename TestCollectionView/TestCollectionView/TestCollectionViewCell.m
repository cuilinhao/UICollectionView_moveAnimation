//
//  TestCollectionViewCell.m
//  TestCollectionView
//
//  Created by 崔林豪 imac on 2021/6/9.
//

#import "TestCollectionViewCell.h"
#import "Masonry.h"
#import "TestModel.h"



@interface TestCollectionViewCell()


@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UILabel *lab;

@property (nonatomic, strong) TestModel *mm ;

@end

@implementation TestCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
        self.contentView.backgroundColor = UIColor.lightGrayColor;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"+++++++++12323");
    if ([self.delegate respondsToSelector:@selector(setUpPFEvenMoreEditCellWithDeleteApp:)]) {
        [self.delegate setUpPFEvenMoreEditCellWithDeleteApp:self.mm];
    }
}

- (void)_initUI
{
    UIImageView *img = [[UIImageView alloc] init];
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    img.image = [UIImage imageNamed:@"123"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.userInteractionEnabled = YES;
    self.img = img;
    
    
    UILabel *lab = [[UILabel alloc] init];
    [self.contentView addSubview:lab];
    lab.text = @"REW";
    lab.textColor = UIColor.systemGreenColor;
    lab.font = [UIFont systemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    lab.backgroundColor = UIColor.systemBlueColor;
    self.lab = lab;
}

- (void)_updateCellData:(id)model
{
    TestModel *mm = (TestModel *)model;
    
    self.mm = mm;
    self.img.image = [UIImage imageNamed:@"aaa"];
    
    if (mm.h.intValue <= 250) {
        self.img.image = [UIImage imageNamed:@"bbb"];
    }else if (mm.h.intValue % 3 == 0){
        self.img.image = [UIImage imageNamed:@"ccc"];
    }
   
    
    self.lab.text = mm.price;
    
}


@end
