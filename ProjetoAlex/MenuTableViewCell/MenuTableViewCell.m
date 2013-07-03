//
//  MenuTableViewCell.m
//  ProjetoAlex
//
//  Created by Jalan Solutions on 05/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell
@synthesize iconMenu = _iconMenu;
@synthesize lbTitulo = _lbTitulo;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
