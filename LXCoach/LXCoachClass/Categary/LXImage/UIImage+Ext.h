//
//  UIImage+Ext.h
//  WuXianTaiZhou
//
//  Created by mmc on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//kBaseImageUrl

#import <UIKit/UIKit.h>
@interface UIImageView (Ext)

- (void)lx_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

@end
@interface UIImage (Ext)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

- (UIImage *)shrinkImage:(CGSize) size;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
