//
//  ViewController.m
//  WebViewTest
//
//  Created by 李秋 on 2017/4/25.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	NSString *label = @"未知";
	
	switch (indexPath.row) {
		case 0:
			label = @"UIWebView测试";
			break;
			
		case 1:
			label = @"WKWebView测试";
			break;
			
  		case 2:
			label = @"照片美化测试";
			break;
	}
	
	cell.textLabel.text = label;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

#pragma mark UITableViewDelete

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0;
}

- (void)deleteWebCache {
	
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
		NSSet *websiteDataTypes	= [NSSet setWithArray:@[
				WKWebsiteDataTypeDiskCache,
				WKWebsiteDataTypeOfflineWebApplicationCache,
				WKWebsiteDataTypeMemoryCache,
				//WKWebsiteDataTypeLocalStorage,
				//WKWebsiteDataTypeCookies,
				//WKWebsiteDataTypeSessionStorage,
				//WKWebsiteDataTypeIndexedDBDatabases,
				//WKWebsiteDataTypeWebSQLDatabases
			]];
		
		//// All kinds of data
		//NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
		
		//// Date from
		NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
		
		//// Execute
		[[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
			// Done
		}];
	} else {
		NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
		
		NSError *errors;
		[[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *segueName = nil;
	switch (indexPath.row) {
		case 0:
			segueName = @"UIWebViewTest";
			break;
			
		case 1:
			segueName = @"WKWebViewTest";
			break;
			
		case 2:
			break;
	}
	
	if (nil != segueName) {
		[self deleteWebCache];
		[self performSegueWithIdentifier:segueName sender:nil];
	}
}

@end
