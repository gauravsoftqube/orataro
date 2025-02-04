//
//  ProfileFriendRequestVc.m
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileFriendRequestVc.h"
#import "Global.h"

@interface ProfileFriendRequestVc ()
{
    NSMutableArray *aryFriendRequest,*aryTemp;
}
@end

@implementation ProfileFriendRequestVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _lbNoFriendRequest.hidden = YES;
    
    aryFriendRequest = [[NSMutableArray alloc]init];
    aryTemp = [[NSMutableArray alloc]init];
    
    [Utility SearchTextView:_viewSearch];
    
    [self commonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *ary = [DBOperation selectData:@"select * from FriendRequestList"];
    aryFriendRequest = [Utility getLocalDetail:ary columnKey:@"FriendRequestJsonStr"];
    
    aryTemp = [DBOperation selectData:@"select id,flag,FriendRequestImageStr from FriendRequestList"];
    
    //[_tblFriendList reloadData];
    
    if (aryFriendRequest.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetFriendRequestList:YES];
            
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetFriendRequestList:NO];
        }
        else
        {
            
        }
        
    }
    
}


-(void)commonData
{
    self.tblFriendList.separatorStyle=UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryFriendRequest.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    
    UIButton *btnAccept=(UIButton *)[cell.contentView viewWithTag:6];
    [btnAccept.layer setCornerRadius:4];
    btnAccept.clipsToBounds=YES;
    
    UIButton *btnDecline=(UIButton *)[cell.contentView viewWithTag:7];
    [btnDecline.layer setCornerRadius:4];
    btnDecline.clipsToBounds=YES;
    
    [btnDecline.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [btnDecline.layer setBorderWidth:1];
    
    NSLog(@"get ary=%@",aryFriendRequest);
    
    /*
     aryFriendRequest = [Utility getLocalDetail:ary columnKey:@"FriendRequestImageStr"];
     
     aryTemp = [DBOperation selectData:@"select id,flag,FriendRequestImageStr from FriendRequestList"];
     
     {
     DivisionID = "e1f48efb-0ac0-4e6a-82f0-cb59b1748769";
     DivisionName = D;
     FriendListID = "78267280-c052-4390-9555-2e6394f0812c";
     FullName = "Roshani Davara";
     GradeID = "f6ad5a69-ca0c-4c81-a526-d317c390586e";
     GradeName = 12;
     ProfilePicture = "/DataFiles/d79901a7-f9f7-4d47-8e3b-198ede7c9f58/4f4bbf0e-858a-46fa-a0a7-bf116f537653/39c2ba9f-7ece-416b-b641-25e58cdee987/99e7f23d-4bbe-41b0-ad37-c9d7280965ba.jpg";
     RequestDate = "/Date(1490794324343)/";
     RequestID = "39c2ba9f-7ece-416b-b641-25e58cdee987";
     RequestWallID = "d7313e13-dc79-4fe5-bc47-977c1fce2980";
     }
     
     */
    
    //tag 2
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:3];
    lb.text = [[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    //tag 3
    
    
    UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:4];
    if ([[[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"GradeName"] isKindOfClass:[NSNull class]])
    {
        lb2.text = @"";
    }
    else
    {
        lb2.text = [NSString stringWithFormat:@"%@",[[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"GradeName"]];
    }
    
    //tag 4
    
    UILabel *lb3 = (UILabel *)[cell.contentView viewWithTag:5];
    if ([[[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"DivisionName"] isKindOfClass:[NSNull class]])
    {
        lb3.text = @"";
    }
    else
    {
        
        lb3.text = [NSString stringWithFormat:@"%@",[[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"DivisionName"]];
    }
    
    
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:2];
    
    NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    if ([[[aryTemp objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 [DBOperation selectData:[NSString stringWithFormat:@"update FriendRequestList set flag='1' where id=%@",[[aryTemp objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                 
                 NSData *imageData = UIImagePNGRepresentation(image);
                 
                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 NSString *documentsDirectory = [paths objectAtIndex:0];
                 
                 NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTemp objectAtIndex:indexPath.row]objectForKey:@"FriendRequestImageStr"]];
                 
                 NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                 
                 NSString *strSaveImg = [ary lastObject];
                 
                 NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                 
                 [imageData writeToFile:imagePath atomically:NO];
                 
                 if (![imageData writeToFile:imagePath atomically:NO])
                 {
                     NSLog(@"Failed to cache image data to disk");
                 }
                 else
                 {
                     [imageData writeToFile:imagePath atomically:NO];
                     NSLog(@"the cachedImagedPath is %@",imagePath);
                 }
                 
             }];
        }
    }
    else
    {
        //fetch from local
        
        
        NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTemp objectAtIndex:indexPath.row]objectForKey:@"FriendRequestImageStr"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        
        img.image = image;
        
    }
    
    //tag 2
    
    // UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    // lb.text = [[aryFriendRequest objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    //tag 3
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIButton Action

- (IBAction)btntblAccept:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblFriendList];
    NSIndexPath *indexPath = [_tblFriendList indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"Data=%@",[aryFriendRequest objectAtIndex:indexPath.row]);
    
    [self apiCallFor_AcceptFriendList:YES :[aryFriendRequest objectAtIndex:indexPath.row]];
    
}

- (IBAction)btntblDecline:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblFriendList];
    NSIndexPath *indexPath = [_tblFriendList indexPathForRowAtPoint:buttonPosition];
    NSLog(@"Data=%@",[aryFriendRequest objectAtIndex:indexPath.row]);
    
    [self apiCallFor_DeclineFriendList:YES :[aryFriendRequest objectAtIndex:indexPath.row]];
    
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSearchClicked:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        if(aryFriendRequest.count>0)
        {
            NSMutableArray *tmpary = [[NSMutableArray alloc]init];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.FullName contains[c] %@",_txtSearchText.text];
            
            tmpary = [NSMutableArray arrayWithArray:[aryFriendRequest filteredArrayUsingPredicate:predicate]];
            
            if (tmpary.count > 0)
            {
                aryFriendRequest = [[NSMutableArray alloc]initWithArray:tmpary];
                [_tblFriendList reloadData];
            }
            else
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
            }
        }
        else
        {
            
        }
    }
    else
    {
        if ([Utility validateBlankField:_txtSearchText.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Search Text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            
        }
        else
        {
            [self apiCallFor_SearchFriendList:YES];
        }
    }
    
}

