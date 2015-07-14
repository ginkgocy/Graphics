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

@property (nonatomic, strong) UIImageView *img;
@end

@implementation ViewController
{
    GraphicsView *view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    view = [[GraphicsView alloc]initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width,self.view.bounds.size.height)];
//    view.backgroundColor  = [UIColor clearColor];
    self.view.backgroundColor  = [UIColor lightGrayColor];
//    [self.view addSubview:view];
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.img setImage:[UIImage imageNamed:@"hua"]];
    [self.view addSubview:self.img];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self animationForimg];
}

- (void)animationForimg
{
    [UIView beginAnimations:nil context:(__bridge void *)(self.img)];
    [UIView setAnimationDuration:5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationRepeatCount:10];
    [UIView setAnimationWillStartSelector:@selector(animationWillStartSelector)];
    [UIView setAnimationDidStopSelector:@selector(finishedAnimation)];
    [self.img setFrame:CGRectMake(100, 300, 200, 200)];
    [self.img setAlpha:0.0];
    self.img.transform = CGAffineTransformMakeScale(0.5, 1.0);
    [UIView commitAnimations];
}
- (void)animationWillStartSelector
{
    NSLog(@"start");
}

- (void)finishedAnimation
{
    NSLog(@"finished");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
