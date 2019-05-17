//
//  ViewController.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/12.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tweetActionButton;
@property (weak, nonatomic) IBOutlet UILabel *accountDisplayLabel;

@property (nonatomic, strong)ACAccount *accountStore;
@property (nonatomic, copy)NSString *identifier;
@property (nonatomic, copy)NSArray *twitterAccounts;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.accountStore = [[ACAccountStore alloc]init];
    /*ACAccountType *twitterType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAcounntsWithType:twitterType
                                               options:NULLcompletion:^(BOOL granted, NSError *error){
                                                   if(granted){
                                                       self.twitterAccounts = [self.accountStore accountsWithAccountType: twitterType];
                                                       if(self.twitterAccounts.count>0)
                                                       {
                                                           ACAccount *account = self.twitterAccounts[0];
                                                           self.identifier = account.identifier;
                                                           dispatch_async(dispatch_get_main_queue(),^{
                                                               self.accountDisplayLabel.text = account.username;
                                                           });
                                                           
                                                       }else{
                                                           dispatch_async(dispatch_get_main_queue(),^{
                                                               self.accountDisplayLabel.text=@"アカウントなし";
                                                           });
                                                       }
                                                   }
                                                   else{
                                                       NSLog(@"Account Error:%@",[error locarizedDescription]);
                                                       dispatch_async(dispatch_get_main_queue(),^{
                                                           self.accountDisplayLabel.text = @"アカウント認証エラー";
                                                       });
                                                   }
                                               }];*/
     
}

- (IBAction)tweetAction:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        NSString *serviceType =SLServiceTypeTwitter;
        SLComposeViewController *composeCtl = [SLComposeViewController composeViewControllerForServiceType: serviceType];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result){
            if(result==SLComposeViewControllerResultDone){
                
            }
        }];
        [self presentViewController:composeCtl animated:YES completion:NULL];
    }
}

- (IBAction)setAccountAction:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc]init];
    sheet.delegate = self;
    
    sheet.title = @"選択してください";
    for(ACAccount *account in self.twitterAccounts){
        [sheet addButtonWithTitle:account.username];
        
    }
    [sheet addButtonWithTitle:@"キャンセル"];
    sheet.cancelButtonIndex = self.twitterAccounts.count;
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.twitterAccounts.count>0){
        if(buttonIndex != self.twitterAccounts.count){
            ACAccount *account = self.twitterAccounts[buttonIndex];
            self.identifier = account.identifier;
            self.accountDisplayLabel.text = account.username;
            NSLog(@"Account set! %@", account.username);
        }
        else{
            NSLog(@"cancel!");
        }
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"TimeLineSegue"]){
        TimeLineTableViewController *timeLineTableViewController = segue.destinationViewController;
        if([timeLineTableViewController isKindOfClass:[TimeLineTableViewController class]]){
            timeLineTableViewController.identifier = self.identifier;
        }
    }/*else if([segue.identifier isEqualToString:@"TweetSegue"]){
        Tweet
    }*/
}
@end
