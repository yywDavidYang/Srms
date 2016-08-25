//
//  ProductViewController.m
//  Srms
//
//  Created by ohm on 16/6/7.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ProductViewController.h"
#import "ShopCollectionViewCell.h"
#import "ProductViewController.h"
#import "RSHotProductViewController.h"
#import "RSAddCommentViewController.h"
#import "ProductDetailsViewController.h"
#import "ShopContainerViewController.h"
#import "ProductCell.h"
#import "RSCommentModel.h"
#import "RSProductCommentView.h"


#define SIZEWidth self.view.frame.size.width
#define SIZEhight self.view.frame.size.height
#define RSScrollerBarViewTag 40010

@interface ProductViewController (){
    
    NSString * tf;
    UIView *  footViewTab ;
    int * firstNumber;//初始的数量(数据库中查出的尺码以及颜色的记录)
    UILabel * priceLabel3;//订货单价
    UILabel * numberLabel1; //订货总数
    UILabel * moneyLabel1;//订货合计
    NSString * stcokqtyNumber;//校验库存
    NSInteger numberTag;
    NSMutableArray* textfiledArray;              //存放订货textfiled的数组
    NSMutableArray * labelTextArray;              //存放订货numbeerLabel1的数组
    NSInteger numberRow;
    NSMutableArray* amountLabArray;
    UIView * amountLabeiView ;
    UIView * lineView; // 中间分割线
}

@property (nonatomic, weak) UIView *coverView;//一个遮罩的view
@property (nonatomic, strong)  UIScrollView * imageScrollView;
@property (nonatomic, strong)  UIPageControl * pageControl;
@property (nonatomic, strong)  UIView *scrollerViewContentView;
@property (nonatomic, strong) NSMutableArray *commentModelArray;
@property (nonatomic, strong) RSProductCommentView *commentView;
@property (nonatomic, strong) UIImageView *scrollerBarView;// 滚动条

