//
//  ProfileStudentLeaveVc.m
//  orataro
//
//  Created by MAC008 on 21/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileStudentLeaveVc.h"
#import "Global.h"
#import "Utility.h"

@interface ProfileStudentLeaveVc ()
{
    NSMutableArray *aryListofStudent;
    NSString *strStudentName;
    NSString *strPreApplication,*strMemberID;
    UIDatePicker *datePicker;
    UIAlertView *alert;
    NSString *strCheck;
}
@end

@implementation ProfileStudentLeaveVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // strPreApplication= @"0";
    
    _viewStudentFullnameList.hidden = YES;
    
    [self SegmentData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Data=%@",_dicStudentLeaveData);
    NSLog(@"Data=%@",_strAddEdit);
    
    [Utility setLeftViewInTextField:_txtFullName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtStartDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtEndDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    
   NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSinceNow];
   NSDate *date1 = [[NSDate alloc] initWithTimeIntervalSinceNow:timeInSeconds];
    
    NSString *string=[Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicStudentLeaveData objectForKey:@"StartDate"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date2 = [dateFormatter dateFromString:string];
    
   // NSLog(@"Current Date=%@",date1);
   // NSLog(@"Start Date=%@",date2);

    if ([date1 compare:date2] == NSOrderedDescending)
    {
        [self setuserinteraction:NO];
    }
    else if ([date1 compare:date2] == NSOrderedAscending)
    {
       [self setuserinteraction:YES];
    }
    else
    {
        [self setuserinteraction:NO];
    }

    _txtFullName.text = [_dicStudentLeaveData objectForKey:@"TeacherName"];
    _txtDescription.text = [_dicStudentLeaveData objectForKey:@"ReasonForLeave"];
    
    _txtStartDate.text = [Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:[_dicStudentLeaveData objectForKey:@"StartDate"]];
    _txtEndDate.text = [Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:[_dicStudentLeaveData objectForKey:@"EndDate"]];
    
    NSString *strPreapp = [NSString stringWithFormat:@"%@",[_dicStudentLeaveData objectForKey:@"IsPerApplication"]];

   // NSLog(@"Atr=%@",strPreapp);
    
    if ([strPreapp isEqualToString:@"1"])
    {
         [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        strPreApplication =@"1";
    }
    else
    {
         [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        strPreApplication =@"0";
    }
    
    if ([_strAddEdit isEqualToString:@"Edit"])
    {
        //[NSString stringWithFormat:@"My Profile (%@)",[Utility getCurrentUserName]];
        
        _btnFullname.userInteractionEnabled = NO;
        _lbHeaderTitle.text = [NSString stringWithFormat:@"Edit Leave (%@)",[Utility getCurrentUserName]];
    }
    else
    {
        _btnFullname.userInteractionEnabled = YES;
        _lbHeaderTitle.text = [NSString stringWithFormat:@"Add Leave (%@)",[Utility getCurrentUserName]];

        [self api_GetStudentList];
    }
    
    
}

-(void)setuserinteraction: (BOOL)flag
{
    [_txtFullName setUserInteractionEnabled:flag];
    [_txtDescription setUserInteractionEnabled:flag];
    [_btnStart setUserInteractionEnabled:flag];
    [_btnEnddate setUserInteractionEnabled:flag];
    [_viewPreapplication setUserInteractionEnabled:flag];
    [_viewSave setUserInteractionEnabled:flag];
     
}
#pragma mark - common method

-(void)SegmentData
{
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *Date=[NSDate date];
    datePicker.minimumDate=Date;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    alert.tag = 2;
    [alert setValue:datePicker forKey:@"accessoryView"];
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  aryListofStudent.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentListCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StudentListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
    
    lb.text = [[aryListofStudent objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    UIImageView *img= (UIImageView *)[cell.contentView viewWithTag:2];
    
    if ([[[aryListofStudent objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
    {
        [img setImage:[UIImage imageNamed:@"unradiop"]];
    }
    else
    {
        [img setImage:[UIImage imageNamed:@"radiop"]];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _txtFullName.text = [[aryListofStudent objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    strStudentName = [[aryListofStudent objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    strMemberID = [[aryListofStudent objectAtIndex:indexPath.row]objectForKey:@"MemberID"];
    
    NSString *s = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    for (int i=0; i< aryListofStudent.count; i++)
    {
        NSMutableDictionary *d = [[aryListofStudent objectAtIndex:i] mutableCopy];
        NSString *s1 = [NSString stringWithFormat:@"%d",i];
        
        if (s == s1)
        {
            [d setValue:@"1" forKey:@"Value"];
        }
        else
        {
            [d setValue:@"0" forKey:@"Value"];
        }
        [aryListofStudent replaceObjectAtIndex:i withObject:d];
    }
    [_tblStudentList reloadData];
    _viewStudentFullnameList.hidden = YES;
}



#pragma mark - button action

- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSelectFullname:(id)sender
{
    _viewStudentFullnameList.hidden = NO;
    [self.view bringSubviewToFront:_viewStudentFullnameList];

}

- (IBAction)btnPreApplicationClicked:(id)sender
{
    //checkboxunselected
    //checkboxblue
    
    NSLog(@"strPre=%@",strPreApplication);
    
    if ([strPreApplication isEqualToString:@"0"])
    {
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        strPreApplication = @"1";
    }
    else
    {
          [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
         strPreApplication = @"0";
    }

}

- (IBAction)btnSaveClicked:(id)sender
{
    if ([_strAddEdit isEqualToString:@"Edit"])
    {
        if ([Utility validateBlankField:_txtDescription.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
         [self api_SaveAddData];
    }
    else
    {
        if ([Utility validateBlankField:_txtFullName.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Fullname" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        if ([Utility validateBlankField:_txtDescription.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        if ([Utility validateBlankField:_txtStartDate.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_Start_Date delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        if ([Utility validateBlankField:_txtEndDate.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_End_Date delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        [self api_SaveAddData];
    }
}

- (IBAction)btnEndDateClicked:(id)sender
{
    strCheck =@"EndDate";
    [alert show];
   
}

- (IBAction)btnStartDateClicked:(id)sender
{
    strCheck =@"StartDate";
    [alert show];
}

#pragma mark -alert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        //strCheck =@"EndDate";
        //strCheck =@"StartDate";
        if ([strCheck isEqualToString:@"StartDate"])
        {
            if (buttonIndex == 0)
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd-MM-yyyy"];
                NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
                _txtStartDate.text = theDate;
                
            }
            if (buttonIndex == 1)
            {
                alert.hidden = YES;
            }
            
        }
        else if([strCheck isEqualToString:@"EndDate"])
        {
            if (buttonIndex == 0)
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd-MM-yyyy"];
                NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
                _txtEndDate.text = theDate;
                
            }
            if (buttonIndex == 1)
            {
                alert.hidden = YES;
            }
        }
    }
}



#pragma mark - Get Student List

-(void)api_GetStudentList
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetTeacherListNameAndMemberID];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    //  NSLog(@"dic=%@",dicCurrentUser);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
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
                     [aryListofStudent removeAllObjects];
                     [_tblStudentList reloadData];
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PROFILESTUDENT delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                    
                     
                     aryListofStudent = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     _txtFullName.text = [[aryListofStudent objectAtIndex:0]objectForKey:@"FullName"];
                     
                    strMemberID = [[aryListofStudent objectAtIndex:0]objectForKey:@"MemberID"];
                     
                     for (int i=0; i<aryListofStudent.count; i++)
                     {
                         NSMutableDictionary *dic = [[aryListofStudent objectAtIndex:i]mutableCopy];
                         
                         // [dic se]
                         
                         if (i == 0)
                         {
                             [dic setValue:@"1" forKey:@"Value"];
                             [aryListofStudent replaceObjectAtIndex:i withObject:dic];
                         }
                         else
                         {
                             [dic setValue:@"0" forKey:@"Value"];
                             [aryListofStudent replaceObjectAtIndex:i withObject:dic];
                         }
                     }
                     NSLog(@"Ary=%@",aryListofStudent);
                     [_tblStudentList reloadData];
                     
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


#pragma mark - api - SaveStudentData

-(void)api_SaveAddData
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:                            nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_leave,apk_SaveUpdateTodos_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    // 8733884646
    //qwerty/123456
    
    //    <UserID>guid</UserID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <MemberID>guid</MemberID>
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    //    <StartDate>string</StartDate>
    //    <EndDate>string</EndDate>
    //    <SchoolLeaveNoteID>guid</SchoolLeaveNoteID>
    //    <PostByType>string</PostByType>
    //    <TeacherID>guid</TeacherID>
    //    <IsPreApplication>boolean</IsPreApplication>
    //    <ReasonForLeave>string</ReasonForLeave>
    

        
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    }
    else
    {
        [param setValue:@"" forKey:@"DivisionID"];
        [param setValue:@"" forKey:@"GradeID"];
    }
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtStartDate.text] forKey:@"StartDate"];
    
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtEndDate.text] forKey:@"EndDate"];
    
    if ([_strAddEdit isEqualToString:@"Edit"])
    {
         [param setValue:[_dicStudentLeaveData objectForKey:@"SchoolLeaveNoteID"] forKey:@"SchoolLeaveNoteID"];
         [param setValue:[_dicStudentLeaveData objectForKey:@"ApplicationToTeacherID"] forKey:@"TeacherID"];
        
    }
    else
    {
         [param setValue:@"" forKey:@"SchoolLeaveNoteID"];
         [param setValue:strMemberID forKey:@"TeacherID"];
    }
   
    
    [param setValue:[dicCurrentUser objectForKey:@"PostByType"] forKey:@"PostByType"];
   
    
    //[param setValue:[_dicAddLeave objectForKey:@"ApplicationToTeacherID"] forKey:@"TeacherID"];
    
    NSLog(@"StrPreapp=%@",strPreApplication);
    
    NSLog(@"App=%@",[NSNumber numberWithBool:strPreApplication]);
    
    //[param setValue:[NSNumber numberWithBool:strPreApplication] forKey:@"IsPreApplication"];
    
    if ([strPreApplication isEqualToString:@"0"])
    {
        [param setValue:@"false" forKey:@"IsPreApplication"];

    }
    else
    {
        [param setValue:@"true" forKey:@"IsPreApplication"];

    }
    
    [param setValue:_txtDescription.text forKey:@"ReasonForLeave"];
    
    
    // <PostByType>string</PostByType>
    
    [ProgressHUB showHUDAddedTo:self.view];

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
                 if([strStatus isEqualToString:@"Record save successfully"])
                 {
                     [self apiCallFor_SendPushNotification];
                 }
                 else if([strStatus isEqualToString:@"Record update successfully"])
                 {
                     [self apiCallFor_SendPushNotification];
                 }
                 else
                 {
                      UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:RECORDNOTSAVE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
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
