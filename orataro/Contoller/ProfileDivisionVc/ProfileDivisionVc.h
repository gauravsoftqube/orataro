//
//  ProfileDivisionVc.h
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDivisionVc : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblDivisionList;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;

@end
