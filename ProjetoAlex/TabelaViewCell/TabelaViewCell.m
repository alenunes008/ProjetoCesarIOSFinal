//
//  TabelaViewCell.m
//  ProjetoAlex
//
//  Created by Jalan Solutions on 05/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "TabelaViewCell.h"
//compomentes
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
//model
#import "Util.h"

@implementation TabelaViewCell

@synthesize  imgFundo = _imgFundo;
@synthesize PhotoView = _PhotoView;
@synthesize loadView = _loadView;
@synthesize activity = _activity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImageUrl:(NSURL *)url
{
    _PhotoView.image = nil;

    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_PhotoView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [MBProgressHUD hideHUDForView:self animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
        //
    }];
    
    
}
@end
