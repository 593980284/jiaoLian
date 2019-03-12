//
//  UIImage+Ext.m
//  WuXianTaiZhou
//
//  Created by mmc on 12-8-23.url    NSURL *    @"http://111.39.245.156:8087/files/stuimg/20180111_152321198705232418B.jpg"    0x00006000004a0580
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.、
//url    NSURL *    @"http:/111.39.245.156:8087/files/stuimg/20180111_152321198705232418B.jpg"    0x0000600001f85920
#import "LXUrlApi.h"
#import "UIImage+Ext.h"
@implementation UIImageView (Ext)
- (void)lx_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder
{

    NSString * urlStr  = url.absoluteString;

    if ([urlStr hasPrefix:@"http"]) {
        if (![urlStr hasPrefix:@"http://"] && ![urlStr hasPrefix:@"https://"]) {
            urlStr = [urlStr stringByReplacingOccurrencesOfString:@"http:/" withString:@"http://"];
            urlStr = [urlStr stringByReplacingOccurrencesOfString:@"https:/" withString:@"https://"];
        }
    }else{
     urlStr = [NSString stringWithFormat:@"%@/%@",kBaseImageUrl, url.absoluteString];
    }
    
    NSString*hString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:hString] placeholderImage:placeholder options:SDWebImageRetryFailed];
}
@end
@implementation UIImage (Ext)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;      
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }      
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) {
#if DEBUG_REQUEST_STATUS
        DLog(@"could not scale image");
#endif
    }
    
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)shrinkImage:(CGSize) size {
    CGFloat scale=[UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context=CGBitmapContextCreate(NULL, size.width*scale, size.height*scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, size.width*scale, size.height*scale), self.CGImage);
    
    CGImageRef shrunken=CGBitmapContextCreateImage(context);
    UIImage *newImage=[UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
