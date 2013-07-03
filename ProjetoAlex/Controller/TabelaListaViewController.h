//
//  TabelaListaViewController.h
//  ProjetoAlex
//
//  Created by Jalan Solutions on 05/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Flickr;
@interface TabelaListaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)Dadosfeeds *dados;
@property(nonatomic,retain)NSArray *flickr;
@end
