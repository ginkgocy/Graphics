//
//  GraphicsView.m
//  Graphics
//
//  Created by chenyun on 15/7/2.
//  Copyright (c) 2015年 chenyun. All rights reserved.
//

#import "GraphicsView.h"

@implementation GraphicsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}

- (void) drawRooftopAtToPointof:(CGPoint)point textToDisplay:(NSString *)text{
    
}
//画各种小线线
- (void)lineDrawIn:(CGRect )rect{
    [[UIColor redColor] set];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(currentContext);
    
    CGContextSetLineWidth(currentContext, 1);
    CGContextMoveToPoint(currentContext, 20, 20);
    CGContextAddLineToPoint(currentContext, 40, 40);
    CGContextAddLineToPoint(currentContext, 60, 20);
    CGContextAddLineToPoint(currentContext, 80, 40);
    CGContextAddLineToPoint(currentContext, 100, 20);
    CGContextAddLineToPoint(currentContext, 120, 40);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);

    [[UIColor greenColor] set];
    CGContextMoveToPoint(currentContext, 40, 200);
    CGContextAddLineToPoint(currentContext, 200, 230);
    CGContextAddLineToPoint(currentContext, 120, 300);
    CGContextStrokePath(currentContext);
//    CGContextStrokePath(currentContext);
}

// UIImage 绘制
- (void)imageDraw{
    UIImage *image = [UIImage imageNamed:@"hua.png"];
    //[image drawAtPoint:CGPointMake(20, 20)];
    [image drawAsPatternInRect:self.bounds];
}

//使用 NSString 进行绘制文字
-(void)stringDrawFont:(CGRect )rect
{
    UIFont *helFont = [UIFont fontWithName:@"HelveticaNeue" size:40.0f];
    NSDictionary *attributes = @{NSFontAttributeName:helFont,NSForegroundColorAttributeName:[UIColor blueColor]};
    NSString *myString = @"51 NB";
    [myString drawInRect:rect withAttributes:attributes];
   // [myString drawAtPoint:CGPointMake(40, 180) withAttributes:attributes];
//    [myString drawAtPoint:CGPointMake(40, 180) withFont:helFont];
}

// 系统字体枚举
- (void)enumerateFonts
{
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"\n  font family = %@",familyName);
        
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\n font name = %@",fontName);
        }
    }
}

// color小组件
-(void)colorComponents
{
    UIColor *magentaColor = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0];
    [magentaColor set];
    CGColorRef colorRef = [magentaColor CGColor];
    const CGFloat *components = CGColorGetComponents(colorRef);
    NSUInteger componentsCount = CGColorGetNumberOfComponents(colorRef);
    NSUInteger counter = 0;
    for (counter = 0; counter < componentsCount; counter ++) {
        NSLog(@" component %lu = %0.2f",counter +1,components[counter]);
    }
}
@end
