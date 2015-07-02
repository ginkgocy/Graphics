//
//  ViewController.m
//  Graphics
//
//  Created by chenyun on 15/7/2.
//  Copyright (c) 2015年 chenyun. All rights reserved.
//

#import "ViewController.h"
#import "GraphicsView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    GraphicsView *view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    view = [[GraphicsView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor  = [UIColor clearColor];
//    [view setNeedsDisplay];
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
