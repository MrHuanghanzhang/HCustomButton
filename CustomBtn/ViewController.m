//
//  ViewController.m
//  CustomBtn
//
//  Created by 黄含章 on 15/7/28.
//  Copyright (c) 2015年 HHZ. All rights reserved.
//

#import "ViewController.h"
#import "DeformationButton.h"
#import "HYBubbleButton.h"
#import "CatZanButton.h"
#import "HShakeButton.h"

#define angelToRandian(x)  ((x)/180.0*M_PI)

@interface ViewController ()
//星星按钮
@property (strong, nonatomic) HYBubbleButton *bubbleButton;

//点击抖动按钮
@property(nonatomic,strong)UIImageView *shakeBtn;
@property(nonatomic,strong)UIButton *deletedBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //点击切换动画的btn
    [self setupDeformationBtn];
    
    //创建点击出星星的按钮
    [self setupStarBtn];
    
    //创建九宫格等Btn
    [self setupSudokuBtn];
    
    //模仿iOS删除的按钮
    [self setuoShakeBtn];
    
    //创建点赞按钮
    [self setupZanBtn];
    
}

#pragma mark - 点击切换动画按钮
- (void)setupDeformationBtn {
    DeformationButton *deformationBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(130, 80, 110, 35) withColor:[UIColor magentaColor]];
    [self.view addSubview:deformationBtn];
    
    [deformationBtn.forDisplayButton setTitle:@"点击变换" forState:UIControlStateNormal];
    deformationBtn.forDisplayButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [deformationBtn.forDisplayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [deformationBtn.forDisplayButton setImage:[UIImage imageNamed:@"微信logo.png"] forState:UIControlStateNormal];
    [deformationBtn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnEvent {
    NSLog(@"点击了变换按钮！");
}

#pragma mark - ✨按钮
- (void)setupStarBtn {
    _bubbleButton = [[HYBubbleButton alloc]initWithFrame:CGRectMake(250, self.view.bounds.size.height - 140, 50, 50) maxLeft:150 maxRight:100 maxHeight:300];
    [_bubbleButton addTarget:self action:@selector(starClicked) forControlEvents:UIControlEventTouchUpInside];
    _bubbleButton.images = @[[UIImage imageNamed:@"oval"], [UIImage imageNamed:@"star"]];
    _bubbleButton.duration = 8;
    [_bubbleButton setBackgroundImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
    [self.view addSubview:_bubbleButton];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor magentaColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.text = @"点击我出✨";
    label.frame = CGRectMake(_bubbleButton.frame.origin.x - 10, CGRectGetMinY(_bubbleButton.frame) - 30, 80, 20);
    [self.view addSubview:label];
}

- (void)starClicked {
     [_bubbleButton generateBubbleInRandom];
}

#pragma mark - 创建9宫格等算法btn
- (void)setupSudokuBtn {
    CGFloat paddingX = 16;
    CGFloat paddingY = 10;
    NSInteger perRowItemCount = 4;
    NSInteger perColumItemCount = 5;
    CGFloat itemWidth = 60;
    CGFloat itemHeight = 20;
    NSInteger tatalCount = 100;
    for (int index = 0; index < tatalCount; index ++) {
        NSInteger page = index / (perRowItemCount * perColumItemCount);
        CGRect buttonFrame = [self getFrameWithPerRowItemCount:perRowItemCount perColumItemCount:perColumItemCount itemWidth:itemWidth itemHeight:itemHeight paddingX:paddingX paddingY:paddingY atIndex:index onPage:page WithX:30 AndY:130];
        UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
        button.tag = index;
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"第%d个按钮",index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setBackgroundColor:[UIColor cyanColor]];
        [self.view addSubview:button];
    }
}

- (void)btnClicked:(UIButton *)button {
    NSLog(@"点击了第%d个Button",button.tag);
}

/**
 *  通过目标的参数，获取一个grid布局
 *
 *  @param perRowItemCount   每行有多少列
 *  @param perColumItemCount 每列有多少行
 *  @param itemWidth         gridItem的宽度
 *  @param itemHeight        gridItem的高度
 *  @param paddingX          gridItem之间的X轴间隔
 *  @param paddingY          gridItem之间的Y轴间隔
 *  @param index             某个gridItem所在的index序号
 *  @param page              某个gridItem所在的页码
 *  @param X                 整个View的X值
 *  @param Y                 整个View的Y值
 *
 *  @return 返回一个已经处理好的gridItem frame
 */
- (CGRect)getFrameWithPerRowItemCount:(NSInteger)perRowItemCount
                    perColumItemCount:(NSInteger)perColumItemCount
                            itemWidth:(CGFloat)itemWidth
                           itemHeight:(NSInteger)itemHeight
                             paddingX:(CGFloat)paddingX
                             paddingY:(CGFloat)paddingY
                              atIndex:(NSInteger)index
                               onPage:(NSInteger)page
                                WithX:(NSInteger)X
                                 AndY:(NSInteger)Y{
    CGRect itemFrame = CGRectMake((index % perRowItemCount) * (itemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.view.bounds)) + X, ((index / perRowItemCount) - perColumItemCount * page) * (itemHeight + paddingY) + paddingY + Y, itemWidth, itemHeight);
    return itemFrame;
}

#pragma mark - 抖动删除按钮
- (void)setuoShakeBtn {
    _shakeBtn = [HShakeButton HShakeButtonWithImage:[UIImage imageNamed:@"111"]];
    [_shakeBtn setFrame:CGRectMake(160, 340, 80, 80)];
    [self.view addSubview:_shakeBtn];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor magentaColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.text = @"请长按我！";
    label.frame = CGRectMake(_shakeBtn.frame.origin.x + 10, CGRectGetMinY(_shakeBtn.frame) - 30, 80, 20);
    [self.view addSubview:label];
}


#pragma mark - 创建点赞按钮
- (void)setupZanBtn {
    CatZanButton *zanBtn=[[CatZanButton alloc] init];
    zanBtn.frame = CGRectMake(50, 510, 40, 40);
    [self.view addSubview:zanBtn];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor magentaColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.text = @"赞一下！";
    label.frame = CGRectMake(zanBtn.frame.origin.x - 10, CGRectGetMinY(zanBtn.frame) - 30, 80, 20);
    [self.view addSubview:label];
    
    [zanBtn setType:CatZanButtonTypeFirework];
    
    [zanBtn setClickHandler:^(CatZanButton *zanButton) {
        if (zanButton.isZan) {
            NSLog(@"Zan!");
        }else{
            NSLog(@"Cancel zan!");
        }
    }];
}

@end