#pragma mark - alertview delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 400) {
        
        if (buttonIndex == 0)
        {
           
          //  [self apiCallFor_GetFriendRequestList:YES];
        }
    }
    if (alertView.tag == 500)
    {
        if (buttonIndex == 0)
        {
           //  [self.navigationController popViewControllerAnimated:YES];
           // [self apiCallFor_GetFriendRequestList:YES];
        }
    }

}
#pragma mark - ApiCall

-(void)apiCallFor_GetFriendRequestList : (BOOL)checkProgress
{
    //    if ([Utility isInterNetConnectionIsActive] == false)
    //    {
    //        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alrt show];
    //        return;
    //    }
    
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetFriendRequestList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     _viewSearch.hidden = YES;
                     [DBOperation executeSQL:@"delete from FriendRequestList"];
                     [aryFriendRequest removeAllObjects];
                     [_tblFriendList reloadData];
                     
                     _lbNoFriendRequest.hidden = NO;
                    // UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                     
                 }
                 else
                 {
                     _lbNoFriendRequest.hidden = YES;
                     _viewSearch.hidden = NO;
                     [self ManageCircularList:arrResponce];
                     
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

-(void)ManageCircularList:(NSMutableArray *)arrResponce
{
    NSLog(@"data=%@",arrResponce);
    
    //CREATE TABLE "FriendRequestList" ("id" INTEGER PRIMARY KEY  NOT NULL , "FriendRequestJsonStr" VARCHAR, "FriendRequestImageStr" VARCHAR, "flag" VARCHAR)
    
    
    //  aryFriendRequest = [[NSMutableArray alloc]init];
    // aryTemp = [[NSMutableArray alloc]init];
    
    [DBOperation executeSQL:@"delete from FriendRequestList"];
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ProfilePicture"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSLog(@"data=%@",setImage);
        
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO FriendRequestList (FriendRequestJsonStr,FriendRequestImageStr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
    }
    NSArray *ary = [DBOperation selectData:@"select * from FriendRequestList"];
    aryFriendRequest = [Utility getLocalDetail:ary columnKey:@"FriendRequestJsonStr"];
    aryTemp = [DBOperation selectData:@"select id,flag,FriendRequestImageStr from FriendRequestList"];
    
    [_tblFriendList reloadData];
}

#pragma mark - Search Friend list


-(void)apiCallFor_SearchFriendList : (BOOL)checkProgress
{
    //online / offline
    
    //SearchName=a
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    
    //#define apk_GetFriendRequestList_action @"GetFriendRequestList"
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_Searchfriend_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:_txtSearchText.text forKey:@"SearchName"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PROFILEFRIENDREQUEST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [self ManageCircularList:arrResponce];
                     
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
    
}

#pragma mark - api for Accept

-(void)apiCallFor_AcceptFriendList : (BOOL)checkProgress :(NSMutableDictionary *)dic
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_ApproveRequest_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"FriendListID"]] forKey:@"FriendListID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RequestID"]] forKey:@"RequestID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RequestWallID"]] forKey:@"RequestWallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:FRIENDREQUESTACCEPT delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [self apiCallFor_SendPushNotification];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

#pragma mark - api for Decline

-(void)apiCallFor_DeclineFriendList : (BOOL)checkProgress :(NSMutableDictionary *)dic
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_DeleteRequest_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"FriendListID"]] forKey:@"FriendListID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RequestID"]] forKey:@"RequestID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RequestWallID"]] forKey:@"RequestWallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:FRINEDDECLINE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [self.navigationController popViewControllerAnimated:YES];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

-(void)apiCallFor_SendPushNotification
{
    if ([Utility isInterNetConnectionIsActive] == false){
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_SendPushNotification_action];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error){
        [ProgressHUB hideenHUDAddedTo:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