@end
UIButton * button1;
UIButton * button2;
UIButton * button3;
UIButton * button4;
@implementation ProductViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [footViewTab removeFromSuperview];
    [self httpGetComments];
    [self httpGetgoodsinfo];
    [self setNavigationModel];
}
-(void)viewDidDisappear:(BOOL)animated{
    tf = @"";
    [textfiledArray removeAllObjects];
    [labelTextArray removeAllObjects];
    [footViewTab removeFromSuperview];

}
// 设置导航栏的样式
- (void) setNavigationModel{
    
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = NO;
    self.currentNavigationController.titleText = @"商品详情";
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    numberTag = 0;
    _sizeNnm = 0;
    numberLabel1.text = @"";
    tf = @"";
    
    textfiledArray = nil;
    labelTextArray = nil;
    textfiledArray =[[NSMutableArray alloc] init];
    labelTextArray = [[NSMutableArray alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( tableView ==evaluTableView){
        return 0;
    }else if (tableView ==formTableView){
    return 46;
    }else if (tableView ==accountTableView){
        return 40;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if( tableView == formTableView){
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZEWidth-(SIZEWidth/3)-16, 46)];
        view.backgroundColor = [UIColor whiteColor];
        
        if (colorArray.count >0 ) {
            for (int i = 0; i<sizeArray.count; i++) {
                NSDictionary * imageDic =[sizeArray objectAtIndex:i];
                UIImageView * imageview =[[UIImageView alloc] initWithFrame:CGRectMake(112+102*i, 5, 36, 36)];
                [view addSubview:imageview];
                
                UILabel * sizeLabel =[[UILabel alloc] initWithFrame:CGRectMake(112+102*i, 5, 36, 36)];
                sizeLabel.textAlignment = NSTextAlignmentCenter;
                sizeLabel.font =[UIFont systemFontOfSize:16.0];
                sizeLabel.textColor = [UIColor greenColor];
                sizeLabel.text = [imageDic objectForKey:@"size"];
                [view addSubview:sizeLabel];
                
            }
        }
        return view;
    }else if (tableView == accountTableView){
        
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 160, accountView.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        NSArray * array =[_accountDictionary objectForKey:@"size"];
        if (array.count >0 ) {
            for (int i = 0; i<array.count; i++) {
                UIImageView * imageview =[[UIImageView alloc] initWithFrame:CGRectMake(120+90*i, 0, 36, 36)];
                imageview.image = [UIImage imageNamed:@"backGround1"];
                [view addSubview:imageview];
                
                UILabel * sizeLabel =[[UILabel alloc] initWithFrame:CGRectMake(120+90*i, 0, 35, 35)];
                sizeLabel.textAlignment = NSTextAlignmentCenter;
                sizeLabel.font =[UIFont systemFontOfSize:12.0];
                sizeLabel.textColor = [UIColor greenColor];
                sizeLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
                sizeLabel.textColor =[UIColor blackColor];
                [view addSubview:sizeLabel];
                
            }
        }
        return view;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == formTableView){
        
        return colorArray.count;
    }
    else if (tableView == accountTableView){
        
        return _accountArray.count;
    }
    return 0;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == evaluTableView){
        return 80;
        
    }
    else if (tableView == formTableView){
        return 46;
    }
    else if (tableView == accountTableView){
        return 40;
    
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == formTableView) {
        
        ProductCell * cell =[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cellwith%ld",(long)indexPath.row]];
        if (!cell) {
            cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cellwith%ld",(long)indexPath.row]];
            
            numberRow = 0;
            for (int i = 0; i< sizeArray.count; i++) {
                
                NSArray  *  seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"SizeData" fieldName:@"goodsNo" fieldValue:_goodNoString];
                sizefiled =[[UITextField alloc] initWithFrame:CGRectMake(80+100*i, 5, 100, 40)];
                if (seartchDataArray.count>0) {
                    
                    for (SizeData * sizedata in seartchDataArray) {

                        NSString * j =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                        NSString * toA = [NSString stringWithFormat:@"%@",sizedata.totalA];
                        NSString * toB = [NSString stringWithFormat:@"%@",sizedata.totalB];
       
                        if (j.intValue == toA.intValue && i == toB.intValue) {
                                sizefiled.text = [NSString stringWithFormat:@"%@",sizedata.context];
//                            NSLog(@"--->%@",sizefiled.text);
                                numberRow = numberRow + sizefiled.text.intValue;
                        }
                   }
                }
                
                sizefiled.textAlignment = NSTextAlignmentCenter;
                sizefiled.borderStyle = UITextBorderStyleNone;
                sizefiled.returnKeyType = UIReturnKeyNext;
                sizefiled.tag = i+indexPath.row*sizeArray.count;
                numberTag = indexPath.row;
                sizefiled.delegate =self;
                    
                sizefiled.layer.borderColor = [[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] CGColor];
                sizefiled.layer.borderWidth = 1;
                sizefiled.font =[UIFont systemFontOfSize:14.0];
                [cell.contentView addSubview:sizefiled];
                [textfiledArray addObject:sizefiled];

                
                NSDictionary * dic = [sizeArray objectAtIndex:i];
                NSArray *  array = [dic objectForKey:@"longs"];
                NSDictionary * imageDic =[array objectAtIndex:0];
                NSArray * colorarray =[imageDic objectForKey:@"colors"];
                
                NSDictionary * dictionary = [colorarray objectAtIndex:indexPath.row];
                stcokqtyNumber = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"stcokqty"]];
                if (stcokqtyNumber.intValue<=0) {
                    sizefiled.placeholder = @"缺货";
                    sizefiled.userInteractionEnabled = NO;
                }
            }
            NSDictionary * dic = [colorArray objectAtIndex:indexPath.row ];
            UILabel * sizeLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            sizeLabel.textAlignment = NSTextAlignmentCenter;
            sizeLabel.font =[UIFont systemFontOfSize:14.0];
            sizeLabel.text = [dic objectForKey:@"colordesc"];
            [cell.contentView addSubview:sizeLabel];
            
            numberColorLabel =[[UILabel alloc] initWithFrame:CGRectMake(80+100*sizeArray.count, 0, 100, 60)];
            numberColorLabel.textAlignment = NSTextAlignmentCenter;
            numberColorLabel.font =[UIFont systemFontOfSize:14.0];
            numberColorLabel.text =[NSString stringWithFormat:@"共 %ld 件",(long)numberRow];
            numberColorLabel.tag = indexPath.row;
            [cell.contentView addSubview:numberColorLabel];
            [labelTextArray addObject:numberColorLabel];
            cell.tag = numberColorLabel.tag;
            
        }
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    
    }//详情列表
    else if (tableView == accountTableView){
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        NSDictionary * dic =[_accountArray objectAtIndex:indexPath.row];
        UILabel * sizeLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        sizeLabel.textAlignment = NSTextAlignmentCenter;
        sizeLabel.font =[UIFont systemFontOfSize:12.0];
        sizeLabel.text = [dic objectForKey:@"color"];
        [cell.contentView addSubview:sizeLabel];
        
        
        NSArray * numberArray =[_accountDictionary objectForKey:@"size"];
        UILabel * sizeNumLabel;
        NSMutableArray *numLabel =[[NSMutableArray alloc] init];
        if (numberArray.count >0 ) {
            for (int i = 0; i<numberArray.count; i++) {
                sizeNumLabel =[[UILabel alloc] initWithFrame:CGRectMake(120+90*i, 0, 35, 35)];
                sizeNumLabel.textAlignment = NSTextAlignmentCenter;
                sizeNumLabel.font =[UIFont systemFontOfSize:12.0];
                sizeNumLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:[numberArray objectAtIndex:i]]];
                [cell.contentView  addSubview:sizeNumLabel];
                [numLabel addObject:sizeNumLabel];
                
            }
        }
        UILabel * numberLabel =[[UILabel alloc] initWithFrame:CGRectMake(accountView.frame.size.width-100, 0, 100, 60)];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font =[UIFont systemFontOfSize:12.0];
        int num = 0;
        for (UILabel * label in numLabel) {
            num += [label.text intValue];
}
        numberLabel.text = [NSString stringWithFormat:@"共 %d 件",num];
        [cell.contentView addSubview:numberLabel];

        return cell;
    }

    return nil;

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    UITextField * str = [[UITextField alloc] init];
    //校验库存
    NSString * ischeckstockString = [PublicKit getPlistParameter:IScheckstock];
    NSString * maxstockString = [PublicKit getPlistParameter:Maxstock];
    
    ProductCell * cell =(ProductCell *)[[textField superview] superview];
    NSIndexPath * path = [formTableView indexPathForCell:cell];
    //获取按钮所在的cell的row
    
    numberColorLabel = [labelTextArray objectAtIndex:path.row];
    
    if ([ischeckstockString isEqualToString:@"1"]) {
        
        for (int i = 0; i<sizeArray.count; i++) {
            if (textField.tag == (i+path.row*sizeArray.count)) {
                
                NSDictionary * dic = [sizeArray objectAtIndex:i];
                NSArray *  array = [dic objectForKey:@"longs"];
                NSDictionary * imageDic =[array objectAtIndex:0];
                NSArray * colorarray =[imageDic objectForKey:@"colors"];
                
                NSDictionary * dictionary = [colorarray objectAtIndex:path.row];
                stcokqtyNumber = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"stcokqty"]];
                NSLog(@"22222====%@",stcokqtyNumber);
                
                if (textField.text.intValue > stcokqtyNumber.intValue) {
                    
                }else{
                    str = [textfiledArray objectAtIndex:textField.tag];
                    tf = [str.text mutableCopy];
                    
                }
                
            }
        }
    }else{
       
        
        for (int i = 0; i<sizeArray.count; i++) {
            if (textField.tag == (i+path.row*sizeArray.count)) {
                
                if (textField.text.intValue <= maxstockString.intValue) {
                    str = [textfiledArray objectAtIndex:textField.tag];
                    tf = [str.text mutableCopy];

                }else{
                    
                    
                }
                
            }
        }
    }
 }

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //校验库存
    NSString * ischeckstockString = [PublicKit getPlistParameter:IScheckstock];
    NSString * maxstockString = [PublicKit getPlistParameter:Maxstock];
    
    if ([ischeckstockString isEqualToString:@"1"]) {
        
        //合计
        NSInteger allNumberPrice = 0;
        _sizeNnm = 0;
        numberRow = 0;
        //cell tag 找控件
        ProductCell * cell =(ProductCell *)[[textField superview] superview];
        NSIndexPath * path = [formTableView indexPathForCell:cell];
        //获取按钮所在的cell的row
        
        numberColorLabel = [labelTextArray objectAtIndex:path.row];
        for (int i = 0; i<sizeArray.count; i++) {
            if (textField.tag == (i+path.row*sizeArray.count)) {
                
                NSDictionary * dic = [sizeArray objectAtIndex:i];
                NSArray *  array = [dic objectForKey:@"longs"];
                NSDictionary * imageDic =[array objectAtIndex:0];
                NSArray * colorarray =[imageDic objectForKey:@"colors"];
                
                NSDictionary * dictionary = [colorarray objectAtIndex:path.row];
                stcokqtyNumber = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"stcokqty"]];
                
                if (stcokqtyNumber.intValue>0) {
                    if (textField.text.intValue <= stcokqtyNumber.intValue) {
                        numberRow = textField.text.integerValue + [numberColorLabel.text componentsSeparatedByString:@" "][1].integerValue - tf.integerValue;
                        numberColorLabel.text = [NSString stringWithFormat:@"共 %ld 件 ",(long)numberRow];
                        for (UITextField * textField in textfiledArray) {
                            _sizeNnm += [textField.text integerValue];
                        }
                        NSArray * priceArray =[_dataDictionary objectForKey:@"priceranges"];
                        NSDictionary * priceDic =[priceArray objectAtIndex:0];
                        priceLabel3.text =[NSString stringWithFormat:@"单价:  ￥%@",[priceDic objectForKey:@"prcie"]];
                        numberLabel1.text = [NSString stringWithFormat:@"数量:  %ld",(long)_sizeNnm];
                        NSString* string =[priceDic objectForKey:@"prcie"];
                        allNumberPrice = _sizeNnm* (string.intValue);
                        moneyLabel1.text = [NSString stringWithFormat:@"合计:  ￥%ld",(long)allNumberPrice];
                        
                    }else{
                        
                        tf = @"";
                        UIAlertView * alertView =[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"不能大于库存量(%@)",stcokqtyNumber] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alertView show];
                        
                    }

                }else{
                
                    textField.userInteractionEnabled = NO;
                }
                
        }
            
        }
        
    }else{
    
        NSInteger allNumberPrice = 0;
        _sizeNnm = 0;
        numberRow = 0;
        //cell tag 找控件
        ProductCell * cell =(ProductCell *)[[textField superview] superview];
        NSIndexPath * path = [formTableView indexPathForCell:cell];
        //获取按钮所在的cell的row
        
        numberColorLabel = [labelTextArray objectAtIndex:path.row];
        for (int i = 0; i<sizeArray.count; i++) {
            if (textField.tag == (i+path.row*sizeArray.count)) {
                
                if (textField.text.intValue <= maxstockString.intValue) {
                    numberRow = textField.text.integerValue + [numberColorLabel.text componentsSeparatedByString:@" "][1].integerValue - tf.integerValue;
                    numberColorLabel.text = [NSString stringWithFormat:@"共 %ld 件 ",(long)numberRow];
                    
                    for (UITextField * textField in textfiledArray) {
                        _sizeNnm += [textField.text integerValue];
                    }
                    NSArray * priceArray =[_dataDictionary objectForKey:@"priceranges"];
                    NSDictionary * priceDic =[priceArray objectAtIndex:0];
                    priceLabel3.text =[NSString stringWithFormat:@"单价:  ￥%@",[priceDic objectForKey:@"prcie"]];
                    numberLabel1.text = [NSString stringWithFormat:@"数量:  %ld",(long)_sizeNnm];
                    NSString* string =[priceDic objectForKey:@"prcie"];
                    allNumberPrice = _sizeNnm* (string.intValue);
                    moneyLabel1.text = [NSString stringWithFormat:@"合计:  ￥%ld",(long)allNumberPrice];
                    
                }else{
                    
                    UIAlertView * alertView =[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"不能大于库存量(%@)",maxstockString] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                    
                }
            }
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSUInteger index = [textfiledArray indexOfObject:textField];
    if (index < textfiledArray.count - 1) {
        UITextField *nextTextField = textfiledArray[index + 1];
        return [nextTextField becomeFirstResponder];
    }else if (index == textfiledArray.count - 1){
        
        UITextField *nextTextField = [textfiledArray firstObject];
        return [nextTextField becomeFirstResponder];
    }else{
        
        return [textField becomeFirstResponder];
    }
}
//订货
-(void)orderClick{
    NSString * stringBool = @"SizeData";
    NSMutableArray* isArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:@"goodsNo" fieldValue:_goodNoString];
    if (isArray.count>0) {
        
        [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"ProductData" fieldName:@"goodsNo" fieldValue:_goodNoString];
        [[ShopSaveManage shareManager] saveLocaProduct:_dataDictionary];
    }else{
        
        [[ShopSaveManage shareManager] saveLocaProduct:_dataDictionary];
    }
    [self orderOrMatched:stringBool];
}
//加入搭配区
-(void)matchedClick:(UIButton *)sender{
    
    [sender setBackgroundImage:[UIImage imageNamed:@"matched2"] forState:UIControlStateNormal];
    NSString * stringBool = @"MatchedData";
    NSMutableArray* isArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"MatchedProduct" fieldName:@"goodsNo" fieldValue:_goodNoString];
    if (isArray.count>0) {
        [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"MatchedProduct" fieldName:@"goodsNo" fieldValue:_goodNoString];
        [[ShopSaveManage shareManager] saveLocalMatchedProduct:_dataDictionary];
    }else{
        [[ShopSaveManage shareManager] saveLocalMatchedProduct:_dataDictionary];
    }
    if (_sizeNnm<=0) {
        [self httpGetAddTempAssortArea];//加入搭配请求];
    }else{
        [self orderOrMatched:stringBool];
    }
}
//判断点击的订货还是搭配
-(void)orderOrMatched:(NSString * )stringBool{
    if (_sizeNnm>0) {
        NSArray * priceArray =[_dataDictionary objectForKey:@"priceranges"];
        NSDictionary * priceDic =[priceArray objectAtIndex:0];
        NSString* string =[priceDic objectForKey:@"prcie"];
        NSMutableArray* isSizeArray = [[ShopSaveManage shareManager] getFFetchRequestData:stringBool fieldName:@"goodsNo" fieldValue:_goodNoString];
        if (isSizeArray.count>0) {
            [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:stringBool fieldName:@"goodsNo" fieldValue:_goodNoString];
            NSMutableDictionary * sizeDic =[[NSMutableDictionary alloc] init];
            for (int i = 0; i<numberTag+1; i++) {
                for (int j=0; j<sizeArray.count; j++) {
                    UITextField * textString = [textfiledArray objectAtIndex:i*sizeArray.count+j];
                    if (textString.text.length>0) {
                        [sizeDic setObject:textString.text forKey:@"context"];
                        [sizeDic setObject:@(i) forKey:@"totalA"];
                        [sizeDic setObject:@(j) forKey:@"totalB"];
                        [sizeDic setObject:numberLabel1.text forKey:@"disRate"];
                        [sizeDic setObject:@(_sizeNnm) forKey:@"totalQty"];
                        [sizeDic setObject:@(_sizeNnm *string.integerValue) forKey:@"totalAmount"];
                        [sizeDic setObject:_goodNoString forKey:@"goodsNo"];
                        [sizeDic setObject:_disPriceString forKey:@"disPrice"];
                        
                        if ([stringBool isEqualToString:@"SizeData"]) {
                            
                            [[ShopSaveManage shareManager] saveSizeDataLocaProduct:sizeDic];
                        }else{
                            
                            [[ShopSaveManage shareManager] saveMatchedDataLocaProduct:sizeDic];
                        }
                    }
                }
            }
         }else{
            NSMutableDictionary * sizeDic =[[NSMutableDictionary alloc] init];
            for (int i = 0; i<numberTag+1; i++) {
                for (int j=0; j<sizeArray.count; j++) {
                    UITextField * textString = [textfiledArray objectAtIndex:i*sizeArray.count+j];
                    if (textString.text.length>0) {
                        [sizeDic setObject:textString.text forKey:@"context"];
                        [sizeDic setObject:@(i) forKey:@"totalA"];
                        [sizeDic setObject:@(j) forKey:@"totalB"];
                        [sizeDic setObject:numberLabel1.text forKey:@"disRate"];
                        [sizeDic setObject:@(_sizeNnm) forKey:@"totalQty"];
                        [sizeDic setObject:@(_sizeNnm *string.integerValue) forKey:@"totalAmount"];
                        [sizeDic setObject:_goodNoString forKey:@"goodsNo"];
                        [sizeDic setObject:_disPriceString forKey:@"disPrice"];
                        if ([stringBool isEqualToString:@"SizeData"]) {
                            [[ShopSaveManage shareManager] saveSizeDataLocaProduct:sizeDic];
                        }else{
                            [[ShopSaveManage shareManager] saveMatchedDataLocaProduct:sizeDic];
                        }
                    }
                }
            }
        }
        if ([stringBool isEqualToString:@"SizeData"]) {
            //商品订货请求
            [self httpGetOrdersGoods];
            //请求成功发送通知
        }else{
            //加入搭配请求
            [self httpGetAddTempAssortArea];
        }
    }else{
        [self showLoadProgressViewWithMessage:@"还没有输入货品数量..." delay:2.0f];
    }
}

