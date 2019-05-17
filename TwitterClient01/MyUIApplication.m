//
//  MyUIApplication.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/17.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import "MyUIApplication.h"

@implementation MyUIApplication

-(BOOL)openURL:(NSURL *)url
{
    if(!url){
        return NO;
    }
    
    self.myOpenURL = url;
    AppDelegate *appDelegate = (AppDelegate *)[self delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WebViewController *webViewController =[storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.openURL = self.myOpenURL;
    webViewController.title = @"Web View";
    [appDelegate.navigationController pushViewController:webViewController animated:YES];
    self.myOpenURL = nil;
    return YES;
}

@end
