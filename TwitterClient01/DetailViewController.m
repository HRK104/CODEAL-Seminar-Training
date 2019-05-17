//
//  DetailViewController.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/17.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Detail View";
    self.imageView.image = self.image;
    self.nameView.text = self.name;
    self.textView.text = self.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)retweetAction:(id)sender {
    ACAccountStore *accountStore =[[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json",self.idStr];
    NSURL *url = [NSURL URLWithString:urlString];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodPOST
                                                      URL:url
                                               parameters:nil];
    [request setAccount:account];
    
    UIApplication *application =[UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    
    [request performRequestWithHandler:^(NSData *responseData,
                                         NSHTTPURLResponse *urlResponse,
                                         NSError *error) {
        if(responseData){
            NSString *httpErrorMessage = nil;
            if(urlResponse.statusCode >= 200 && urlResponse.statusCode < 300){
                //NSError *jsonError;
                NSDictionary *postResponseData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                
                NSLog(@"SUCCESS! Created Tweet with ID:%@", postResponseData[@"id_str"]);
                /*self.timeLineData =
                [NSJSONSerialization JSONObjectWithData:responseData
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];*/
                /*if(self.timeLineData){
                    NSLog(@"Timeline Response: %@\n", self.timeLineData);
                    dispatch_async(self.mainQueue, ^{
                        [self.tableView reloadData];
                    });
                }
                else{
                    NSLog(@"JSON Error:%@",[jsonError localizedDescription]);
                }*/
            }
            else{
                httpErrorMessage =
                [NSString stringWithFormat:@"The response statue code is %d",urlResponse.statusCode];
                NSLog(@"HTTP Error: %@", httpErrorMessage);
            }
        }
        else{
            NSLog(@"ERROR: An error occured while posting %@",[error localizedDescription]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication *application =[UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        });
    }];
    /*UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
     self.tableView.alwaysBounceVertical = YES;
     [refreshControl addTarget:self
     action:@selector(refreshAction:)
     forControlEvents:UIControlEventValueChanged];
     self.refreshControl = refreshControl;
     
     [self getRequest];*/
}
@end
