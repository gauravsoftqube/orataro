//
//  HelpDeskVc.h
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpDeskVc : UIViewController
- (IBAction)BackBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoneNo;
- (IBAction)btnPhoneNo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSupportURL;
- (IBAction)btnSupportURL:(id)sender;

@end
