//
//  ForgotPassVc.h
//  orataro
//
//  Created by harikrishna patel on 26/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassVc : UIViewController


@property (weak, nonatomic) IBOutlet UIView *aMobOuterView;
- (IBAction)BackBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnVerify;
- (IBAction)btnVerify:(id)sender;

@end
