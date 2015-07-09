//
//  EBTLoadRotationView.m
//  EBaoTongDai
//
//  Created by ebaotong on 15/7/8.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import "EBTLoadRotationView.h"
#define kContentViewSize  CGSizeMake(25,25) //viewContent的宽高
#define kImageViewSize    CGSizeMake(12.5f,12.5f) //图片的大小
@interface EBTLoadRotationView ()
{
    CAShapeLayer *layerCircle;
    UIBezierPath *pathCircle;
    UIView *viewContent;
    CABasicAnimation *animationRotation;
    UIView *imageView;
}
@end


@implementation EBTLoadRotationView
+ (EBTLoadRotationView *)shareInstance
{
    static EBTLoadRotationView *myInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        myInstance = [[EBTLoadRotationView alloc]init];
    });
    return myInstance;

}
- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}
- (void)showLoadRotationInview:(UIView *)baseView backGroundImageName:(NSString *)imageName progressValue:(CGFloat)progressValue color:(UIColor *)progressColor completeHandler:(void(^)(void))completeHandler
{
    if(progressValue<0.f)
    {
        progressValue = 0.f;
    }
    else if (progressValue>=1.0f)
    {
        progressValue = 0.9f;
    }
    NSAssert(imageName.length!=0, @"图片名称不能为空");
    
    /**viewContent添加约束*/
    viewContent = [[UIView alloc]init];
    viewContent.backgroundColor = [UIColor clearColor];
    viewContent.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:viewContent];
   
    NSDictionary *dic_Constraint = @{
                                      @"width":@(kContentViewSize.width),
                                      @"height":@(kContentViewSize.height)
                                     };
    
    NSArray *viewContent_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[viewContent(width)]" options:0 metrics:dic_Constraint views:NSDictionaryOfVariableBindings(viewContent)];
     NSArray *viewContent_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewContent(height)]" options:0 metrics:dic_Constraint views:NSDictionaryOfVariableBindings(viewContent)];
    NSLayoutConstraint *viewContent_CenterX = [NSLayoutConstraint constraintWithItem:viewContent attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
     NSLayoutConstraint *viewContent_CenterY = [NSLayoutConstraint constraintWithItem:viewContent attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[viewContent_CenterX,viewContent_CenterY]];
    [self addConstraints:viewContent_H];
    [self addConstraints:viewContent_V];
    
    /**背景图view*/
    imageView = [[UIView alloc]init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.layer.contents = (__bridge id)[UIImage imageNamed:imageName].CGImage;
    imageView.layer.contentsScale = [UIScreen mainScreen].scale;
    [self addSubview:imageView];
    NSDictionary *dicImage_Constraint = @{
                                     @"width":@(kImageViewSize.width),
                                     @"height":@(kImageViewSize.height)
                                     };
    
    NSArray *imageView_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(width)]" options:0 metrics:dicImage_Constraint views:NSDictionaryOfVariableBindings(imageView)];
    NSArray *imageView_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(height)]" options:0 metrics:dicImage_Constraint views:NSDictionaryOfVariableBindings(imageView)];
    NSLayoutConstraint *imageView_CenterX = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *imageView_CenterY = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[imageView_CenterX,imageView_CenterY]];
    [self addConstraints:imageView_H];
    [self addConstraints:imageView_V];

    
    /**画圆形进度条*/
    layerCircle = [CAShapeLayer layer];
    layerCircle.lineWidth = 1.f;
    layerCircle.strokeColor = progressColor.CGColor;
    layerCircle.fillColor = [UIColor clearColor].CGColor;
    pathCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,kContentViewSize.width, kContentViewSize.height)];
    layerCircle.strokeStart = 0;
    layerCircle.strokeEnd = progressValue;
    layerCircle.path = pathCircle.CGPath;
    [viewContent.layer addSublayer:layerCircle];
    
    
    animationRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animationRotation.toValue = @(M_PI * 2);
    animationRotation.repeatCount = MAXFLOAT;
    animationRotation.duration = 0.5f;
    animationRotation.fillMode = kCAFillModeForwards;
    [viewContent.layer addAnimation:animationRotation forKey:@"RotationAnimation"];
    
    /**self添加约束*/
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:self];
    NSArray *self_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    
    NSArray *self_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];

    [baseView addConstraints:self_H];
    [baseView addConstraints:self_V];
    if (completeHandler) {
        completeHandler();
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1.f animations:^{
            
            [viewContent.layer removeAnimationForKey:@"RotationAnimation"];
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
        
        
    });

    
}

+ (void)showLoadRotationInview:(UIView *)baseView backGroundImageName:(NSString *)imageName progressValue:(CGFloat)progressValue color:(UIColor *)progressColor completeHandler:(void(^)(void))completeHandler
{
    [[EBTLoadRotationView shareInstance] showLoadRotationInview:baseView backGroundImageName:imageName progressValue:progressValue color:progressColor completeHandler:completeHandler];

}
@end