-(void)formTabViewLayOut{

    footViewTab =[[UIView alloc] initWithFrame:CGRectMake(0, 120, rightView.frame.size.width, 46*5+90)];
    footViewTab.backgroundColor = [UIColor orangeColor];
    [rightView addSubview:footViewTab];
    formTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, footViewTab.frame.size.width, 46*5) style:UITableViewStylePlain];
    formTableView.delegate=self;
    formTableView.dataSource=self;
    formTableView.showsVerticalScrollIndicator = NO;
    [footViewTab addSubview:formTableView];
    // 滚动条
    float h = (formTableView.frame.size.height * formTableView.frame.size.height)/formTableView.contentSize.height;
    _scrollerBarView = [[UIImageView alloc]init];
    if (formTableView.contentSize.height <= formTableView.frame.size.height) {
        
        _scrollerBarView.hidden = YES;
    }else{
        
        _scrollerBarView.hidden = NO;
    }
    _scrollerBarView.frame = CGRectMake(SIZEWidth-(SIZEWidth/3)-16 - 5, 5, 3, h);
    _scrollerBarView.backgroundColor = [UIColor grayColor];
    _scrollerBarView.tag = RSScrollerBarViewTag;
    [formTableView addSubview:_scrollerBarView];
    
    UIView * footView =[[UIView alloc] initWithFrame:CGRectMake(0,46*5, footViewTab.frame.size.width, 90)];
    footView.backgroundColor = [UIColor whiteColor];
    [footViewTab addSubview:footView];
    
     NSArray  *  seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"SizeData" fieldName:@"goodsNo" fieldValue:_goodNoString];
    NSString * priceString = @"0.00";

    if (seartchDataArray.count>0) {
        SizeData * localcont = [seartchDataArray objectAtIndex:0];
        priceString = localcont.disPrice;
        _sizeNnm = localcont.totalQty.intValue;
    }
    priceLabel3 =[[UILabel alloc] initWithFrame:CGRectMake(SIZEWidth-(SIZEWidth/3)-16-500, 10, 120, 20)];
    priceLabel3.textColor = [UIColor orangeColor];
    priceLabel3.textAlignment = NSTextAlignmentLeft;
    priceLabel3.text =[NSString stringWithFormat:@"单价:       %@",priceString];
    priceLabel3.font = [UIFont systemFontOfSize:14.0];
    [footView addSubview:priceLabel3];
    numberLabel1 =[[UILabel alloc] initWithFrame:CGRectMake(SIZEWidth-(SIZEWidth/3)-16-500, 35, 120, 20)];
    numberLabel1.textColor = [UIColor orangeColor];
    numberLabel1.textAlignment = NSTextAlignmentLeft;
    numberLabel1.text =[NSString stringWithFormat:@"数量:       %d",_sizeNnm];
    numberLabel1.font = [UIFont systemFontOfSize:14.0];
    [footView addSubview:numberLabel1];
    moneyLabel1 =[[UILabel alloc] initWithFrame:CGRectMake(SIZEWidth-(SIZEWidth/3)-16-500, 60, 180, 20)];
    moneyLabel1.textColor = [UIColor orangeColor];
    moneyLabel1.textAlignment = NSTextAlignmentLeft;
    moneyLabel1.text =[NSString stringWithFormat:@"合计￥:    %d",_sizeNnm * priceString.intValue];
    moneyLabel1.font = [UIFont systemFontOfSize:14.0];
    [footView addSubview:moneyLabel1];
    UIButton * orderButton =[[UIButton alloc] initWithFrame:CGRectMake(SIZEWidth-(SIZEWidth/3)-360, 16, 160, 40)];
    [orderButton setBackgroundImage:[UIImage imageNamed:@"btn5_2"] forState:UIControlStateNormal];
    [orderButton addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:orderButton];
