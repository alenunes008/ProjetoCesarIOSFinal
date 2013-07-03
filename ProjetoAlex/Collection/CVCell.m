//
//  CVCell.m
//  CollectionViewExample
//
//  Created by Tim on 9/5/12.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CVCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@implementation CVCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CVCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}


- (void) setImageUrl:(NSURL *)imageUrl {
    
    _imgCell.image = nil;
    
//    _imageLoadView.hidden = NO;
//    [_imageLoadViewActivy startAnimating];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    [_imgCell setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        
        [MBProgressHUD hideHUDForView:self animated:YES];
//        _imageLoadView.hidden = YES;
//        [_imageLoadViewActivy stopAnimating];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
//        _imageLoadView.hidden = YES;
//        [_imageLoadViewActivy stopAnimating];
//        //
    }];
    
}

@end
