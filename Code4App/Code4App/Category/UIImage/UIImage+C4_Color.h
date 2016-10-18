//
//  UIImage+C4_Color.h
//  Code4App
//
//  Created by Kengsir on 2016/10/16.
//  Copyright © 2016年 com.imessage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (C4_Color)

/**
 *  用color生成image
 *
 *  @param color 颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  改变image透明度
 *
 *  @param alpha 透明度
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

@end
