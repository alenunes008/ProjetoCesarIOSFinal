//
//  TabelaListaViewController.m
//  ProjetoAlex
//
//  Created by Jalan Solutions on 05/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "TabelaListaViewController.h"
//model
#import "Flickr.h"
//viewcontroller
#import "DetalhesFlickrViewController.h"
//compomentes
#import "TabelaViewCell.h"
#import "RefreshProtocolo.h"
//Protocolos
#import "TabBarPersonProtocolo.h"

@interface TabelaListaViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property(nonatomic,retain)UIRefreshControl *refreshControl;
@end

@implementation TabelaListaViewController
@synthesize  flickr = _flickr;
@synthesize refreshControl = _refreshControl;

BARRA_PADRAO


SYNTHESIZE_FETCHED_RESULTS_CONTROLLER

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Util layout:self titulobar:@"Tabela" tipoIconeBarra:tpLista];
    UIRefreshControl *refreshControl;
    refreshControl = [self refresh:self.tabela];

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_flickr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabelaViewCell *cell = (TabelaViewCell*) [tableView dequeueReusableCellWithIdentifier:@"idTabela"];
    
    if (cell == nil) {
        cell = [[TabelaViewCell alloc]init];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TabelaViewCell" owner:tableView options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

    }
        Flickr *flickr = [_flickr objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:
                      [flickr m]];
        [cell setImageUrl:url];
            
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Flickr *flickr  = [_flickr objectAtIndex:indexPath.row];

    DetalhesFlickrViewController *dtx = [[DetalhesFlickrViewController alloc]init];
    dtx.index = indexPath.row;
    dtx.flickr = flickr;
    [self.navigationController pushViewController:dtx animated:YES];
    
}


@end
