//
//  WebViewController.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/17.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:self.openURL];
    [self.webView loadRequest:myRequest];
}

-(void) webViewDidStartLoad:(UIWebView*)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    [self.activityIndicator stopAnimating];
}
-(void)webView:(UIWebView*)webView didFailLoadWithError:(nonnull NSError *)error
{
    [self.activityIndicator stopAnimating];
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