//    加入搭配区
    UIButton * matchedBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZEWidth-(SIZEWidth/3)-180, 16, 160, 40)];
    [matchedBtn setBackgroundImage:[UIImage imageNamed:@"matched1"] forState:UIControlStateNormal];
    [matchedBtn addTarget:self action:@selector(matchedClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:matchedBtn];
}

#define mark 滚动条
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float h = 0.0;
    float p = 0.0;
    h = (scrollView.frame.size.height * scrollView.frame.size.height)/scrollView.contentSize.height;
    p = (scrollView.contentOffset.y + scrollView.frame.size.height)/scrollView.contentSize.height*scrollView.frame.size.height - h;
    _scrollerBarView.frame = CGRectMake(SIZEWidth-(SIZEWidth/3)-16 - 5, p + scrollView.contentOffset.y + 5, 3, h);
    formTableView.contentSize = CGSizeMake(100*(sizeArray.count+2), (colorArray.count+1)*46);
}

//左侧的商品图片/详情信息/评论
-(void)leftShopLayout{
    
    leftView =[[UIView alloc] initWithFrame:CGRectMake(5, 64, SIZEWidth/3-50, SIZEhight-64)];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftView];
    
    lineView =[[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    lineView.alpha = 1;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(leftView.mas_right).offset(0);
        make.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(1);
    }];
    
    NSArray * picturesArray = [_dataDictionary objectForKey:@"pictures"];
    _imageScrollView = [[UIScrollView alloc]init];
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.showsVerticalScrollIndicator = NO;
    _imageScrollView.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:_imageScrollView];
    [_imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.mas_left).offset(16);
        make.top.equalTo(leftView.mas_top).offset(16);
        make.width.mas_equalTo(SIZEWidth/3-82);
        make.height.mas_equalTo((SIZEWidth/3-82)*0.8);
    }];
    _scrollerViewContentView = [[UIView alloc]init];
    _scrollerViewContentView.backgroundColor = [UIColor yellowColor];
    [_imageScrollView addSubview:_scrollerViewContentView];
    [_scrollerViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(_imageScrollView);
        make.height.equalTo(_imageScrollView);
    }];
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = picturesArray.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [_pageControl addTarget:self action:@selector(changePages:) forControlEvents:UIControlEventValueChanged];
    [leftView addSubview:_pageControl];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(leftView.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        make.bottom.equalTo(_imageScrollView.mas_bottom).offset(-12);
    }];
    
    UIImageView *lastImageView;
    for (NSInteger i = 0; i < picturesArray.count;i ++) {
        
        NSDictionary * dic =[picturesArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTapClick:)];
        [imageView addGestureRecognizer:tap];
        [_scrollerViewContentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_scrollerViewContentView.mas_top);
            make.left.equalTo(_scrollerViewContentView.mas_left).offset(i*(SIZEWidth/3-82));
            make.width.mas_equalTo(SIZEWidth/3-82);
            make.height.mas_equalTo((SIZEWidth/3-82) * 0.8);
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
            
            for (UIView * view in imageView.subviews) {
                
                if ([view isKindOfClass:[SDPieLoopProgressView class]]) {
                    
                    [view removeFromSuperview];
                }
            }
        }];
        lastImageView = imageView;
    }
    if (lastImageView) {
        
        [_scrollerViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastImageView.mas_right);
        }];
    }
    
    shopbutton1 =[[UIButton alloc] initWithFrame:CGRectMake(16, (SIZEWidth/3-82)*0.8+40, (SIZEWidth/3-82)/2, 30)];
    shopbutton1.tag = 1;
    [shopbutton1 setBackgroundImage:[UIImage imageNamed:@"btn6_2"] forState:UIControlStateNormal];
    [shopbutton1 addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:shopbutton1];
    
    shopbutton2 =[[UIButton alloc] initWithFrame:CGRectMake((SIZEWidth/3-82)/2+16, (SIZEWidth/3-82)*0.8+40, (SIZEWidth/3-82)/2, 30)];
    shopbutton2.tag = 2;
    [shopbutton2 setBackgroundImage:[UIImage imageNamed:@"Shopbtn7"] forState:UIControlStateNormal];
    [shopbutton2 addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:shopbutton2];
}
-(void)rightShopLayout{
    rightView =[[UIView alloc] initWithFrame:CGRectMake(SIZEWidth/3- 20, 64, SIZEWidth-(SIZEWidth/3 - 10), SIZEhight-64)];
    rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightView];
    
    UIView * titleView =[[UIView alloc] initWithFrame:CGRectMake(0 , 0, rightView.frame.size.width, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    [rightView addSubview:titleView];
//    商品的类别
    UILabel * classLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    classLabel.textColor = [UIColor blackColor];
    classLabel.textAlignment = NSTextAlignmentLeft;
    classLabel.text = [_dataDictionary objectForKey:@"goodsname"];
    [classLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [titleView addSubview:classLabel];
//    商品的库存信息
    _stockNnm =[_dataDictionary objectForKey:@"stockNum"];
    _replenishedNum =[_dataDictionary objectForKey:@"replenishedNum"];
    _unDeliveredNum =[_dataDictionary objectForKey:@"unDeliveredNum"];
    _deliveredNum =[_dataDictionary objectForKey:@"deliveredNum"];
    UILabel * numberLabel =[[UILabel alloc] initWithFrame:CGRectMake(76, 10, 220, 35)];
    numberLabel.textColor = [UIColor grayColor];
    numberLabel.text =[NSString stringWithFormat:@"库存:%@,已订:%@,未发:%@,途中:%@",_stockNnm,_replenishedNum,_unDeliveredNum,_deliveredNum];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.font = [UIFont systemFontOfSize:12.0];
    [titleView addSubview:numberLabel];
    
    NSDictionary * dic =[_dataDictionary objectForKey:@"comment"];
    float  string = [[dic objectForKey:@"star"] floatValue];
    //评分
    UILabel * evaluationLabel =[[UILabel alloc] initWithFrame:CGRectMake(300, 0, 50, 50)];
    evaluationLabel.textColor = [UIColor blackColor];
    NSString* str =[NSString stringWithFormat:@"%0.1f",string*2];
    evaluationLabel.textAlignment = NSTextAlignmentCenter;
    NSString * starString =str;
    evaluationLabel.text =starString;
    evaluationLabel.font = [UIFont systemFontOfSize:20.0];
    [titleView addSubview:evaluationLabel];
    //评价人数
    UILabel * personalLabel =[[UILabel alloc] initWithFrame:CGRectMake(360, 35, 80, 10)];
    personalLabel.textColor = [UIColor blackColor];
    personalLabel.textAlignment = NSTextAlignmentLeft;
    personalLabel.text = [NSString stringWithFormat:@"%@人评价",[dic objectForKey:@"totalComment"]];
    personalLabel.font = [UIFont systemFontOfSize:12.0];
    [titleView addSubview:personalLabel];
    
    for (int i = 1; i<6; i++) {
        UIImageView * evaluationImage =[[UIImageView alloc] initWithFrame:CGRectMake(342+18*i, 15, 15, 15)];
        int m =ceil(string);//向上取整数
        int n =string;//向下取整数
        int a =(string-n)*10;

            if (i<m)
            {
                evaluationImage.image =[UIImage imageNamed:@"stars10"];
            }
            else if (i>m)//空心
            {
                evaluationImage.image =[UIImage imageNamed:@"stars0"];
            }
            else
            {
                if (m!=n)
                {
                    evaluationImage.image =[UIImage imageNamed:[NSString stringWithFormat:@"stars0%d",a]];
                }
                else{
                    evaluationImage.image =[UIImage imageNamed:@"stars10"];
                }
           }
        
        [titleView addSubview:evaluationImage];
}
    
    
    UIButton * evaluationButton =[[UIButton alloc] initWithFrame:CGRectMake(titleView.frame.size.width-166, 10, 70, 35)];
    evaluationButton.tag = 30001;
    [evaluationButton setBackgroundImage:[UIImage imageNamed:@"pingjia"] forState:UIControlStateNormal];
    NSString * userString;
    NSMutableArray * userArray =[[NSMutableArray alloc] init];
    if (rowsArray.count>0) {
        
        for (NSDictionary * dictionary in rowsArray) {
            userString = [dictionary objectForKey:@"userNo"];
            [userArray addObject:userString];

            }
        }
         if ([userArray containsObject:[PublicKit getPlistParameter:NameTextString]]) {
          [evaluationButton setBackgroundImage:[UIImage imageNamed:@"passPingJia"] forState:UIControlStateNormal];
         }else{
           
         }
    [evaluationButton addTarget:self action:@selector(evaluationButtonView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:evaluationButton];

    UIButton * detailsButton =[[UIButton alloc] initWithFrame:CGRectMake(titleView.frame.size.width-86, 10, 70, 35)];
    [detailsButton setBackgroundImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateNormal];
    [detailsButton addTarget:self action:@selector(detailsButtonView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:detailsButton];
    
    // 价格和起批量
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 50, rightView.frame.size.width, 70)];
    view.backgroundColor =[UIColor colorWithHexString:@"#f0f7fd"];
    [rightView addSubview:view];
    
    // 价格
    UILabel * priceLabel1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    priceLabel1.backgroundColor = [UIColor clearColor];
    priceLabel1.textColor = [UIColor grayColor];
    priceLabel1.textAlignment = NSTextAlignmentLeft;
    priceLabel1.text =@"价格";
    priceLabel1.font = [UIFont systemFontOfSize:14.0];
    [view addSubview:priceLabel1];
    // 起批量
    UILabel * lowerLabel1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 50, 20)];
    lowerLabel1.textColor = [UIColor grayColor];
    lowerLabel1.backgroundColor = [UIColor clearColor];
    lowerLabel1.textAlignment = NSTextAlignmentLeft;
    lowerLabel1.text =@"起批量";
    lowerLabel1.font = [UIFont systemFontOfSize:14.0];
    [view addSubview:lowerLabel1];
    
    // 获取起批量的数据
    NSArray *orderGoodsArray = _dataDictionary[@"priceranges"];
    UIScrollView *orderGoodsScrollView = [[UIScrollView alloc]init];
    orderGoodsScrollView.delegate = self;
    orderGoodsScrollView.pagingEnabled = NO;
    orderGoodsScrollView.backgroundColor = [UIColor clearColor];
    [view addSubview:orderGoodsScrollView];
    [orderGoodsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceLabel1.mas_right).offset(5);
        make.top.bottom.right.equalTo(view);
    }];
    
    // contensizeView
    UIView *containView = [[UIView alloc]init];
    containView.backgroundColor = [UIColor clearColor];
    [orderGoodsScrollView addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(orderGoodsScrollView);
        make.height.equalTo(orderGoodsScrollView);
    }];
    UILabel *lastLabel;
    for (NSInteger i = 0; i < orderGoodsArray.count; i ++) {
         NSDictionary *dic = orderGoodsArray[i];
        UILabel * lowerLabel2 =[[UILabel alloc] init];
        lowerLabel2.textColor = [UIColor blackColor];
        lowerLabel2.backgroundColor = [UIColor clearColor];
        lowerLabel2.textAlignment = NSTextAlignmentLeft;
        lowerLabel2.text =[NSString stringWithFormat:@"%@ ~ %@件",[dic objectForKey:@"lowerlimit"],[dic objectForKey:@"upperlimit"]];
        lowerLabel2.font = [UIFont systemFontOfSize:14.0];
        [containView addSubview:lowerLabel2];
        [lowerLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(containView.mas_top).offset(40);
            make.height.mas_equalTo(20);
            make.left.equalTo(lastLabel?lastLabel.mas_right:containView.mas_left).offset(10);
        }];
        
       
        UILabel * priceLabel2 =[[UILabel alloc] init];
        priceLabel2.textColor = [UIColor greenColor];
        priceLabel2.backgroundColor = [UIColor clearColor];
        priceLabel2.textAlignment = NSTextAlignmentCenter;
        priceLabel2.text =[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"prcie"]];
        priceLabel2.font = [UIFont systemFontOfSize:18.0];
        [containView addSubview:priceLabel2];
        [priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(containView.mas_top).offset(10);
            make.height.mas_equalTo(20);
            make.left.equalTo(lastLabel?lastLabel.mas_right:containView.mas_left).offset(10);
            make.width.equalTo(lowerLabel2.mas_width);
        }];
        
        lastLabel = lowerLabel2;
    }
    if (lastLabel) {
        
        [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.right.equalTo(lastLabel.mas_right).offset(10);
        }];
    }
}
-(void)footLayout{
    
    UIView *matchView = [[UIView alloc]initWithFrame:CGRectMake(0, 440, rightView.frame.size.width, rightView.frame.size.height - 440)];
    matchView.backgroundColor = [UIColor whiteColor];
    [rightView addSubview:matchView];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake((SIZEhight- 504)/2*1.2, (matchView.frame.size.height)/2);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    shopCellView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, matchView.frame.size.width, (SIZEhight-504)/2)collectionViewLayout:layout];
    shopCellView.delegate= self;
    shopCellView.dataSource= self;
    shopCellView.backgroundColor = [UIColor whiteColor];
    NSArray * arrangearray = [_dataDictionary objectForKey:@"arrangeInPairs"];
    shopCellView.contentSize = CGSizeMake((SIZEhight-504)/2*1.2*arrangearray.count, (SIZEhight-504)/2);
    [matchView addSubview:shopCellView];
    
    [shopCellView registerNib:[UINib nibWithNibName:@"ShopViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    UIImageView * dapeImage = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 5, 60, 30)];
    dapeImage.image = [UIImage imageNamed:@"dapeImage"];
    [matchView addSubview:dapeImage];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc]init];
    layout2.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout2.itemSize = CGSizeMake((rightView.frame.size.height - 440)/2*1.2, (rightView.frame.size.height - 440)/2);
    layout2.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    substituteCellView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,matchView.frame.size.height/2, matchView.frame.size.width, matchView.frame.size.height/2)collectionViewLayout:layout2];
    substituteCellView.delegate= self;
    substituteCellView.dataSource=self;
    substituteCellView.backgroundColor = [UIColor whiteColor];
  
    
    NSArray * subarray =[_dataDictionary objectForKey:@"substitutes"];
    substituteCellView.contentSize = CGSizeMake((SIZEhight-504)/2*1.2*subarray.count, (SIZEhight-504)/2);
    
    [matchView addSubview:substituteCellView];
    [substituteCellView registerNib:[UINib nibWithNibName:@"SubstitutesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"substitutesCell"];
    UIImageView * tidaiImage = [[UIImageView alloc] initWithFrame:CGRectMake(-5, matchView.frame.size.height/2 + 5, 60, 30)];
    tidaiImage.image = [UIImage imageNamed:@"tidaImage"];
    
    [matchView addSubview:tidaiImage];
}

//评价跳转
-(void)evaluationButtonView{
      NSString * userString;
    NSMutableArray * userArray =[[NSMutableArray alloc] init];
    if (rowsArray.count>0) {
        for (NSDictionary * dictionary in rowsArray) {
            userString = [dictionary objectForKey:@"userNo"];
            [userArray addObject:userString];
            
        }
    }
    if ([userArray containsObject:[PublicKit getPlistParameter:NameTextString]]) {
        
    }else{
        RSAddCommentViewController * classView =[[RSAddCommentViewController alloc] init];
        classView.goodNoString = _goodNoString;
        classView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:classView animated:YES];
    }
}
//scrollView图片跳转到详情
-(void)imageViewTapClick:(UITapGestureRecognizer * )tap{
    
    ProductDetailsViewController * detailView =[[ProductDetailsViewController alloc] init];
    detailView.hidesBottomBarWhenPushed = YES;
    detailView.detailDictionary = _dataDictionary;
    detailView.currentNavigationController = self.currentNavigationController;
    [self.navigationController pushViewController:detailView animated:YES];
}


