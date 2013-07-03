//
//  SwipeViewController.h
//  ProjetoAlex
//
//  Created by Jalan Solutions on 26/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeViewController : UIViewController

@property (weak, nonatomic,getter=isUserInteractionEnabled) IBOutlet UIImageView *uiimageSwipe;
- (IBAction)actionSwipe:(id)sender;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic)NSUInteger indexPag;
@end
