//
//  WebTestViewController.m
//  WebViewTest
//
//  Created by 李秋 on 2017/4/25.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "WKWebTestViewController.h"
#import "X5WebView.h"

@interface WKWebTestViewController () <WKUIDelegate>

@end

@implementation WKWebTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	_webView.backgroundColor = UIColor.blueColor;
	_webView.UIDelegate = self;
	
	[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.85:8080/index.html"]]];
	NSLog(@"%f, %f, %f, %f", _webView.frame.origin.x, _webView.frame.origin.y, _webView.frame.size.width, _webView.frame.size.width);
}

- (void)viewDidAppear:(BOOL)animated {
}

#pragma mark - WKUIDelegate

// 提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
	[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		completionHandler();
	}]];
	[self presentViewController:alert animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