//明细跳转
-(void)detailsButtonView{
    
    if (self.coverView) {
        self.coverView.hidden = NO;
    }
    else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *coverView = [[UIView alloc]init];
        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
        coverView.frame = window.bounds;
        coverView.alpha = 1.0;
        [window addSubview:coverView];
        self.coverView  = coverView;
  
        accountView =[[UIView alloc] initWithFrame:CGRectMake((self.coverView.frame.size.width-800)/2, (self.coverView.frame.size.height-500)/2, 800, 500)];
        accountView.backgroundColor = [UIColor whiteColor];
        [self.coverView addSubview:accountView];
    
        UIImageView * backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 60, 600, 50)];
        backImageView.image = [UIImage imageNamed:@"accountImage1"];
        [accountView addSubview:backImageView];
    
        UIImageView * backgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, accountView.frame.size.width, 50)];
        backgroundImageView.image = [UIImage imageNamed:@"top"];
        [accountView addSubview:backgroundImageView];
    
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, accountView.frame.size.width, 50)];
        label.backgroundColor =[UIColor greenColor];
        label.text = @"明细";
        label.textAlignment = NSTextAlignmentCenter;
        [accountView addSubview:label];
    
        UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(accountView.frame.size.width-50, 0, 50, 50)];
        [button setBackgroundImage:[UIImage imageNamed:@"view退出按钮点击"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(accountBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [accountView addSubview:button];
    
        [self amountSizeLabelLayOut];
    
        button1 =[[UIButton alloc] init];
        button1.frame = CGRectMake(100, 60, 150, 50);
        [button1 setTitle:[NSString stringWithFormat:@"库存(%@)",_stockNnm] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:13.0];
        button1.backgroundColor = [UIColor orangeColor];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(btnTableClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag = 1;
        [accountView addSubview: button1];
        button2 =[[UIButton alloc] init];
        button2.frame = CGRectMake(250, 60, 150, 50);
        button2.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button2 setTitle:[NSString stringWithFormat:@"已订(%@)",_replenishedNum] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(btnTableClick:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag =2;
        [accountView addSubview: button2];
        button3 =[[UIButton alloc] init];
        button3.frame = CGRectMake(400, 60, 150, 50);
        button3.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button3 setTitle:[NSString stringWithFormat:@"未发(%@)",_unDeliveredNum] forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(btnTableClick:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag =3;
        [accountView addSubview: button3];
        button4 =[[UIButton alloc] init];
        button4.frame = CGRectMake(550, 60, 150, 50);
        button4.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button4 setTitle:[NSString stringWithFormat:@"在途(%@)",_deliveredNum] forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(btnTableClick:) forControlEvents:UIControlEventTouchUpInside];
        button4.tag =4;
        [accountView addSubview: button4];
    
        _accountArray = [_accountDictionary objectForKey:@"stock"];
        accountTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 120, accountView.frame.size.width, 210) style:UITableViewStylePlain];
        accountTableView.delegate = self;
        accountTableView.dataSource = self;
        [accountView addSubview:accountTableView];
    }
}


-(void)accountBackBtnClick{
    
    self.coverView.hidden = YES;
}
-(void)btnTableClick:(UIButton * )sender{
    
    switch (sender.tag) {
        case 1:{
            button2.backgroundColor = [UIColor clearColor];
            button3.backgroundColor = [UIColor clearColor];
            button4.backgroundColor = [UIColor clearColor];
            button1.backgroundColor = [UIColor orangeColor];
            [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button4 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _accountArray = [_accountDictionary objectForKey:@"stock"];
            
            [amountLabeiView removeFromSuperview];
            [self amountSizeLabelLayOut];
            [accountTableView reloadData];
            
        }
            break;
        case 2:{
            button1.backgroundColor = [UIColor clearColor];
            button3.backgroundColor = [UIColor clearColor];
            button4.backgroundColor = [UIColor clearColor];
            button2.backgroundColor = [UIColor orangeColor];
            [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button4 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
           _accountArray = [_accountDictionary objectForKey:@"all"];
            [amountLabeiView removeFromSuperview];
            [self amountSizeLabelLayOut];
            [accountTableView reloadData];
            
        }
            break;
        case 3:{
            button1.backgroundColor = [UIColor clearColor];
            button2.backgroundColor = [UIColor clearColor];
            button4.backgroundColor = [UIColor clearColor];
            button3.backgroundColor = [UIColor orangeColor];
            [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button4 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _accountArray = [_accountDictionary objectForKey:@"unDelivered"];
            [amountLabeiView removeFromSuperview];
            [self amountSizeLabelLayOut];
            [accountTableView reloadData];
            
        }
            break;
        case 4:{
            button1.backgroundColor = [UIColor clearColor];
            button2.backgroundColor = [UIColor clearColor];
            button3.backgroundColor = [UIColor clearColor];
            button4.backgroundColor = [UIColor orangeColor];
            [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _accountArray = [_accountDictionary objectForKey:@"delivered"];
            [amountLabeiView removeFromSuperview];
            [self amountSizeLabelLayOut];
            [accountTableView reloadData];
        }
            break;
        default:
            break;
    }
}

-(void)amountSizeLabelLayOut{
    
    amountLabeiView =[[UIView alloc] initWithFrame:CGRectMake(0, accountView.frame.size.height-60, accountView.frame.size.width, 50)];
    amountLabeiView.backgroundColor = [UIColor whiteColor];
    [accountView addSubview:amountLabeiView];
    
    UILabel * amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 50, 30)];
    amountLabel.text = @"合计";
    amountLabel.textColor = [UIColor blackColor];
    amountLabel.font = [UIFont systemFontOfSize:14.0];
    [amountLabeiView addSubview:amountLabel];
    
    NSArray * array =[_accountDictionary objectForKey:@"size"];
    if (array.count >0 ) {
        for (int i = 0; i<array.count; i++) {
            int amountSize = 0;
            for (int j =0; j<_accountArray.count; j++) {
                
                NSDictionary * dic = [_accountArray objectAtIndex:j];
                
                NSString* string = [dic objectForKey:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]]];
                amountSize = amountSize + string.intValue;
            }
            UILabel * sizeLabel =[[UILabel alloc] initWithFrame:CGRectMake(90+90*i, 10, 90, 30)];
            sizeLabel.textAlignment = NSTextAlignmentCenter;
            sizeLabel.font =[UIFont systemFontOfSize:12.0];
            
            
            sizeLabel.text = [NSString stringWithFormat:@"%d",amountSize];
            sizeLabel.textColor =[UIColor blackColor];
            [amountLabArray addObject:sizeLabel];
            [amountLabeiView addSubview:sizeLabel];
        }
    }
}

//商品详情和商品评价的button
-(void)changeView:(UIButton * )sender{

    if (sender.tag == 1) {
        [shopbutton1 setBackgroundImage:[UIImage imageNamed:@"btn6_2"] forState:UIControlStateNormal];
        [shopbutton2 setBackgroundImage:[UIImage imageNamed:@"Shopbtn7"] forState:UIControlStateNormal];
        if (goodsShopview) {
            
            [self.commentView removeFromSuperview];
            [goodsShopview removeFromSuperview];
            goodsShopview = nil;
            self.commentView = nil;
        }
        [self shopBtnClick];
        
    } else {
        
        [shopbutton1 setBackgroundImage:[UIImage imageNamed:@"btn6"] forState:UIControlStateNormal];
        [shopbutton2 setBackgroundImage:[UIImage imageNamed:@"btn7_2"] forState:UIControlStateNormal];
        
        if (goodsShopview) {
            
            [self.commentView removeFromSuperview];
            [goodsShopview removeFromSuperview];
            goodsShopview = nil;
            self.commentView = nil;
        }
        
        goodsShopview =[[UIView alloc] initWithFrame:CGRectMake(5, (SIZEWidth/3-82)*0.8+150, SIZEWidth/3-50, SIZEhight-(SIZEWidth/3-82)*0.8-150)];
        goodsShopview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:goodsShopview];
        _commentView = [[RSProductCommentView alloc]init];
        _commentView.backgroundColor = [UIColor whiteColor];
        [goodsShopview addSubview:_commentView];
        [_commentView mas_makeConstraints:^(MASConstraintMaker *make){

            make.left.top.right.bottom.equalTo(goodsShopview);
        }];
        if (_commentView) {
            
            _commentView.dataArray = _commentModelArray;
        }
    }
}

