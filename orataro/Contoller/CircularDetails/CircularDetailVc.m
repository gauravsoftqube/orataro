//
//  CircularDetailVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CircularDetailVc.h"
#import "Global.h"

@interface CircularDetailVc ()

@end

@implementation CircularDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewUserBorder.layer setCornerRadius:40];
    [_viewUserBorder.layer setBorderWidth:1];
    [_viewUserBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    
    
    [_imgUser.layer setCornerRadius:35];
    _imgUser.clipsToBounds=YES;
     [self commonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
   
}
-(void)commonData
{
    
    NSLog(@"Dic=%@",_dicSelect_Circular);
    
    [self.lblTitle setText:[NSString stringWithFormat:@"%@",[[self.dicSelect_Circular objectForKey:@"CircularTitle"] capitalizedString]]];
    [self.lblDetail setText:[NSString stringWithFormat:@"%@",[[self.dicSelect_Circular objectForKey:@"CircularDetails"] capitalizedString]]];
    [self.lblUserName setText:[NSString stringWithFormat:@"%@",[[self.dicSelect_Circular objectForKey:@"TeacherName"] capitalizedString]]];

    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForHomeWork=[NSString stringWithFormat:@"%@",[self.dicSelect_Circular objectForKey:@"Photo"]];
        if(![strURLForHomeWork isKindOfClass:[NSNull class]] && ![strURLForHomeWork isEqual:@"<null>"])
        {
            strURLForHomeWork=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicSelect_Circular objectForKey:@"Photo"]];
            
            [_imgCircular sd_setImageWithURL:[NSURL URLWithString:strURLForHomeWork] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
            {
                
                _imgCircular.image = image;
                
                [self getUserImage];

            }];
            
            
        }
        else
        {
             _imgCircular.image = [UIImage imageNamed:@"no_img"];
            [self getUserImage];
        }
    }

}

-(void)getUserImage
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[self.dicSelect_Circular objectForKey:@"ProfilePic"]];
        if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
        {
            strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelect_Circular objectForKey:@"ProfilePic"]];
            
            [_imgUser sd_setImageWithURL:[NSURL URLWithString:strURLForTeacherProfilePicture] placeholderImage:[UIImage imageNamed:@"dash_profile"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                _imgUser.image = image;
            }];
            
        }
    }
    
}

#pragma mark - UIButton Action


- (IBAction)BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
