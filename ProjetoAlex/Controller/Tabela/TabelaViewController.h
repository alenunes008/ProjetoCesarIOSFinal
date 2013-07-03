//
//  TabelaViewController.h
//  ProjetoAlex
//
//  Created by Jalan Solutions on 28/02/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dadosfeeds;
#import "Flickr.h"
@interface TabelaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)Dadosfeeds *dados;
@property(nonatomic,retain)Flickr *flickr;

@property (weak, nonatomic) IBOutlet UITableView *tabela;
@end