//商品详情按钮的信息
-(void)shopBtnClick{
    if (goodsShopview) {
        
        [goodsShopview removeFromSuperview];
        goodsShopview = nil;
    }
    goodsShopview =[[UIView alloc] initWithFrame:CGRectMake(5, (SIZEWidth/3-82)*0.8+150, SIZEWidth/3-50, SIZEhight-(SIZEWidth/3-82)*0.8-150)];
    goodsShopview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:goodsShopview];
    NSString * goodsNoString =[_dataDictionary objectForKey:@"goodsno"];
    NSString * brandString =[_dataDictionary objectForKey:@"brand"];
    NSString * rangeString =[_dataDictionary objectForKey:@"range"];
    NSString * categoryString =[_dataDictionary objectForKey:@"category"];
    NSString * patternString =[_dataDictionary objectForKey:@"pattern"];
    NSString * seasonString =[_dataDictionary objectForKey:@"season"];
    NSString * sexString = [_dataDictionary objectForKey:@"sex"];
    NSString * materialString =[_dataDictionary objectForKey:@"material"];
    UILabel * goodsNoLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 40, SIZEWidth/3-100, 40)];
    goodsNoLabel.textColor = [UIColor blackColor];
    goodsNoLabel.textAlignment = NSTextAlignmentLeft;
    goodsNoLabel.text =[NSString stringWithFormat:@"货号:     %@",goodsNoString];
    goodsNoLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:goodsNoLabel];
        
    UILabel * brandLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 80, SIZEWidth/3-100, 40)];
    brandLabel.textColor = [UIColor blackColor];
    brandLabel.textAlignment = NSTextAlignmentLeft;
    brandLabel.text =[NSString stringWithFormat:@"品牌:     %@",brandString];
    brandLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:brandLabel];
        
    UILabel * rangeLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 120, SIZEWidth/3-100, 40)];
    rangeLabel.textColor = [UIColor blackColor];
    rangeLabel.textAlignment = NSTextAlignmentLeft;
    rangeLabel.text = [NSString stringWithFormat:@"系列:     %@",rangeString];
    rangeLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:rangeLabel];
        
    UILabel * categoryLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 160, SIZEWidth/3-100, 40)];
    categoryLabel.textColor = [UIColor blackColor];
    categoryLabel.textAlignment = NSTextAlignmentLeft;
    categoryLabel.text = [NSString stringWithFormat:@"类别:     %@",categoryString];
    categoryLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:categoryLabel];
        
    UILabel * patternLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 200, SIZEWidth/3-100, 40)];
    patternLabel.textColor = [UIColor blackColor];
    patternLabel.textAlignment = NSTextAlignmentLeft;
    patternLabel.text = [NSString stringWithFormat:@"款型:     %@",patternString];
    patternLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:patternLabel];
        
    UILabel * seasonLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 240, SIZEWidth/3-100, 40)];
    seasonLabel.textColor = [UIColor blackColor];
    seasonLabel.textAlignment = NSTextAlignmentLeft;
    seasonLabel.text = [NSString stringWithFormat:@"季节:     %@",seasonString];
    seasonLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:seasonLabel];
        
    UILabel * sexLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 280, SIZEWidth/3-100, 40)];
    sexLabel.textColor = [UIColor blackColor];
    sexLabel.textAlignment = NSTextAlignmentLeft;
    sexLabel.text = [NSString stringWithFormat:@"性别:     %@",sexString];
    sexLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:sexLabel];
        
    UILabel * materialLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 320, SIZEWidth/3-100, 40)];
    materialLabel.textColor = [UIColor blackColor];
    materialLabel.textAlignment = NSTextAlignmentLeft;
    materialLabel.text = [NSString stringWithFormat:@"面料:     %@",materialString];
    materialLabel.font = [UIFont systemFontOfSize:16.0];
    [goodsShopview addSubview:materialLabel];

}

