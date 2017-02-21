//
//  Utility.m

//
//  Created by Sanjay on 23/07/15.
//  Copyright (c) 2015 Sanjay. All rights reserved.
//

#import "Utility.h"

@implementation Utility



//String to color
+ (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}



#pragma mark - Set Font
//set Labe Fount
/*+(void)setFontOfLable:(UILabel *)tempLable {
    int fontSize = tempLable.font.pointSize;
    tempLable.font = [UIFont fontWithName:AppFontNameRegular size:fontSize];
}


+(void)setFontOfLableBold:(UILabel *)tempLable {
    int fontSize = tempLable.font.pointSize;
    tempLable.font = [UIFont fontWithName:AppFontNameBold size:fontSize];
}

//set Button Fount
+(void)setFontOfButton:(UIButton *)tempBtn{
    int fontSize = tempBtn.titleLabel.font.pointSize;
    tempBtn.titleLabel.font = [UIFont fontWithName:AppFontNameRegular size:fontSize];
}

//set TextField Fount
+(void)setFontOfTextField:(UITextField *)temptxt{
    int fontSize = temptxt.font.pointSize;
    temptxt.font = [UIFont fontWithName:AppFontNameRegular size:fontSize];
}*/


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [Utility imageWithColor:color size:CGSizeMake(1, 1)];
}

#pragma mark - Button Design
//set Button Design
//+(void)setRoundButton:(UIButton *)tempBtn{
//    
//    [self setFontOfButton:tempBtn];
//    tempBtn.layer.cornerRadius = tempBtn.frame.size.height / 2.0f ;
//    tempBtn.layer.masksToBounds = YES;
//    tempBtn.backgroundColor = [UIColor blackColor];
//
//    tempBtn.titleLabel.textColor = [Utility colorFromHexString:AppButtonTextColor];
//    tempBtn.titleLabel.textColor = [UIColor whiteColor];
//    
//    [tempBtn addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
//    [tempBtn addTarget:self action:@selector(buttonDragExit:) forControlEvents:UIControlEventTouchDragOutside];
    
//    [tempBtn setBackgroundImage:[Utility imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
////    [tempBtn setBackgroundImage:[Utility imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
//    
////    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [tempBtn setBackgroundImage:[UIImage imageNamed:@"blue_button"] forState:UIControlStateHighlighted];
    
//    [tempBtn setBackgroundImage:[UIImage imageNamed:@"black_button"] forState:UIControlStateNormal];
//    UIView *superView = [tempBtn superview];
//    UIView *viewBackOfButton = [[UIView alloc] initWithFrame:tempBtn.frame];
//    viewBackOfButton.backgroundColor = [UIColor blackColor];
//    viewBackOfButton.layer.cornerRadius = tempBtn.frame.size.height / 2.0f ;
//    viewBackOfButton.layer.masksToBounds = YES;
//    
//    [superView addSubview:viewBackOfButton];
//
//    [superView bringSubviewToFront:tempBtn];
    
//}

//+(void)buttonHighlight:(UIButton *)sender{
//    sender.titleLabel.textColor = [UIColor blackColor];
//    sender.backgroundColor = [Utility colorFromHexString:APPColor];
//}
//+(void)buttonDragExit:(UIButton *)sender{
//    sender.titleLabel.textColor = [UIColor whiteColor];
//    sender.backgroundColor = [Utility colorFromHexString:AppButtonBackColor];
//}



