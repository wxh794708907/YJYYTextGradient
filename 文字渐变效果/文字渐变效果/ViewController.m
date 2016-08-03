//
//  ViewController.m
//  文字渐变效果
//
//  Created by 远洋 on 16/2/9.
//  Copyright © 2016年 yuayang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//全局的属性
@property (nonatomic,strong)CAGradientLayer * gradientLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc]init];
    
    label.text = @"实现文字渐变效果";
    
    [label sizeToFit];
    
    [self.view addSubview:label];
    
    label.center = CGPointMake(200, 100);
    
    //创建渐变层
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    
    //下面这两句代码 控制的是 文字渐变的方向 是上下还是左右 默认是上下 设置了下面的两个属性就是左右
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    
    gradientLayer.endPoint  = CGPointMake(1.0, 1.0);
    
    //给全局属性赋值
    self.gradientLayer = gradientLayer;
    
    //设置渐变层的frame和label的大小一致
    gradientLayer.frame = label.frame;
    
    //设置渐变层的颜色 随机颜色实现渐变
    gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    
    //添加渐变层到控制器的view图层上
    [self.view.layer addSublayer:gradientLayer];
    
    //设置渐变层的裁剪层 mask的类型是一个CALayer类型的 其实简单来说下面这句话的意思是 让label作为裁剪的一个平台 文字是非透明的 其他部分都会被减掉 这样就相当于留了文字的区域 让渐变层去填充文字的颜色
    gradientLayer.mask = label.layer;
    
    //一旦把label层设置为了mask层，label层就不能显示了，会直接从父层中移除 然后作为渐变层的mask层 且label层的父层会指向渐变层 所以在这里需要重新计算label的位置才能正确的设置裁剪区域
    label.frame = gradientLayer.bounds;
    
    //利用定时器 快速的切换渐变颜色，就有了文字颜色变化的效果了
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(colorChange)];
    
    //控制渐变间隔
    displayLink.frameInterval = 30;
    
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}


#pragma mark - /********定时器触发的方法*******/
- (void)colorChange {
    self.gradientLayer.colors = @[(id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor];
}


#pragma mark - /********随机颜色的方法*******/
- (UIColor *)randomColor {
    return [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

@end
