//
//  MenuViewController.h
//  ProjetoAlex
//
//  Created by Jalan Solutions on 28/02/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef enum
{
    favorita,
    disfavorita
  
}tpFavorito;

@class  Dadosfeeds;
@interface MenuViewController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property(nonatomic,strong)Dadosfeeds *dados;
@property (weak, nonatomic) IBOutlet UILabel *lbTxtErro;
@property(nonatomic,strong)MBProgressHUD * HUD;
@property(nonatomic,retain)NSArray *flickr;
@property(nonatomic,retain)NSMutableArray *flickrArrays;

- (IBAction)actionPersonAlertView:(id)sender;
-(void)verifyConnectionAndPlacePresenceLoad;
@end