#pragma mark - TextField Design
//set Button Design
//+(void)setRoundUITextField:(UITextField *)temptxt{
//    
//    [self setFontOfTextField:temptxt];
//    temptxt.layer.cornerRadius = temptxt.frame.size.height / 2.0f ;
//    temptxt.layer.borderColor = [[Utility colorFromHexString:APPTextBoxBorderColorNormal] CGColor];
//    temptxt.layer.borderWidth = 1.0f;
//    temptxt.backgroundColor = [UIColor clearColor];
//    temptxt.textColor = [Utility colorFromHexString:AppButtonTextBoxTextColor];
//}
//
//+(void)setRoundUITextFieldWithoutBorder:(UITextField *)temptxt{
//    
//    [self setFontOfTextField:temptxt];
//    temptxt.layer.cornerRadius = temptxt.frame.size.height / 2.0f ;
//    temptxt.backgroundColor = [UIColor clearColor];
//    temptxt.textColor = [Utility colorFromHexString:AppButtonTextBoxTextColor];
//}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace height:(float)height width:(float)width{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width , temptxt.frame.size.height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, topSpace, width, height)];
    imageView.image = [UIImage imageNamed:imageName];
    [leftView addSubview:imageView];
    temptxt.leftView = leftView;
    
    temptxt.leftViewMode = UITextFieldViewModeAlways;
    
    //[self setFontOfTextField:temptxt];

//    temptxt.leftViewMode = UITextFieldViewModeAlways;
    
//    [temptxt.layer setBorderWidth:1];
//    [temptxt.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [temptxt.layer setBorderColor:[UIColor colorWithRed:18/255.0f green:113/255.0f blue:219/255.0f alpha:1.0f].CGColor];
//    [temptxt.layer setCornerRadius:4];
    
}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace size:(float)size {
    [self setLeftViewInTextField:temptxt imageName:imageName leftSpace:leftSpace topSpace:topSpace height:size width:size];
}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace{
    [self setLeftViewInTextField:temptxt imageName:imageName leftSpace:leftSpace topSpace:topSpace height:(temptxt.frame.size.height-(topSpace*2)) width:(temptxt.frame.size.height-(topSpace*2))];
}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName{
    [self setLeftViewInTextField:temptxt imageName:imageName leftSpace:5 topSpace:5 height:20 width:20];
}

//+(void)setRoundUITextFieldwithLeftSpace:(UITextField *)temptxt lettSpace:(float)leftSpace{
//    
//    [self setFontOfTextField:temptxt];
//    temptxt.layer.cornerRadius = temptxt.frame.size.height / 2.0f ;
//    temptxt.layer.borderColor = [[Utility colorFromHexString:APPTextBoxBorderColorNormal] CGColor];
//    temptxt.layer.borderWidth = 1.0f;
//    temptxt.backgroundColor = [UIColor clearColor];
//    temptxt.textColor = [Utility colorFromHexString:AppButtonTextBoxTextColor];
//    
//    
//    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftSpace, temptxt.frame.size.height)];
//    temptxt.leftView = paddingView;
//    temptxt.leftViewMode = UITextFieldViewModeAlways;
//}

+(void)settxtBorderWithColor:(UITextField *)txtName borderWidth:(float)borderwidth borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius imageName:(NSString *)imge
{
    [self settxtBorderWithColor:txtName borderWidth:borderwidth borderColor:borderColor cornerRadius:cornerRadius];
}

+(void)settxtBorderWithColor:(UITextField *)txtName borderWidth:(float)borderwidth borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius
{
    [txtName.layer setBorderWidth:borderwidth];
    [txtName.layer setBorderColor:(__bridge CGColorRef _Nullable)(borderColor)];
    [txtName.layer setCornerRadius:cornerRadius];
    
    
}

#pragma mark - TextField View

+(void)setLetfAndRightViewOfTextField:(UITextField *)txtField leftImageName:(NSString *)leftImageName rightImageName:(NSString *)rightImageName{
    
   // UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height, txtField.frame.size.height)];
   UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
  
    // UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, txtField.frame.size.height - 10, txtField.frame.size.height - 10)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 23, 23)];
    imageView.image = [UIImage imageNamed:rightImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imageView];
    txtField.rightView = rightView;
    txtField.rightViewMode = UITextFieldViewModeAlways;
    
    [self setLetfViewOfTextField:txtField leftImageName:leftImageName];
}

