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
    LXCalendarCourseCell *tendCell;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.currentOptionDate];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 15;
    CGFloat w = self.width;
    CGFloat h = 15;
    self.currentOptionDate.frame = CGRectMake(x, y, w, h);
    
    x = 0 ;
    y = CGRectGetMaxY(self.currentOptionDate.frame);
    w = self.width;
    h = 120 - (15+15);
    self.collectionView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCalendarCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    LXCourseFindDateListModel *model = self.dataArr[indexPath.row];
    [cell congfigCourseFindDateListModel:model];
    if (model.firstIsOption == 1) {
        cell.dateLabel.backgroundColor = [UIColor colorWithHexString:@"#309CF5"];
        cell.dateLabel.textColor = [UIColor whiteColor];
        model.firstIsOption = 0;
        tendCell = cell;
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width/7, self.height);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (tendCell != nil) {
        tendCell.dateLabel.backgroundColor = [UIColor clearColor];
        tendCell.dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        tendCell = nil;
    }
    LXCalendarCourseCell * cell = (LXCalendarCourseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.dateLabel.backgroundColor = [UIColor colorWithHexString:@"#309CF5"];
    cell.dateLabel.textColor = [UIColor whiteColor];
    self.collectionCellDidSelectBlock(indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXCalendarCourseCell * cell = (LXCalendarCourseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.dateLabel.backgroundColor = [UIColor clearColor];
    cell.dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
}

#pragma mark - setter
- (void)setDataArr:(NSMutableArray<LXCourseFindDateListModel *> *)dataArr {
    _dataArr = dataArr;
    [self.collectionView reloadData];
    LXCourseFindDateListModel *model = [self.dataArr firstObject];
    self.currentOptionDate.text = model.yearAndMonth;
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
}

#pragma mark - getter
- (UILabel *)currentOptionDate {
    if (!_currentOptionDate) {
        _currentOptionDate = [[UILabel alloc] init];
        _currentOptionDate.font = [UIFont systemFontOfSize:16];
        _currentOptionDate.textColor = [UIColor colorWithHexString:@"#333333"];
        _currentOptionDate.textAlignment = NSTextAlignmentCenter;
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
        [_collectionView setContentOffset:CGPointMake(self.width/7 * self.dataArr.count, 0)];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LXCalendarCourseCell class] forCellWithReuseIdentifier:@"cellID"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