- (void)changePages:(UIPageControl *)pageCon
{
    
    [_imageScrollView setContentOffset:CGPointMake(pageCon.currentPage * (SIZEWidth/3-82), 0) animated:YES];
}
#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/(SIZEWidth/3-82);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * array;
    if (collectionView == shopCellView) {
        array = [_dataDictionary objectForKey:@"arrangeInPairs"];
        return array.count;
    }else  {
        array =[_dataDictionary objectForKey:@"substitutes"];
        return array.count;

    }
}
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == shopCellView) {
        return CGSizeMake((SIZEhight-504)/2*1.2, (SIZEhight-504)/2);
    } else {
        return CGSizeMake((SIZEhight-504)/2*1.2, (SIZEhight-504)/2);
    }
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == shopCellView) {
        return 0.1f;
    } else {
        return 0.1f;
    }
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView == shopCellView) {
        return UIEdgeInsetsMake(0,0,0,0.1);
    } else {
        return UIEdgeInsetsMake(0,0,0,0.1);
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array;
    NSDictionary * dic;
    if (collectionView == shopCellView) {
        ShopViewCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        array = [_dataDictionary objectForKey:@"arrangeInPairs"];
        dic =[array objectAtIndex:indexPath.item];
        __block SDPieLoopProgressView *progressView;
        [cell.shopImage sd_setImageWithURL:[dic objectForKey:@"mainPictureUrl"]
                          placeholderImage:[UIImage imageNamed:@"err"]
                                   options:SDWebImageRetryFailed
                                  progress:^(NSInteger receivedSize, NSInteger expectedSize){
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          if (progressView == nil) {
                                              
                                              progressView = [[SDPieLoopProgressView alloc]init];
                                              progressView.frame = CGRectMake(0, 0, 50, 50);
                                              progressView.center = cell.shopImage.center;
                                              [cell.shopImage addSubview:progressView];
                                          }
                                          progressView.progress = (float) receivedSize/ (float)expectedSize;
                                      });
                                  }completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                                      for (UIView * view in cell.shopImage.subviews) {
                                          
                                          if ([view isKindOfClass:[SDPieLoopProgressView class]]) {
                                              
                                              [view removeFromSuperview];
                                          }
                                      }
                                  }];
        NSString * priceString =[NSString stringWithFormat:@"%@   ￥%0.2f",[dic objectForKey:@"goodsName"],[[dic objectForKey:@"dpPrice"] floatValue]];
        cell.shopPriceLabel.text = priceString;
        cell.shopImage.contentMode = UIViewContentModeScaleAspectFit;
        return cell;
    } else {
        SubstitutesCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"substitutesCell" forIndexPath:indexPath];
        array =[_dataDictionary objectForKey:@"substitutes"];
        dic =[array objectAtIndex:indexPath.item];
        [cell.shopImage sd_setImageWithURL:[dic objectForKey:@"mainPictureUrl"]];
        NSString * priceString =[NSString stringWithFormat:@"%@   ￥%0.2f",[dic objectForKey:@"goodsName"],[[dic objectForKey:@"dpPrice"] floatValue]];
        cell.shopPriceLabel.text = priceString;
        cell.shopImage.contentMode = UIViewContentModeScaleAspectFit;
        
        
        return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    
    NSArray * array;
    NSDictionary * dic;
    if ( collectionView ==shopCellView) {
        array = [_dataDictionary objectForKey:@"arrangeInPairs"];
        dic =[array objectAtIndex:indexPath.item];
        _goodNoString = [dic objectForKey:@"goodsNo"];
        _disPriceString =[NSString stringWithFormat:@"%@",[dic objectForKey:@"dpPrice"]];
        _sizeNnm = 0;
        numberLabel1.text =@"数量:    0";
        [footViewTab removeFromSuperview];
        numberColorLabel  = nil;
        [textfiledArray removeAllObjects];
        [labelTextArray removeAllObjects];
        
        [self httpGetgoodsinfo];
        [self httpGetComments];
        [formTableView reloadData];
        [accountTableView reloadData];

        
    }else{
        array =[_dataDictionary objectForKey:@"substitutes"];
        dic =[array objectAtIndex:indexPath.item];
        _goodNoString = [dic objectForKey:@"goodsNo"];
        _sizeNnm =0;
        numberLabel1.text =@"数量:      0";
        [labelTextArray removeAllObjects];
        [textfiledArray removeAllObjects];
        [footViewTab removeFromSuperview];
         numberColorLabel = nil;
        [self httpGetgoodsinfo];
        [self httpGetComments];
        [accountTableView reloadData];
        [formTableView reloadData];
        
    }
    
}