+(void)setLetfViewOfTextField:(UITextField *)txtField leftImageName:(NSString *)leftImageName{
    
   // UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height + 5, txtField.frame.size.height)];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 33)];
    
    //UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leftView.frame.size.width - 5, 5, 1, leftView.frame.size.height - 10)];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leftView.frame.size.width - 5, 5, 1, 23)];
    
    line.backgroundColor = [UIColor lightGrayColor];
    
    
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, leftView.frame.size.width - 5, txtField.frame.size.height - 15)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 28, 18)];
  
    imageView.image = [UIImage imageNamed:leftImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [leftView addSubview:imageView];
    [leftView addSubview:line];
    
    txtField.leftView = leftView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
}

+(void)setRightViewOfTextField:(UITextField *)txtField rightImageName:(NSString *)rightImageName{

  //  UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height, txtField.frame.size.height)];
    
  //  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, txtField.frame.size.height - 10, txtField.frame.size.height - 10)];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    
    imageView.image = [UIImage imageNamed:rightImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imageView];
    txtField.rightView = rightView;
    txtField.rightViewMode = UITextFieldViewModeAlways;
}

#pragma mark Validation method

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(BOOL)validateAlphaNumericString:(NSString *)string {
    
    NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    BOOL isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
    
    return isAplhaNumericOnly;
}

+(BOOL)validateNumberString:(NSString *)string {
    
    if(string.length == 0) {
        return NO;
    }
    
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string
                                                        options:0
                                                          range:NSMakeRange(0, [string length])];
    if (numberOfMatches == 0)
        return NO;
    
    return YES;
    
}

+(BOOL)validateBlankField:(NSString *)string {
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length]  > 0) {
        return YES;
    }
    
    return NO;
}

+(BOOL)validatePhoneLength:(NSString *)string {
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length]  == 10) {
        return YES;
    }
    
    return NO;
}

+(BOOL)validatePassword:(NSString *)string{
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length] >= 6 && [value length] <= 30) {
        return YES;
    }
    
    return NO;
}

+(BOOL)validateZipCode:(NSString *)string{
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length]  < 7) {
        return YES;
    }
    
    return NO;
}


+(BOOL)validatePassword:(NSString *)string  NewPassword:(NSString *)strNewPassword{
    
    NSRange rangeValue = [string rangeOfString:strNewPassword];
    
    if (rangeValue.length > 0) {
        return NO;
    }
    
    return YES;
}


+(BOOL)validatePassword:(NSString *)string  validateRetypePassword:(NSString *)strRetypePassword{
    
     NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
     NSString *value1 = [strRetypePassword stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    if ([value isEqualToString:value1]) {
        return YES;
    }
    return NO;
}
+(BOOL)validateTermsAndCondition:(UIButton *)button
{
    if (button.selected) {
        return YES;
    }
    return NO;
}


+(BOOL)validateTextfieldLength:(NSString*)string
{
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length] >= 6) {
        return YES;
    }
    return NO;
}

#pragma mark - Mandatory Criteria By Recruiter

+(NSString *)GetMandatoryByRecruiter:(NSString *)RecruiterNameId
{
    NSArray *arrreNameId=[RecruiterNameId componentsSeparatedByString:@","];
    NSString *strRecruiterName=@"";
    for (NSString *strTemp in arrreNameId) {
        if([strTemp integerValue] == 9)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Job Role"];
        }
        else if ([strTemp integerValue]== 10)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Education"];
        }
        else if ([strTemp integerValue]== 11)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Passout"];
        }
        else if ([strTemp integerValue]== 12)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Experience"];
        }
        else if ([strTemp integerValue]== 13)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Job Location"];
        }
        else if ([strTemp integerValue]== 14)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Skills"];
        }
        else if ([strTemp integerValue]== 15)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Gender"];
        }
        else if ([strTemp integerValue]== 16)
        {
            strRecruiterName=[strRecruiterName stringByAppendingString:@",Job Function"];
        }
    }
    return strRecruiterName;
}

#pragma mark - DateFormate

