//
//  MatchedShopViewController.m
//  Srms
//
//  Created by ohm on 16/8/12.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "MatchedShopViewController.h"
#import<JavaScriptCore/JavaScriptCore.h>
@interface MatchedShopViewController ()<UIScrollViewDelegate>{
  
    UIWebView *webView;
    NSString * userName;
    NSString * serceUrlString;
}

@end
//static int ScreenshotIndex=0;
@implementation MatchedShopViewController
- (void) viewWillAppear:(BOOL)animated{
    
    
    userName = [PublicKit getPlistParameter:NameTextString];
    serceUrlString = [PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    _flagString = @"1";//1代表ios，0代表安卓，
    if ([_pidString isEqual:@""]||_pidString.length<=0) {
        _pidString = @"0";
    }
    [self setNavigationModel];
}

- (void) setNavigationModel{
    
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = YES;
    self.currentNavigationController.titleText = @"搭配池";
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
    [self.currentNavigationController setMatchPoolButtonInteraction:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.currentNavigationController setMatchPoolButtonInteraction:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self wholeWebViewOnWindow];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) wholeWebViewOnWindow{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [UIScreen mainScreen].bounds;
    webView = [[UIWebView alloc] initWithFrame:rect];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    webView.scrollView.scrollEnabled  = NO;
    webView.scrollView.delegate = self;
    webView.opaque = NO;
    [webView sizeToFit];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"360show/html/adaptation" ofType:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [webView loadRequest:request];
    [keyWindow addSubview:webView];
}

- (void) addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecevie:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRecevie:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) notificationRecevie:(NSNotification *)noti{
    
    if ([noti.name isEqual:UIKeyboardWillShowNotification]) {
        
        
    }else if ([noti.name isEqual:UIKeyboardWillHideNotification]){
        
        webView.frame = CGRectMake(0,45,SIZEwidth-60,SIZEheight-45);
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webViewLoad{
    
    NSDictionary * dic = @{@"device":_flagString,@"url":serceUrlString,@"userNo":userName,@"pid":_pidString};
    NSString * baseinfoString = [PublicKit toJsonString:dic error:nil];
    NSString * parmicDicString =[NSString stringWithFormat:@"getBaseInfo(%@)",baseinfoString];
    [webView stringByEvaluatingJavaScriptFromString:parmicDicString];
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    RS_WeakSelf weaks = self;
    context[@"share"] = ^(int offsetLeft,int offsetTop,int clientWidth,int clientHeight) {
        RS_StrongSelf self = weaks;
        return [self ScreenShotImage:offsetLeft insertSecond:offsetTop insertThird:clientWidth insertFour:clientHeight];
    };
    context[@"exit"] = ^(){
        
        NSLog(@"退出");
        RS_StrongSelf self = weaks;
        dispatch_async(dispatch_get_main_queue(), ^{
             [webView removeFromSuperview];
        });
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
        [self.currentNavigationController popViewControllerAnimated:YES];
        });
    };
    context[@"openPlans"] = ^(){
        
        NSLog(@"打开我的搭配");
        RS_StrongSelf self = weaks;
        dispatch_async(dispatch_get_main_queue(), ^{
            // 发出打开我的搭配的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"collocationPoolOpenMyCollocation" object:nil];
            [webView removeFromSuperview];
        });
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            [self.currentNavigationController popViewControllerAnimated:YES];
        });
    };
    context[@"logs"] = ^(NSString *string,float angle,float angles){
        
        NSLog(@"%@,原始－－%f,旋转－－%f",string,angle,angles);
    };
}

// scrollerViewDelegate
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return nil;
}

//获取url的交互
//-(NSString *)getBaseInfo{
//    
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:userName forKey:@"userNo"];
//    [dic setObject:serceUrlString forKey:@"url"];
//    [dic setObject:_pidString forKey:@"pid"];
//    [dic setObject:_flagString forKey:@"flag"];
//    NSString * string = [PublicKit toJsonString:dic error:nil];
//    return string;
//}

//截取屏幕的图片
-(NSString * )ScreenShotImage:(float )insertX insertSecond:(float)insertY  insertThird:(float)width insertFour:(float)height{
    
    // 获取截取块
    UIGraphicsBeginImageContext(webView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // 截取图片
    UIRectClip(CGRectMake(insertX, insertY, width, height));
    [webView.layer renderInContext:context];
    //    NSLog(@"insertX = %f,inserty = %f,width = %f, height = %f",insertX,insertY,width,height);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(insertX,insertY, width, height));
    UIImage *subImage = [UIImage imageWithCGImage:subImageRef];
    // 5、关闭上下文
    UIGraphicsEndImageContext();
    NSData *beforeData = UIImageJPEGRepresentation(subImage, 1.0f);
//        NSLog(@"data1111 --->%lu",beforeData.length/1024);
    UIImage *saveImage = [UIImage imageWithData:beforeData];
    while (beforeData.length/1024 > 45) {
        NSLog(@"截图-------->");
        beforeData = UIImageJPEGRepresentation(subImage, 0.30f);
        saveImage = [UIImage imageWithData:beforeData];
    }
//        NSLog(@"data1111222 --->%lu",beforeData.length/1024);
    saveImage = [self compressImage:saveImage toTargetWith:width/3];
    NSData *afterData = UIImageJPEGRepresentation(saveImage, 1.0f);
//        NSLog(@"data222 --->%lu",afterData.length/1024);
    UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);//保存图片到照片库
    NSString *dataString = [NSString stringWithFormat:@"%@",[afterData base64EncodedStringWithOptions: 0]];
    return dataString;
}
// 缩小图片
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWith:(CGFloat)targetWidth{
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetheight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetheight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetheight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}

-(void)dealloc{
    
    NSLog(@"已经销毁");
}


@end
