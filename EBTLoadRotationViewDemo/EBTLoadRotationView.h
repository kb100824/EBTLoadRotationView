//
//  EBTLoadRotationView.h
//  EBaoTongDai
//
//  Created by ebaotong on 15/7/8.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  加载旋转动画
 */
@interface EBTLoadRotationView : UIView
+ (EBTLoadRotationView *)shareInstance;
/**
 *  加载显示旋转动画指示器
 *
 *  @param baseView        显示在view上
 *  @param imageName       图片名称
 *  @param progressValue   进度值
 *  @param progressColor   进度条颜色
 *  @param completeHandler 参数回调
 */
+ (void)showLoadRotationInview:(UIView *)baseView backGroundImageName:(NSString *)imageName progressValue:(CGFloat)progressValue color:(UIColor *)progressColor completeHandler:(void(^)(void))completeHandler;
@end
