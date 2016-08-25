//
//  ClassSingViewController.m
//  Srms
//
//  Created by ohm on 16/7/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSAddCommentViewController.h"
#import "ProductViewController.h"
@interface RSAddCommentViewController ()<UITextFieldDelegate>
// 装载不同的评论
@property(nonatomic, strong) NSMutableArray *commemtArray;

@end

@implementation RSAddCommentViewController
- (void) initData{
    _textfiled.delegate = self;
     _starNumber = 0;
    _commemtArray = [NSMutableArray array];
}
// 评价
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)ImageSelect:(UIButton *)sender {
    
   
    for (int i = 1001 ; i < 1006; i++) {
        if (i <= sender.tag) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            [btn setBackgroundImage:[UIImage imageNamed:@"stars09"] forState:UIControlStateNormal];
            _starNumber = (int)sender.tag - 1000;
        }else{
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        [btn setBackgroundImage:[UIImage imageNamed:@"stars0"] forState:UIControlStateNormal];
        }
    }
}
- (IBAction)textSelectBtn:(UIButton *)sender {
    
    for(NSInteger i = 1; i <= 4; i ++){
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        btn.selected = NO;
    }
    if (!sender.selected) {
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self addCommentToCommentArray];
        switch (sender.tag) {
            case 1:{
                _commentTypeString = @"01";
                _textfiled.placeholder = @"商品是否给力，发表下您的评价吧。";
                
            }
                break;
            case 2:{
                _commentTypeString = @"02";
                _textfiled.placeholder = @"请针对[款式]发表一下您宝贵的建议";
            }
                break;
            case 3:{
                _commentTypeString = @"03";
                _textfiled.placeholder = @"请针对[颜色]发表一下您宝贵的建议";
            }
                break;
            case 4:{
                _commentTypeString = @"04";
                _textfiled.placeholder = @"请针对[袖子2]发表一下您宝贵的建议";
            }
                break;
            default:
                break;
        }
        
    }else{
        [sender setTitleColor:[UIColor blackColor] forState:0];
    }
    _textfiled.text = @"";
    sender.selected = !sender.selected;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self addCommentToCommentArray];
}

- (void) addCommentToCommentArray{
    
    if (![_textfiled.text isEqualToString:@""] && _textfiled) {
        
        NSDictionary * dic =@{@"commentTypeCode":[_commentTypeString copy],@"comment":[_textfiled.text copy]};
        BOOL isExsit = NO;
        for (NSInteger i = 0 ; i < _commemtArray.count; i ++) {
            
            NSDictionary *dic = _commemtArray[i];
            if ([dic[@"commentTypeCode"] isEqualToString:_textfiled.text]) {
                
                isExsit = YES;
                [_commemtArray replaceObjectAtIndex:i withObject:dic];
                break;
            }
        }
        if (!isExsit && _commemtArray.count <= 4) {
            
            [_commemtArray addObject:dic];
        }
    }
}
//发表评论
- (IBAction)makeBtn:(UIButton *)sender {
    
    
    if (_commentTypeString.intValue >0 && _starNumber>= 0) {
        
        NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
        NSString * userNoString =[PublicKit getPlistParameter:NameTextString];
        NSString * urlString =[NSString stringWithFormat:@"%@/rs/goods/saveComments",serveSreing];
        NSDictionary *parameters = @{@"userNo": userNoString,@"goodsId":_goodNoString,@"star":@(_starNumber),@"details":_commemtArray};
        NSLog(@"获取到的参数 ＝ %@",_commemtArray);
        
        [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            NSLog(@"发表评价成功dic==%@",dic);
            ProductViewController * productView =[[ProductViewController alloc] init];
            productView.hidesBottomBarWhenPushed = YES;
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }else{
    
        UIAlertView * alerView =[[UIAlertView alloc] initWithTitle:nil message:@"请对商品进行评分并选择类型评价" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alerView show];
    
    }
}
//取消评论
- (IBAction)backBtn:(UIButton *)sender {
    ProductViewController * productView =[[ProductViewController alloc] init];
    productView.hidesBottomBarWhenPushed = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
