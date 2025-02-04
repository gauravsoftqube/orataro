//
// UIViewController+REFrostedViewController.m
// REFrostedViewController
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"

@implementation UIViewController (REFrostedViewController)

- (void)re_displayController:(UIViewController *)controller frame:(CGRect)frame
{
    
    
    [self addChildViewController:controller];

    long y=frame.origin.y;
    if(y == 64)
    {
        controller.view.frame = frame;
       
    }
    else
    {
         controller.view.frame = self.view.frame;
    }
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

- (void)re_hideController:(UIViewController *)controller
{
   
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.checkview = 0;

    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
    
}

- (REFrostedViewController *)frostedViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[REFrostedViewController class]]) {
            return (REFrostedViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
