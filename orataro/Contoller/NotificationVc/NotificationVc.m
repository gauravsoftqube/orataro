//
//  NotificationVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "NotificationVc.h"
#import "REFrostedViewController.h"

@interface NotificationVc ()
{
    int c2;
}
@end

@implementation NotificationVc
@synthesize aTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    aTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotificationCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
       cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    else
    {
         cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        
    }

    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:2];
    img1.image = [UIImage imageNamed:@"fb_like_gray"];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    //3,4,5
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    
    return 58;
}
#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
     if (c2==0)
    {
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
        self.frostedViewController.panGestureEnabled = NO;
        [self.frostedViewController presentMenuViewController];
        c2=1;
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        self.frostedViewController.panGestureEnabled = NO;
        c2 =0;
    }
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
