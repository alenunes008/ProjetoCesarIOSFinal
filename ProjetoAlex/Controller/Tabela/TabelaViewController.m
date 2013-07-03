//
//  TabelaViewController.m
//  ProjetoAlex
//
//  Created by Jalan Solutions on 28/02/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "TabelaViewController.h"
//model
#import "Dadosfeeds.h"
//controller
#import "TabelaViewCell.h"
#import "DetalhesFlickrViewController.h"
//protocolo
#import "TabBarPersonProtocolo.h"
@interface TabelaViewController ()

@end

@implementation TabelaViewController
@synthesize flickr = _flickr;

BARRA_PADRAO

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

        CGRect previousFrame = _tabela.frame;
        _tabela.transform = CGAffineTransformMakeRotation(3*M_PI_2);
        _tabela.frame = previousFrame;
    [Util layout:self titulobar:@"Rotativo" tipoIconeBarra:tpLista];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITABLEVIEWDATASOURCE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[Dadosfeeds defaultHandler]loadDados]count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TabelaViewCell *cell = (TabelaViewCell*) [tableView dequeueReusableCellWithIdentifier:@"idTabela"];
    if (cell == nil) {
        cell = [[TabelaViewCell alloc]init];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TabelaViewCell" owner:tableView options:nil] objectAtIndex:0];
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

    }
    dispatch_async(dispatch_get_main_queue(), ^{
        Flickr *flickr  = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:
                      [flickr m]];
        [cell setImageUrl:url];
       // cell.imgFundo.image = [UIImage imageNamed:@"fundoMadeira.jpeg"];

    });

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Flickr *flickr  = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:indexPath.row];

    DetalhesFlickrViewController *dtx = [[DetalhesFlickrViewController alloc]init];
    dtx.index = indexPath.row;
    dtx.flickr = flickr;
    [self.navigationController pushViewController:dtx animated:YES];

}

@end
