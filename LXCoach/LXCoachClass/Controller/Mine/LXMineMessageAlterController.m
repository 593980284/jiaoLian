//
//  LXMineMessageAlterController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineMessageAlterController.h"
#import "LXAlterOrFindStepTwoPasswordController.h"
#import "LXChangeOrFindPasswordController.h"
#import "LXLoginController.h"
#import "LXCommonNavView.h"
#import "LXMineMessageAlterSubView.h"
#import "LXAlterMessageCell.h"
#import "LZActionSheet.h"
#import "UIImage+Ext.h"
#import "LXUploadCoachImageDataController.h"
#import "LXUploadCoachImageSessionTask.h"
#import "LXUserInfoDataController.h"
#import "LXAppCoachLogoutSessionTask.h"
#import "LXMineModel.h"
#import <QQ_XGPush/XGPush.h>
#import "LXNavigationController.h"

static NSString *alterMessage_Identify = @"LXAlterMessageCell";

@interface LXMineMessageAlterController ()<LXCommonNavViewDelegate,LXMineMessageAlterSubViewDelegate,LZActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXMineMessageAlterSubView *subView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LXUploadCoachImageDataController *uploadHeaderImageDataController;
@property (nonatomic, strong) LXUserInfoDataController *infoDataController;
@end

@implementation LXMineMessageAlterController
{
    NSInteger _photoType;
    UIImage *_img;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}

#pragma mark - privateMethod
- (void)openPicOrVideoWithSign:(NSInteger)photoType {
    if (photoType == 0) {
        //本地相簿
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: @"public.image", nil];
        imagePicker.delegate = self;
        [self presentImagepickView:imagePicker];
    }else if(photoType == 1) {
        //相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: @"public.image", nil];
            imagePicker.delegate = self;
            [self presentImagepickView:imagePicker];
        }
    }
}
- (void)presentImagepickView:(UIImagePickerController *)imagePicker {
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

/// 上传头像操作
- (void)uploadHeaderImage:(UIImage *)headerImage {
    NSData *imageData = UIImageJPEGRepresentation(headerImage, 0);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    [self.uploadHeaderImageDataController lxReuqestSaveNewPhoneNumWithCertNo:mineModel.certNo imageCodeString:encodedImageStr completionBlock:^(LXUploadCoachImageResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.picUrl = responseModel.data.picUrl;
            [self.subView uploadTableView];
        }
    }];
}

//相机操作
-  (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    // 这就是我们想要的image 头像
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        _img = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (_photoType == 1)
        {
            UIImageWriteToSavedPhotosAlbum(_img,self, nil, nil);
        }
        //缩减图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = _img;
        CGSize imgSize = [imageView image].size;
        
        if (imgSize.width > 256 )
        {
            _img = [UIImage imageWithImage:_img scaledToSize:CGSizeMake(256, 256)];
        }
        [self uploadHeaderImage:_img];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - LXMineMessageAlterSubViewDelegate
- (NSInteger)lx_alterMessageTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)lx_alterMessageTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LXAlterMessageImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXAlterMessageImageCell"];
        if (cell == nil) {
            cell = [[LXAlterMessageImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXAlterMessageImageCell"];
        }
        cell.imageName = self.picUrl;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LXAlterMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:alterMessage_Identify];
        if (cell == nil) {
            cell = [[LXAlterMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:alterMessage_Identify];
        }
        cell.nameString = self.dataSource[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)lx_alterMessageTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 123;
    }
    return 46;
}
- (void)lx_alterMessageTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            // 修改头像
        {
            LZActionSheet *actionSheet = [[LZActionSheet alloc]initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"相册"]]; //@[@"从相册选择",@"拍照"]
            [actionSheet show];
        }
            break;
        case 1:
            // 密码修改
        {
            LXAlterOrFindStepTwoPasswordController *alterPassword = [[LXAlterOrFindStepTwoPasswordController alloc] init];
            alterPassword.type = 2;
            alterPassword.navTitleString = @"修改密码";
            [self.navigationController pushViewController:alterPassword animated:YES];
        }
            break;
        case 2:
            // 更换绑定手机号
        {
            LXChangeOrFindPasswordController *changeLoginNumber = [[LXChangeOrFindPasswordController alloc] init];
            changeLoginNumber.type = 2;            
            [self.navigationController pushViewController:changeLoginNumber animated:YES];
        }
            break;
        
    }
}
/// 退出登录
- (void)lx_outLogin {
    [self.infoDataController lxRequestAppCoachLogoutCompletionBlock:^(LXAppCoachLogoutResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
            // 取消推送绑定
            [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:mineModel.certNo type:XGPushTokenBindTypeAccount];
            // 移除个人信息
            [LXCacheManager removeStoreObjectForKey:@"LXMineModel"];
            // 用户未登录
            LXLoginController *loginVC = [[LXLoginController alloc]init];
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            LXNavigationController *navc = [[LXNavigationController alloc] initWithRootViewController:loginVC];
            window.rootViewController = navc;
        }
    }];
}
#pragma mark   - <LZActionSheetDelegate>
- (void)LZActionSheet:(LZActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index{
    if(index == 0){
        //相机
        _photoType = 1;
        [self openPicOrVideoWithSign:_photoType];
    }
    if (index == 1) {
        //相册
        _photoType = 0;
        [self openPicOrVideoWithSign:_photoType];
    }
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter
- (void)setPicUrl:(NSString *)picUrl {
    _picUrl = picUrl;
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"个人设置"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXMineMessageAlterSubView *)subView {
    if (!_subView) {
        _subView = [[LXMineMessageAlterSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.alterMessageDelegate = self;
    }
    return _subView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@"",@"密码修改",@"更换绑定手机号"]];
    }
    return _dataSource;
}
- (LXUploadCoachImageDataController *)uploadHeaderImageDataController {
    if (!_uploadHeaderImageDataController) {
        _uploadHeaderImageDataController = [[LXUploadCoachImageDataController alloc] init];
    }
    return _uploadHeaderImageDataController;
}
- (LXUserInfoDataController *)infoDataController {
    if (!_infoDataController) {
        _infoDataController = [[LXUserInfoDataController alloc] init];
    }
    return _infoDataController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
