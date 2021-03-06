//
//  LXCourseCell.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import "LXCourseListModel.h"
#import "LXUrlApi.h"

@interface LXCourseCell()
/// 头像
@property (nonatomic, strong) UIImageView *headerImageView;
/// 科目几
@property (nonatomic, strong) UILabel *subjectNumber;
/// 内容
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation LXCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 12, 0, 12));
        }];
        [bgView addSubview:self.headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(56);
        }];
        [bgView addSubview:self.subjectNumber];
        [_subjectNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImageView);
            make.left.equalTo(self.headerImageView.mas_right).offset(8);
            make.right.equalTo(bgView);
        }];
        [bgView addSubview:self.contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.subjectNumber);
            make.bottom.equalTo(self.headerImageView);
        }];
    }
    return self;
}

#pragma mark - setter
- (void)setCourseListModel:(LXCourseListModel *)courseListModel {
    _courseListModel = courseListModel;
    
    CGFloat subjectId = [courseListModel.subjectId integerValue];
    UIImage *sImg = [UIImage imageNamed:@"lx_kemu_1"];
    if (subjectId == 2) {
        sImg = [UIImage imageNamed:@"lx_kemu_2"];
    }else if (subjectId == 3){
        sImg = [UIImage imageNamed:@"lx_kemu_3"];
    }else if (subjectId == 4){
        sImg = [UIImage imageNamed:@"lx_kemu_4"];
    }
    _headerImageView.image = sImg;
    
    _subjectNumber.text = courseListModel.subjectName;
    
    _contentLabel.text = [NSString stringWithFormat:@"%@ | %@ | 已约课%@/%@",courseListModel.periodTime,courseListModel.className,courseListModel.appointmentNum,courseListModel.maxNum];
}

#pragma mark - getter
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}
- (UILabel *)subjectNumber {
    if (!_subjectNumber) {
        _subjectNumber = [[UILabel alloc] init];
        _subjectNumber.textAlignment = NSTextAlignmentLeft;
        _subjectNumber.font = [UIFont systemFontOfSize:18];
        _subjectNumber.textColor = TEXT_COLOR_BLACK;
    }
    return _subjectNumber;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = TEXT_COLOR_GRAY;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}
@end
