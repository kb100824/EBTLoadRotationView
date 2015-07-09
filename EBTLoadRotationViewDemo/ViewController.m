//
//  ViewController.m
//  EBTLoadRotationViewDemo
//
//  Created by MJ on 15/7/9.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "ViewController.h"
#import "EBTLoadRotationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [EBTLoadRotationView showLoadRotationInview:self.view backGroundImageName:@"1" progressValue:0.5 color:[UIColor redColor] completeHandler:^{
        
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
