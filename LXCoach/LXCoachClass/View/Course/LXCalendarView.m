//
//  LXCalendarView.m
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCalendarView.h"
#import "LXCalendarCourseCell.h"
#import "LXCourseFindDateListModel.h"
@interface LXCalendarView ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 当前选中的日期： 年-月
 */
@property (nonatomic, strong) UILabel *currentOptionDate;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LXCalendarView
{
    NSInteger selectedIndex;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataArr = [[NSMutableArray alloc] init];
        [self addSubview:self.currentOptionDate];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 18;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = 46;
    self.currentOptionDate.frame = CGRectMake(x, y, w, h);
    
    x = 0 ;
    y = CGRectGetMaxY(self.currentOptionDate.frame);
    w = self.width;
    h = self.height - 46;
    self.collectionView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCalendarCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    LXCourseFindDateListModel *model = self.dataArr[indexPath.row];
    [cell congfigCourseFindDateListModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width/7, self.collectionView.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedIndex != indexPath.row) {
        //选择不一样
        //改变旧值
        LXCourseFindDateListModel *selectModel = self.dataArr[selectedIndex];
        selectModel.firstIsOption = 0;
        //改变新值
        LXCourseFindDateListModel *selectModel1 = self.dataArr[indexPath.row];
        selectModel1.firstIsOption = 1;
        self.currentOptionDate.text = selectModel1.yearAndMonth;
        selectedIndex = indexPath.row;
        [self.collectionView reloadData];
    }
    self.collectionCellDidSelectBlock(indexPath.row);
}

#pragma mark - setter
- (void)setDataArr:(NSMutableArray<LXCourseFindDateListModel *> *)dataArr {
    _dataArr = dataArr;
    selectedIndex = 0;
    [self.collectionView reloadData];
    LXCourseFindDateListModel *model = [self.dataArr firstObject];
    self.currentOptionDate.text = model.yearAndMonth;
}

#pragma mark - getter
- (UILabel *)currentOptionDate {
    if (!_currentOptionDate) {
        _currentOptionDate = [[UILabel alloc] init];
        _currentOptionDate.font = [UIFont systemFontOfSize:16];
        _currentOptionDate.textColor = [UIColor colorWithHexString:@"#333333"];
        _currentOptionDate.textAlignment = NSTextAlignmentLeft;
    }
    return _currentOptionDate;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LXCalendarCourseCell class] forCellWithReuseIdentifier:@"cellID"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
