//
//  RSSumReportSinglePieChartView.m
//  Srms
//
//  Created by RegentSoft on 16/7/21.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportSinglePieChartView.h"
#import "Srms-Bridging-Header.h"
#import "Srms-Swift.h"
// 模型
#import "RSSumReportBrandModel.h"
#import "RSSumReportCategoryModel.h"
#import "RSSumReportPatternModel.h"
#import "RSSumReportRangeModel.h"
#import "RSSumReportSeasonModel.h"
#import "RSSumReportYearModel.h"

#define BgColor [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1]

@interface RSSumReportSinglePieChartView()

@property (nonatomic, strong) PieChartView *pieChartView;
@property (nonatomic, strong) PieChartData *data;
@property (nonatomic, copy) NSString *nameStr;

@end

@implementation RSSumReportSinglePieChartView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
//        [self createUI];
    }
    return self;
}
- (void) createUI{
    
    //创建饼状图
    self.pieChartView = [[PieChartView alloc] init];
    self.pieChartView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.mas_equalTo(self);
        make.center.mas_equalTo(self);
    }];
    //基本样式
    [self.pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
    self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    self.pieChartView.drawSliceTextEnabled = NO;//是否显示区块文本
    //空心饼状图样式
    self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.7;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 1;//0.52;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    //实心饼状图样式
    //    self.pieChartView.drawHoleEnabled = NO;
    //饼状图中间描述
    if (self.pieChartView.isDrawHoleEnabled == YES) {
        self.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
        //普通文本
//                self.pieChartView.centerText = _nameStr;//中间文字
        //富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:_nameStr];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                    NSForegroundColorAttributeName: [UIColor blackColor]}
                            range:NSMakeRange(0, centerText.length)];
        self.pieChartView.centerAttributedText = centerText;
    }
    //饼状图描述
    self.pieChartView.descriptionText = @"";
    self.pieChartView.descriptionFont = [UIFont systemFontOfSize:10];
    self.pieChartView.descriptionTextColor = [UIColor grayColor];
    //饼状图图例
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    self.pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 12;//图示大小
}


- (void)setPieChartViewDataWithModelArray:(NSArray *)modelArray{
    id model = [modelArray firstObject];
    NSMutableArray *xVals = [[NSMutableArray alloc] init];;
    NSMutableArray *yVals = [[NSMutableArray alloc] init];;
    if ([model isKindOfClass:[RSSumReportBrandModel class]]) {
        
        _nameStr = @"品牌";
        for (int i = 0; i <  modelArray.count; i++) {
            RSSumReportBrandModel *brandModel = modelArray[i];
            //每个区块的名称或描述
            NSString *title = [NSString stringWithFormat:@"%@", brandModel.category];
            [xVals addObject:title];
            
            //每个区块的数据
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[brandModel.number integerValue] xIndex:i];
            [yVals addObject:entry];
        }
    }else if ([model isKindOfClass:[RSSumReportCategoryModel class]]){
    
        _nameStr = @"类别";
        for (int i = 0; i <  modelArray.count; i++) {
            RSSumReportCategoryModel *categoryModel = modelArray[i];
            //每个区块的名称或描述
            NSString *title = [NSString stringWithFormat:@"%@", categoryModel.category];
            [xVals addObject:title];
            
            //每个区块的数据
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[categoryModel.number integerValue] xIndex:i];
            [yVals addObject:entry];
        }
    }
    else if ([model isKindOfClass:[RSSumReportPatternModel class]]){
        
        _nameStr = @"款型";
        for (int i = 0; i <  modelArray.count; i++) {
            RSSumReportPatternModel *patternModel = modelArray[i];
            //每个区块的名称或描述
            NSString *title = [NSString stringWithFormat:@"%@", patternModel.category];
            [xVals addObject:title];
            
            //每个区块的数据
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[patternModel.number integerValue] xIndex:i];
            [yVals addObject:entry];
        }
    }
    else if ([model isKindOfClass:[RSSumReportRangeModel class]]){
        
        _nameStr = @"系列";
        for (int i = 0; i <  modelArray.count; i++) {
            RSSumReportRangeModel *rangeModel = modelArray[i];
            //每个区块的名称或描述
            NSString *title = [NSString stringWithFormat:@"%@", rangeModel.category];
            [xVals addObject:title];
            
            //每个区块的数据
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[rangeModel.number integerValue] xIndex:i];
            [yVals addObject:entry];
        }
    }
    else if ([model isKindOfClass:[RSSumReportSeasonModel class]]){
        
        _nameStr = @"季节";
        for (int i = 0; i <  modelArray.count; i++) {
            RSSumReportSeasonModel *seasonModel = modelArray[i];
            //每个区块的名称或描述
            NSString *title = [NSString stringWithFormat:@"%@", seasonModel.category];
            [xVals addObject:title];
            
            //每个区块的数据
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[seasonModel.number integerValue] xIndex:i];
            [yVals addObject:entry];
        }
     }else if ([model isKindOfClass:[RSSumReportYearModel class]]){
        
        _nameStr = @"年份";
         for (int i = 0; i <  modelArray.count; i++) {
             RSSumReportYearModel *yearModel = modelArray[i];
             //每个区块的名称或描述
             NSString *title = [NSString stringWithFormat:@"%@", yearModel.category];
             [xVals addObject:title];
             
             //每个区块的数据
             BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[yearModel.number integerValue] xIndex:i];
             [yVals addObject:entry];
         }
    }
    [self createUI];
    [self loadPieChartViewWithDataEntryArray:yVals zoneName:xVals];
}

- (void) loadPieChartViewWithDataEntryArray:(NSMutableArray *)yVals  zoneName:(NSMutableArray *)xVals{
    //dataSet
    PieChartDataSet *dataSet = [self pieChartDataSetWithArray:yVals];
    self.pieChartView.data = [self setDataWithPieChartData:dataSet array:xVals];
    //设置动画效果
    [self.pieChartView animateWithXAxisDuration:1.0f easingOption:ChartEasingOptionEaseOutExpo];
}

- (PieChartData *)setDataWithPieChartData:(PieChartDataSet *)dataSet array:(NSMutableArray *)xVals{
    
    //data
    PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 0;//小数位数
    formatter.multiplier = @1.f;
    [data setValueFormatter:formatter];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    return data;
}

- (PieChartDataSet *)pieChartDataSetWithArray:(NSMutableArray *)yVals{
    
    //dataSet
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithYVals:yVals label:@""];
    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    dataSet.colors = colors;//区块颜色
    dataSet.sliceSpace = 1;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    //数据与区块之间的用于指示的折线样式
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色
    return dataSet;
}

@end
