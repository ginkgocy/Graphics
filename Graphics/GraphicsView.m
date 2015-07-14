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
    
    [self transformOfCRM];
}

#pragma mark 图形的变换


#pragma mark 平移图形上下文中的形状

//坐标平移 最后的坐标会是 ：x = x1 + x2; y = y1 + y2;
- (void)transformOftranslation
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);

    CGMutablePathRef path = CGPathCreateMutable();
    
    //旋转
    CGAffineTransform translation = CGAffineTransformMakeRotation((45 * M_PI)/180);
    
    //缩放
//    CGAffineTransform translation = CGAffineTransformMakeScale(0.5, 0.5f);
    
    //位置平移
//    CGAffineTransform translation = CGAffineTransformMakeTranslation(100, 200);
    CGRect rec = CGRectMake(10, 20, 120, 100);
    [[UIColor orangeColor] setFill];
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(currentContext, 3.0);
    CGPathAddRect(path, &translation, rec);
    CGContextAddPath(currentContext, path);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
    CGContextRestoreGState(currentContext);
}

//对上下文进行矩阵平移变换
- (void)transformOfCRM
{
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currnetContext);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(10, 20, 120, 100));
    CGContextTranslateCTM(currnetContext, 100, 200);
    [[UIColor orangeColor] setFill];
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(currnetContext, 3.0);
    CGContextAddPath(currnetContext, path);
    CGContextDrawPath(currnetContext, kCGPathFillStroke);
    CGPathRelease(path);
    CGContextRestoreGState(currnetContext);
}

#pragma mark 创建和绘制渐变
//CGGradientCreateWithColorComponents
//渐变需要4个参数
//色彩空间
//颜色分量
//位置数组,颜色数组中各个颜色的位置
//位置的数量

- (void)drawGradient
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    //颜色空间(色彩模式)
    
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceRGB();
    
    //颜色分量
    UIColor *startColor = [UIColor blueColor];
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents([startColor CGColor]);
    
    UIColor *endColor = [UIColor greenColor];
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    //每种颜色都包含 rgba 四种颜色分量。起点和终点共 2 * 4  = 8；
    //使用平面数组包装传入 CGGradientRef 句柄中
    CGFloat colorComponents[8] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3],
        
    };
    
    //颜色分量的位置 起点 0， 终点1
    CGFloat colorIndices [2] = {0.0f,1.0f};
    
    //获取渐变句柄
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSapce, (const CGFloat *)&colorComponents, (const CGFloat*)&colorIndices, 2);
    
    //释放电使用 create  copy 等创建的对象，他们需要手动释放
    CGColorSpaceRelease(colorSapce);
    
    //渐变区域
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    /*
     //渐变的起点、终点
     CGPoint startPoint ,endPoint;
     startPoint = CGPointMake(0.0f, screenBounds.size.height / 2);
     endPoint = CGPointMake(screenBounds.size.width, startPoint.y);
     */
    //起点与终点的作用：起点与终点连接形成成线段ab，过ab 做垂直平分线cd，渐变的区域就是以 cd 为对称轴，ab 为宽度的渐变
    
    
    
    CGPoint startPoint ,endPoint;
    startPoint = CGPointMake(100, 200);
    endPoint = CGPointMake(300, 100);
    
    
    //绘制渐变，最后一个参数，0 表示不进行渐变面积外的填充，kCGGradientDrawsBeforeStartLocation 表示进行 起点 一侧 进行 填充起点颜色
//    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint,0);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    CGGradientRelease(gradient);
    
}

#pragma mark 矩形的绘制

//单个矩形
- (void)drawRectange
{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    [[UIColor redColor]setFill];
    CGPathAddRect(pathRef, NULL, CGRectMake(10, 10, 120, 100));
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currentContext, pathRef);
    CGContextDrawPath(currentContext, kCGPathFill);
    CGContextFillPath(currentContext);
    CGPathRelease(pathRef);
    
}

// 多个（一组）矩形
- (void)drawRectanges
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect1 = CGRectMake(10, 64, 100, 40);
    CGRect rect2 = CGRectMake(10, 164, 100, 40);
    CGRect rect3 = CGRectMake(10, 264, 100, 40);
    CGRect rect4 = CGRectMake(10, 364, 100, 40);
    CGRect rect5 = CGRectMake(10, 464, 100, 40);
    CGRect rect[5] = {rect1,rect2,rect3,rect4,rect5};
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [[UIColor blueColor] setFill];
    CGPathAddRects(path, NULL,(const CGRect*)&rect, 5); // NULL 参数是一个变幻参数
    CGContextAddPath(currentContext, path);
    CGContextDrawPath(currentContext, kCGPathFill);
    CGPathRelease(path);
}

//带阴影的矩形
- (void)drawRectangeWithShadow
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext); // 进行绘制前，先保存状态
    CGContextSetShadowWithColor(currentContext, CGSizeMake(20, 20), 20, [[UIColor grayColor]CGColor]);
    CGRect rect1 = CGRectMake(55, 60, 150, 150);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect1);
    CGContextAddPath(currentContext, path);
    [[UIColor redColor]setFill];
    CGContextDrawPath(currentContext, kCGPathFill);
    CGPathRelease(path);
    CGContextRestoreGState(currentContext); // 绘制完成后，恢复状态，不然会影响后续的绘制
}

//不带矩形
- (void)drawRectangeWithoutShadow{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //    CGContextSetShadowWithColor(currentContext, CGSizeMake(20, 20), 20, [[UIColor grayColor]CGColor]);
    CGRect rect1 = CGRectMake(155, 160, 150, 150);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect1);
    CGContextAddPath(currentContext, path);
    [[UIColor redColor]setFill];
    CGContextDrawPath(currentContext, kCGPathFill);
    CGPathRelease(path);
}
#pragma mark 线条的绘制
//CGPath
- (void)drawPath
{
    CGMutablePathRef path =CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20, 100);
    CGPathAddLineToPoint(path, NULL, 120, 100);
    CGPathMoveToPoint(path,NULL,20, 200);
    CGPathAddLineToPoint(path, NULL, 20, 280);
    CGContextRef currentRef = UIGraphicsGetCurrentContext();
    CGContextAddPath(currentRef, path);
    [[UIColor greenColor]set];
    CGContextDrawPath(currentRef, kCGPathFillStroke);
    CGPathRelease(path);
}
// 连线类型
- (void) drawRooftopAtToPointof:(CGPoint)point textToDisplay:(NSString *)text
                       lineJoin:(CGLineJoin)lineJoin
{
    [[UIColor blueColor]set];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, 15.0f);
    CGContextSetLineJoin(currentContext,lineJoin);
    CGContextMoveToPoint(currentContext, point.x, point.y);
    CGContextAddLineToPoint(currentContext, point.x +20, point.y + 40);
    CGContextAddLineToPoint(currentContext, point.x + 40, point.y + 40);
    CGContextStrokePath(currentContext);
    [[UIColor blackColor]set];
    [text drawAtPoint:CGPointMake(point.x + 20, point.y+40) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
    
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