//获取商品的信息
-(void)httpGetgoodsinfo{
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNo =[PublicKit getPlistParameter:NameTextString];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    NSString * sizeStyle =@"HP";
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/goods/getgoodsinfo/%@/%@/%@/%@",serve,userNo,_goodNoString,sizeStyle,channelCode];
    [self loadProgressViewIsShow:YES];
    [[RSNetworkManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        _dataDictionary =[dic objectForKey:@"data"];
        sizeArray =[_dataDictionary objectForKey:@"sizes"];
        NSDictionary * diction =[sizeArray objectAtIndex:0];
        longArray = [diction objectForKey:@"longs"];
        NSDictionary * imageDic =[longArray objectAtIndex:0];
        colorArray =[imageDic objectForKey:@"colors"];
        [self leftShopLayout];
        [self rightShopLayout];
        [self footLayout];
        [footViewTab removeFromSuperview];
        
        [self formTabViewLayOut];
        [self shopBtnClick];
        [self httpGetGoodsDetailNums];
        [formTableView reloadData];
        [accountTableView reloadData];
        [self loadProgressViewIsShow:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadProgressViewIsShow:NO];
    }];
}
//商品评价的请求
-(void)httpGetComments {
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/goods/getComments",serve];

    NSDictionary *parameters = @{@"pageIndex": @"1",@"pageSize":@"10",@"goodsId":_goodNoString};
    [self loadProgressViewIsShow:NO];
    [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _commentModelArray = [NSMutableArray array];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        rowsArray = [dic objectForKey:@"rows"];
        for (NSDictionary *dic in rowsArray) {
            
            RSCommentModel *model = [[RSCommentModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_commentModelArray addObject:model];
        }
        [evaluTableView reloadData];
        [self loadProgressViewIsShow:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self loadProgressViewIsShow:NO];
    }];
    
}

//商品明细的请求
-(void)httpGetGoodsDetailNums{

    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    NSString * goodsNoString =[_dataDictionary objectForKey:@"goodsno"];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/goods/getGoodsDetailNums/%@/%@",serve,channelCode,goodsNoString];
    
    [self loadProgressViewIsShow:YES];
    [[RSNetworkManager sharedManager] GET: urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        _accountDictionary =[dic objectForKey:@"data"];
        _accountArray = [_accountDictionary objectForKey:@"stock"];
        [accountTableView reloadData];
        [self loadProgressViewIsShow:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadProgressViewIsShow:NO];
    }];
}
//商品订货的请求

-(void)httpGetOrdersGoods{
    
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    NSString * userNOString =[PublicKit getPlistParameter:NameTextString];
    
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/ordersgoods/ceateorder",serve];
    NSMutableDictionary * parmdic = [[NSMutableDictionary alloc] init];

    ProductData * productLocal = [[ProductData alloc] init];
    NSMutableArray * seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:@"goodsNo" fieldValue:_goodNoString];
    productLocal = [seartchDataArray objectAtIndex:0];
    NSDictionary * goodsInfoDictionary =  [PublicKit saveLocaDicShop:productLocal];
    parmdic = [PublicKit saveLocaArrayShop:productLocal setDictionary:goodsInfoDictionary];
    
    [parmdic setObject:_mainPictureUrlString forKey:@"mainPictureUrl"];
    [parmdic setObject:channelCode forKey:@"customer_id"];
    [parmdic setObject:userNOString forKey:@"userNo"];
    
    [[RSNetworkManager sharedManager] POST:urlString parameters:parmdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingCarAccountNoti" object:self];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"货品添加成功，如要提交订单请从右上角进入补货池" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [self loadProgressViewIsShow:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadProgressViewIsShow:NO];
    }];
}

//加入搭配区的请求

-(void)httpGetAddTempAssortArea{
  
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    NSString * userNOString =[PublicKit getPlistParameter:NameTextString];
    NSString * maxstockString =[PublicKit getPlistParameter:Maxstock];
    
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/assort/addTempAssortArea",serve];
    
//    NSString * urlString =[NSString stringWithFormat:@"http://192.168.9.175:8088/rs/assort/addTempAssortArea"];//老宋的服务器
    
    NSMutableDictionary * parmdic = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * assortPlanDic = [[NSMutableDictionary alloc] init];
    NSMutableArray * goodassortArray = [[NSMutableArray alloc] init];
    NSMutableDictionary * goodassortDic = [[NSMutableDictionary alloc] init];
    
    ProductData * productLocal = [[ProductData alloc] init];
    NSMutableArray * seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"MatchedProduct" fieldName:@"goodsNo" fieldValue:_goodNoString];
    productLocal = [seartchDataArray objectAtIndex:0];
    NSMutableDictionary * goodsInfoDictionary =  [PublicKit saveMatchedLocaDicShop:productLocal];
    NSMutableArray * otherInfoDictionary = [PublicKit saveMatchedLocaArrayShop:productLocal setDictionary:goodsInfoDictionary setMainPicture:_mainPictureUrlString];
    
    NSString * otherString = [PublicKit toJsonString:otherInfoDictionary error:nil];
    
    [assortPlanDic setObject:@"临时方案" forKey:@"pname"];
    [assortPlanDic setObject:userNOString forKey:@"userNo"];
    [assortPlanDic setObject:@"" forKey:@"checkdate"];
    [assortPlanDic setObject:@"-1" forKey:@"status"];
    [assortPlanDic setObject:@"-1" forKey:@"share"];
    [assortPlanDic setObject:@"0" forKey:@"type"];
    [assortPlanDic setObject:@"临时方案" forKey:@"remark"];
    
    [goodassortDic setObject:_goodNoString forKey:@"goodNo"];
    [goodassortDic setObject:channelCode forKey:@"customerId"];
    [goodassortDic setObject:maxstockString forKey:@"limitOrders"];
    
    [goodassortDic setObject:otherString forKey:@"otherinfo"];
    [goodassortDic setObject:@"true" forKey:@"listeningStock"];
    [goodassortDic setObject:@"" forKey:@"div"];
    [goodassortDic setObject:@"" forKey:@"locations"];
    [goodassortDic setObject:@"" forKey:@"circu"];
    [goodassortDic setObject:@"" forKey:@"pull"];
    [goodassortDic setObject:@"" forKey:@"translation"];
    
    [goodassortArray addObject:goodassortDic];
    [parmdic setObject:assortPlanDic forKey:@"assortPlan"];
    [parmdic setObject:goodassortArray forKey:@"goodassort"];
    
    [[RSNetworkManager sharedManager] POST:urlString parameters:parmdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

@end
