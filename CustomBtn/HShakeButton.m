//
//  HShakeButton.m
//  CustomBtn
//
//  Created by 黄含章 on 15/7/28.
//  Copyright (c) 2015年 HHZ. All rights reserved.
//

#import "HShakeButton.h"

#define angelToRandian(x)  ((x)/180.0*M_PI)

@interface HShakeButton()

@property(nonatomic,strong)UIButton *deletedBtn;

@end

@implementation HShakeButton

//便利构造方法
+(instancetype)HShakeButtonWithImage:(UIImage *)img {
    HShakeButton *shakeBtn = [[self alloc]init];
    shakeBtn.image = img;
    return shakeBtn;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化
        self.userInteractionEnabled = YES;
        
        CALayer *layer = [self layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 4.0;
        
        _deletedBtn = [[UIButton alloc]init];
        _deletedBtn.hidden = YES;
        [_deletedBtn addTarget:self action:@selector(deleteClicked) forControlEvents:UIControlEventTouchUpInside];
        [_deletedBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deletedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deletedBtn.frame = CGRectMake(10, 20, 60, 30);
        [self addSubview:_deletedBtn];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked)];
        [self addGestureRecognizer:tapGesture];
        [self addGestureRecognizer:longPress];
        
    }
    return self;
}

//长按手势
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CAKeyframeAnimation *animate = [CAKeyframeAnimation animation];
        animate.keyPath = @"transform.rotation";
        animate.values = @[@(angelToRandian(-7)),@(angelToRandian(7)),@(angelToRandian(-7))];
        animate.repeatCount = MAXFLOAT;
        animate.duration = 0.2;
        _deletedBtn.hidden = NO;
        [self.layer addAnimation:animate forKey:nil];
    }
}

//点击取消抖动
- (void)tapClicked {
    [self.layer removeAllAnimations];
    _deletedBtn.hidden = YES;
}

//删除按钮
- (void)deleteClicked {
    [UIView animateWithDuration:1.0 animations:^{
        [_deletedBtn removeFromSuperview];
        self.frame = CGRectMake(0, 0, 0, 0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
