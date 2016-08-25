//
//  ProductDetailsViewController.m
//  Srms
//
//  Created by ohm on 16/7/18.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ProductDetailsViewController ()
{
    UIView * view;
    UIScrollView * imageScrollView;
    UIPageControl * pageControl;

}
@end

@implementation ProductDetailsViewController

- (void) viewWillAppear:(BOOL)animated{
    
      [self.currentNavigationController setDIYNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    // 右边栏
    UIView * rightView =[[UIView alloc] initWithFrame:CGRectMake(SIZEwidth - 320,0, 320, self.view.frame.size.height)];
    rightView.backgroundColor = [UIColor whiteColor];
    [view addSubview:rightView];
    
    UIButton * backBtn =[[UIButton alloc] initWithFrame:CGRectMake(30, rightView.frame.size.height-60, 250, 40)];
    [backBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"selectBackBtn4"]] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"selectBackBtn4_1"]] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:backBtn];
    
    NSString * goodsNoString =[_detailDictionary objectForKey:@"goodsno"];
    NSString * brandString =[_detailDictionary objectForKey:@"brand"];
    NSString * rangeString =[_detailDictionary objectForKey:@"range"];
    NSString * categoryString =[_detailDictionary objectForKey:@"category"];
    NSString * patternString =[_detailDictionary objectForKey:@"pattern"];
    NSString * seasonString =[_detailDictionary objectForKey:@"season"];
    NSString * sexString = [_detailDictionary objectForKey:@"sex"];
    NSString * materialString =[_detailDictionary objectForKey:@"material"];
    
    UILabel * goodsNameLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 5, 240, 40)];
    goodsNameLabel.textColor = [UIColor blackColor];
    goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    goodsNameLabel.text = categoryString;
    goodsNameLabel.font = [UIFont systemFontOfSize:22.0];
    [rightView addSubview:goodsNameLabel];
    
    UILabel * goodsNoLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 40, 240, 40)];
    goodsNoLabel.textColor = [UIColor blackColor];
    goodsNoLabel.textAlignment = NSTextAlignmentLeft;
    goodsNoLabel.text = [NSString stringWithFormat:@"货号:     %@",goodsNoString];
    goodsNoLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:goodsNoLabel];
    
    UILabel * brandLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 80, 240, 40)];
    brandLabel.textColor = [UIColor blackColor];
    brandLabel.textAlignment = NSTextAlignmentLeft;
    brandLabel.text =[NSString stringWithFormat:@"品牌:     %@",brandString];
    brandLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:brandLabel];
    
    UILabel * rangeLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 120, 240, 40)];
    rangeLabel.textColor = [UIColor blackColor];
    rangeLabel.textAlignment = NSTextAlignmentLeft;
    rangeLabel.text = [NSString stringWithFormat:@"系列:     %@",rangeString];
    rangeLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:rangeLabel];
    
    UILabel * categoryLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 160, 240, 40)];
    categoryLabel.textColor = [UIColor blackColor];
    categoryLabel.textAlignment = NSTextAlignmentLeft;
    categoryLabel.text = [NSString stringWithFormat:@"类别:     %@",categoryString];
    categoryLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:categoryLabel];
    
    UILabel * patternLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 200, 240, 40)];
    patternLabel.textColor = [UIColor blackColor];
    patternLabel.textAlignment = NSTextAlignmentLeft;
    patternLabel.text = [NSString stringWithFormat:@"款型:     %@",patternString];
    patternLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:patternLabel];
    
    UILabel * seasonLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 240, 240, 40)];
    seasonLabel.textColor = [UIColor blackColor];
    seasonLabel.textAlignment = NSTextAlignmentLeft;
    seasonLabel.text = [NSString stringWithFormat:@"季节:     %@",seasonString];
    seasonLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:seasonLabel];
    
    UILabel * sexLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 280, 240, 40)];
    sexLabel.textColor = [UIColor blackColor];
    sexLabel.textAlignment = NSTextAlignmentLeft;
    sexLabel.text = [NSString stringWithFormat:@"性别:     %@",sexString];
    sexLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:sexLabel];
    
    UILabel * materialLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 320, 240, 40)];
    materialLabel.textColor = [UIColor blackColor];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    materialLabel.text = [NSString stringWithFormat:@"面料:     %@",materialString];
    materialLabel.font = [UIFont systemFontOfSize:16.0];
    [rightView addSubview:materialLabel];
    
    // 左边栏
    imageScrollView =[[UIScrollView alloc] init];
    imageScrollView.pagingEnabled = YES;
    imageScrollView.alwaysBounceVertical = NO;
    imageScrollView.delegate = self;
    [view addSubview:imageScrollView];
    [imageScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(view.mas_left).offset(5);
        make.top.equalTo(view.mas_top).offset(0);
        make.bottom.equalTo(view.mas_bottom).offset(0);
        make.right.equalTo(rightView.mas_left).offset(0);
//        make.width.mas_equalTo(600);
    }];
    NSLog(@"kuang = %f",SIZEwidth*2/3);
    UIView *scrollerContentView = [[UIView alloc]init];
    [imageScrollView addSubview:scrollerContentView];
    [scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.edges.equalTo(imageScrollView);
        make.height.equalTo(imageScrollView);
    }];
    
    NSArray * picturesArray = [_detailDictionary objectForKey:@"pictures"];
    UIImageView *lastImageView;
    for (int i = 0; i < picturesArray.count;i++) {
        
        NSDictionary * dic =[picturesArray objectAtIndex:i];
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollerContentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.top.equalTo(scrollerContentView.mas_top);
            make.bottom.equalTo(scrollerContentView.mas_bottom);
            make.left.equalTo(scrollerContentView.mas_left).offset(i * (SIZEwidth - 320 - 5));
            make.width.mas_equalTo(SIZEwidth - 320 - 5);
        }];
        __block SDPieLoopProgressView *progressView;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]]] placeholderImage:[UIImage imageNamed:@"err"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (progressView == nil) {
                    
                    progressView = [[SDPieLoopProgressView alloc]init];
                    progressView.frame = CGRectMake(0, 0, 50, 50);
                    progressView.center = imageView.center;
                    [imageView addSubview:progressView];
                }
                progressView.progress = (float) receivedSize/ (float)expectedSize;
            });
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            
            for (UIView * subView in imageView.subviews) {
                
                if ([subView isKindOfClass:[SDPieLoopProgressView class]]) {
                    
                    [subView removeFromSuperview];
                }
            }
        }];
        lastImageView = imageView;
    }
    if (lastImageView) {
        
        [scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.right.equalTo(lastImageView.mas_right);
        }];
    }
    
    UIView * pageView =[[UIView alloc] init];
    pageView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    [view addSubview:pageView];
    [pageView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.bottom.right.equalTo(imageScrollView);
        make.height.mas_equalTo(80);
    }];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = picturesArray.count;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [pageControl addTarget:self action:@selector(changePages) forControlEvents:UIControlEventValueChanged];
    [pageView addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(pageView.mas_centerX);
        make.centerY.equalTo(pageView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
}

-(void)backBtnClick{

    [self.navigationController popViewControllerAnimated:YES];

}

-(void)changePages{
    
    NSLog(@"111========%ld",(long)pageControl.currentPage);
    [imageScrollView setContentOffset:CGPointMake(pageControl.currentPage*(SIZEwidth - 320 - 5), 0) animated:YES];
}
#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"111========%ld",(long)pageControl.currentPage);
    pageControl.currentPage = scrollView.contentOffset.x/(SIZEwidth - 320 - 5);
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}



@end
