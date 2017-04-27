//
//  X5WebView.m
//  WebViewTest
//
//  Created by 李秋 on 2017/4/25.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "X5WebView.h"
#import "CCTemplate.h"

@implementation X5WebView

- (NSString *) loadInjectJS {
	id dict = @{@"user_id": @"1234", @"device_no": @"fasfdjasfp", @"session_id": @"sdfwrw0efasjfqwlrwqe"};
	
	NSString *filename = [[NSBundle mainBundle] pathForResource:@"inject_template" ofType:@"js"];
	NSError *error;
	NSString *template = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
	
	NSString *injectJS = [template templateFromDict:dict];
	NSLog(@"%@", injectJS);
	
	return injectJS;
}

// 接受通知，更新session_id
// window.IBUser.session_id = 'abddd';


// http://stackoverflow.com/questions/24167812/wkwebview-in-interface-builder

- (instancetype)initWithCoder:(NSCoder *)coder {
	
//	WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
	// Set any configuration parameters here
	//config.dataDetectorTypes = WKDataDetectorTypeAll;
//	config.applicationNameForUserAgent = @"WKWebView Test App";
	
//	config.preferences.javaScriptEnabled = YES;
	
	
	
	//self = [super initWithFrame:CGRectZero configuration:config];
	
	// Apply constraints from interface builder
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	//NSLog(@"description = %@", [self.class description]);
	
	// JS注入
	
	WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
	config.userContentController = [[WKUserContentController alloc] init];

	NSString *injectJS = [self loadInjectJS];
	WKUserScript *script = [[WKUserScript alloc] initWithSource:injectJS injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
	[config.userContentController addUserScript:script];
	
	// 交互对象设置
	[config.userContentController addScriptMessageHandler:(id)self name:@"ibuick"];
	
	// 支持内嵌视频播放，不然网页中的视频无法播放
	config.allowsInlineMediaPlayback = YES;
	
	CGRect frame = [[UIScreen mainScreen] bounds];
	self = [super initWithFrame:frame configuration:config];

	return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
	NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
	
	NSLog(@"JS交互参数：%@", dic);
	
	// TODO: dispatcher
	NSString *func_name = dic[@"function_name"];
	if ([func_name isEqualToString:@"setSessionId"]) {
		NSString *sessionId = dic[@"sessionId"];
		NSString *updateStatement = [NSString stringWithFormat:@"window.IBUser.session_id = '%@';", sessionId];
		NSLog(@"update statement = %@", updateStatement);
		[self evaluateJavaScript:updateStatement completionHandler:^(id _Nullable object, NSError * _Nullable error) {
			NSLog(@"complete, %@", object);
		}];
	}
	
	if (dic[@"callback"] != nil) {
		NSString *cbStatement = [NSString stringWithFormat:@"%@('0', 'ok', 'Here is the data you want to return')", dic[@"callback"]];
		NSLog(@"callback statement = %@", cbStatement);
		[self evaluateJavaScript:cbStatement completionHandler:^(id _Nullable object, NSError * _Nullable error) {
			NSLog(@"complete, %@", object);
		}];
	}
}

@end
