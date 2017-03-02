//
//  DEMOViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMORootViewController.h"

@interface DEMORootViewController ()

@end

@implementation DEMORootViewController

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
  //  self.navigationController.navigationBarHidden = YES;
    
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    //self.menuViewController.navigationController.navigationBarHidden = YES;
}

@end
