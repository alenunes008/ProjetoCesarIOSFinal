//
//  TabelaViewCell.h
//  ProjetoAlex
//
//  Created by Jalan Solutions on 05/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabelaViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgFundo;
@property (weak, nonatomic) IBOutlet UIImageView *PhotoView;
@property (weak, nonatomic) IBOutlet UIView *loadView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;


-(void)setImageUrl:(NSURL *)url;

@end
