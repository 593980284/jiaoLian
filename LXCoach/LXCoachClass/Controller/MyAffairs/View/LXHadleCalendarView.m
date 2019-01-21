//
//  LXHadleCalendarView.m
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXHadleCalendarView.h"
#import "LXHandleCalendarItemCell.h"
@interface LXHadleCalendarView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LXHadleCalendarView{
    NSInteger selectedIndex;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXHandleCalendarItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXHandleCalendarItemCell" forIndexPath:indexPath];
    LXAffairsDateModel *model = self.dataArr[indexPath.row];
    [cell congfigCourseFindDateListModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.width/7, self.collectionView.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (selectedIndex != indexPath.row) {
//        //选择不一样
//        //改变旧值
//        LXCourseFindDateListModel *selectModel = self.dataArr[selectedIndex];
//        selectModel.firstIsOption = 0;
//        //改变新值
//        LXCourseFindDateListModel *selectModel1 = self.dataArr[indexPath.row];
//        selectModel1.firstIsOption = 1;
//        self.currentOptionDate.text = selectModel1.yearAndMonth;
//        selectedIndex = indexPath.row;
//        [self.collectionView reloadData];
//    }
//    self.collectionCellDidSelectBlock(indexPath.row);
}

#pragma mark - setter
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LXHandleCalendarItemCell class] forCellWithReuseIdentifier:@"LXHandleCalendarItemCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
