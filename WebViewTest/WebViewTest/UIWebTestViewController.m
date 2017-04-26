//
//  WebTestViewController.m
//  WebViewTest
//
//  Created by 李秋 on 2017/4/25.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "UIWebTestViewController.h"

@interface UIWebTestViewController ()

@end

@implementation UIWebTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	_webView.opaque = NO;
	_webView.backgroundColor = [UIColor clearColor];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)viewDidAppear:(BOOL)animated {
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
