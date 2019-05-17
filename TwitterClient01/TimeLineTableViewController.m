//
//  TimeLineTableViewController.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/16.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import "TimeLineTableViewController.h"

@interface TimeLineTableViewController ()
@property dispatch_queue_t mainQueue;
@property dispatch_queue_t imageQueue;
@property NSString *httpErrorMessage;
@property NSArray *timeLineData;
@end

@implementation TimeLineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.mainQueue = dispatch_get_main_queue();
    self.imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0);
    
    [self.tableView registerClass:[TimeLineCell class] forCellReuseIdentifier:@"TimeLineCell"];
    
    
    ACAccountStore *accountStore =[[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                  @"/1.1/statuses/home_timeline.json"];
    NSDictionary *params = @{@"count":@"100",
                             @"trim_user":@"0",
                             @"include_entities":@"0"};
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:url
                                               parameters:params];
    [request setAccount:account];
    
    UIApplication *application =[UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    
    [request performRequestWithHandler:^(NSData *responseData,
                                         NSHTTPURLResponse *urlResponse,
                                         NSError *error) {
        if(responseData){
            self.httpErrorMessage = nil;
            if(urlResponse.statusCode >= 200 && urlResponse.statusCode < 300){
                NSError *jsonError;
                self.timeLineData =
                [NSJSONSerialization JSONObjectWithData:responseData
                                                options:NSJSONReadingAllowFragments
                                                  error:&jsonError];
                if(self.timeLineData){
                    NSLog(@"Timeline Response: %@\n", self.timeLineData);
                    dispatch_async(self.mainQueue, ^{
                        [self.tableView reloadData];
                    });
                }
                else{
                    NSLog(@"JSON Error:%@",[jsonError localizedDescription]);
                }
            }
            else{
                self.httpErrorMessage =
                [NSString stringWithFormat:@"The response statue code is %d",urlResponse.statusCode];
                NSLog(@"HTTP Error: %@", self.httpErrorMessage);
            }
    }
        dispatch_async(self.mainQueue, ^{
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(!self.timeLineData){
        return 1;
    }
    else{
        return [self.timeLineData count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeLineCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if(self.httpErrorMessage){
        cell.tweetTextLabel.text = self.httpErrorMessage;
        cell.tweetTextLabelheight = 24;
    }
    else if(!self.timeLineData){
        cell.tweetTextLabel.text=@"Loading...";
        cell.tweetTextLabelheight = 24;
    }
    else{
        NSString *name = [[[self.timeLineData objectAtIndex:indexPath.row]
                           objectForKey:@"user"]
                          objectForKey:@"screen_name"];
        NSString *text = [[self.timeLineData objectAtIndex:indexPath.row]
                          objectForKey:@"text"];
        
        CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:16]
                            constrainedToSize:CGSizeMake(300, 1000)
                                lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.tweetTextLabelheight = labelSize.height;
        cell.tweetTextLabel.text = text;
        
        cell.nameLabel.text = name;
        cell.profileImageView.image = [UIImage imageNamed:@"blank.png"];
        
        UIApplication *application = [UIApplication sharedApplication];
        application.networkActivityIndicatorVisible = YES;
        
        dispatch_async(self.imageQueue, ^{
            NSString *url;
            NSDictionary *tweetDictionary = [self.timeLineData objectAtIndex:indexPath.row];
            
            if([[tweetDictionary allKeys] containsObject:@"retweeted_status"]){
                url=tweetDictionary[@"retweeted_status"][@"user"][@"profile_image_url"];
            }
            else{
                url = tweetDictionary[@"user"][@"profile_image_url"];
            }
            
            NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            dispatch_async(self.mainQueue, ^{
                UIApplication *application = [UIApplication sharedApplication];
                application.networkActivityIndicatorVisible = NO;
                UIImage *image = [[UIImage alloc] initWithData:data];
                cell.profileImageView.image = image;
                [cell setNeedsLayout];
            });
        });
    }
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tweetText = self.timeLineData[indexPath.row][@"text"];
    //CGFloat tweetTextLabelHeight = [self labelHeight:tweetText];
    CGSize tweetTextLabelHeight = [tweetText sizeWithFont:[UIFont systemFontOfSize:16]
                        constrainedToSize:CGSizeMake(300, 1000)
                            lineBreakMode:NSLineBreakByWordWrapping];
    return tweetTextLabelHeight.height+35;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineCell *cell = (TimeLineCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.name = cell.nameLabel.text;
    detailViewController.text = cell.tweetTextLabel.text;
    detailViewController.image = cell.profileImageView.image;
    detailViewController.identifier = self.identifier;
    detailViewController.idStr = self.timeLineData[indexPath.row][@"id_str"];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