+(NSString*)ChangeDateformate:(NSString *)strDate oldDateFtm:(NSString *)strOldDateFtm newDateFtm:(NSString *)strNewDateFtm
{
    NSString *strUpdated_date=strDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //@"yyyy-MM-dd hh:mm:ss"
    [dateFormatter setDateFormat:strOldDateFtm];
    NSDate *date = [dateFormatter dateFromString:strUpdated_date];
   // @"MMM dd,yyyy hh:mm a"
    [dateFormatter setDateFormat:strNewDateFtm];
    NSString *strnew_updated_date = [dateFormatter stringFromDate:date];
    
    return strnew_updated_date;
}
+ (NSString *)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    //NSDateComponents *difference = [calendar components:NSCalendarUnitDay
    //                                            fromDate:fromDate toDate:toDate options:0];
    
    NSDateComponents *difference=[[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                                 fromDate:fromDateTime
                                                                   toDate:[NSDate date]
                                                                  options:0];
    if (difference.hour < 25 && difference.weekOfYear == 0 && difference.day == 0) {
        return [NSString stringWithFormat:@"%ld hour ago", (long)difference.hour];
    }
    else  if (difference.day > 0)
    {
        if (difference.day > 1)
        {
            return [NSString stringWithFormat:@"%ld days ago", (long)[difference day]];
        }
        else
        {
            return @"Yesterday";
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%ld days ago", (long)difference.day];
    }
}

+(NSString *) stringByStrippingHTML:(NSString *)strString {
    NSRange r;
    while ((r = [strString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        strString = [strString stringByReplacingCharactersInRange:r withString:@""];
    return strString;
}

+ (NSString *)getSizeOfFile:(NSString *)filePath {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSInteger fileSize = [[fileAttributes objectForKey:NSFileSize] doubleValue];
    NSString *fileSizeString = [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
    return fileSizeString;
}

#pragma mark -For SliderView
+ (void)SetViewControllerName:(NSString *)viewcontrollerName
{
    [[NSUserDefaults standardUserDefaults]setObject:viewcontrollerName forKey:@"ForSliderNavigation"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


#pragma mark - Interner connection active or not
+(BOOL)isInterNetConnectionIsActive{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Talents Arena" message:@"Please make sure that you have an active Internet connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alertView show];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Talents Arena"
                              message:@"Please make sure that you have an active Internet connection."
                              delegate:self // <== changed from nil to self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"Ok", nil];
        [alert show];
        return NO;
    }
    return YES;
}


+(NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}


#pragma mark - Api Function


//+(void)POSTapiCall:(NSString *)apiName parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block{
    
    /*[[APIFunction sharedClient]POST:apiName parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if (block) {
             block(responseObject,nil);
             //            block([responseObject valueForKey:@"data"],nil);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //    NSLog(@"failure = %@",operation.responseString);
         
         
         //        NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:operation.responseData
         //                                                             options:kNilOptions
         //                                                               error:&error];
         
         block(nil,error);
         //        block(nil,error);
     }];*/
    
//}

//+(void)POSTapiCall_New:(NSString *)apiName parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block{
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"text/plain;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager POST:[NSString stringWithFormat:@"%@",apiName] parameters:parms
//          success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         // NSLog(@"POSTapiCall_New Response : %@", responseObject);
//         if (block) {
//             block(responseObject,nil);
//         }
//     }
//          failure:
//     ^(AFHTTPRequestOperation *operation, NSError *error) {
//         block(nil,error);
//         NSLog(@"Error: %@", error);
//     }];
//}


/*+(void)GETapiCall_New:(NSString *)apiName block:(void (^)(NSMutableDictionary *,NSError *))block{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:apiName]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(!error)
            {
                NSMutableDictionary * jsonData  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (block) {
                    block(jsonData,nil);
                }
            }
        });
    }] resume];
}


+(void)PostApiCall_New:(NSString *)apiName params:(NSMutableDictionary *)param block:(void (^)(NSMutableDictionary *,NSError *))block{
    
    NSError *error = nil;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:param
                                                       options:kNilOptions
                                                         error:&error];

    
    //NSData *postdata= [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength=[NSString stringWithFormat:@"%lu",(unsigned long)[postdata length]];
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc]init];
    
    
    NSString *str=[NSString stringWithFormat:@"%@%@",URL,apiName];
    [request setURL:[NSURL URLWithString:str]];
    
    [request setHTTPMethod:@"Login"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
   
    [request setValue:@"text/plain;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"http://symphonyirms.softcube.in/Services" forHTTPHeaderField:@"SOAPAction"];
    
    [request setHTTPBody:postdata];
   
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(!error)
            {
                NSMutableDictionary * jsonData  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (block) {
                    block(jsonData,nil);
                }
            }
        });
    }] resume];
    
}

+(void)APIWithImage:(NSString *)apiName parms:(NSMutableDictionary*)parms block:(void (^)(NSDictionary *, NSError *))block{
    
    NSMutableDictionary *dictTemp = [NSMutableDictionary dictionaryWithDictionary:parms];
    [dictTemp removeObjectForKey:@"profile_avatar"];
    [[APIFunction sharedClient] POST:apiName parameters:dictTemp constructingBodyWithBlock:^(id formData) {
        
        [formData appendPartWithFileData:[parms valueForKey:@"profile_avatar"]?[parms valueForKey:@"profile_avatar"]:@"profile_avatar"
                                    name:@"profile_avatar"
                                fileName:@"profile_avatar.jpg"
                                mimeType:@"image/jpg"];
        
    }success:
     ^(AFHTTPRequestOperation * operation,id Json){
         if (block) {
             block(Json, nil);
         }
     } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
         if (block) {
             block(nil, error);
         }
     }];
 
}
+(void)apicallforuploadimage:(NSString *)apiName image:(UIImage *)selectedimage parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block{
    
    NSData *imgdata=UIImageJPEGRepresentation(selectedimage, 0.5);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiName parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imgdata
                                    name:@"js_picture"
                                fileName:@"public.jpg" mimeType:@"jpg"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    }];
    
}

+(void)APIWithPicImage:(NSString *)apiName parms:(NSMutableDictionary*)parms block:(void (^)(NSDictionary *, NSError *))block{
    
    NSMutableDictionary *dictTemp = [NSMutableDictionary dictionaryWithDictionary:parms];
    [dictTemp removeObjectForKey:@"cms_image"];
    [[APIFunction sharedClient] POST:apiName parameters:dictTemp constructingBodyWithBlock:^(id formData) {
        
        [formData appendPartWithFileData:[parms valueForKey:@"cms_image"]?[parms valueForKey:@"cms_image"]:@"cms_image"
                                    name:@"cms_image"
                                fileName:@"cms_image.jpg"
                                mimeType:@"image/jpg"];
        
    }success:
     ^(AFHTTPRequestOperation * operation,id Json){
         if (block) {
             block(Json, nil);
         }
     } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
         if (block) {
             block(nil, error);
         }
     }];
}


+(void)apiCallForUploadResume:(NSString *)apiName fileData:(NSData *)fileData parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiName parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData
                                    name:@"resume"
                                fileName:@"resume1112.pdf" mimeType:@"application/pdf"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+(void)apiCallForUploadCoverletter:(NSString *)apiName fileData:(NSData *)fileData parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiName parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData
                                    name:@"cover_letter_type"
                                fileName:@"resume1112.pdf" mimeType:@"application/pdf"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+(void)downloadresume:(NSString *)apiName fileData:(NSData *)fileData block:(void (^)(NSMutableDictionary *,NSError *))block
{
    
}*/

//+(void)apiCall_soap:(SOAPEngine *)soap url:(NSString *)url action:(NSString *)actionurl block:(void (^)(NSDictionary *,NSError *))block{
//   
//    soap.actionNamespaceSlash = YES;
//    [soap requestURL:url
//          soapAction:actionurl
//            complete:^(NSInteger statusCode, NSString *stringXML) {
//                
//                NSLog(@"Result: %f", [soap floatValue]);
//                if (block) {
//                    block([soap dictionaryValue], nil);
//                }
//            } failWithError:^(NSError *error) {
//                if (block) {
//                    block(nil, error);
//                }
//
//                NSLog(@"%@", error);
//            }];
//
//}

@end
