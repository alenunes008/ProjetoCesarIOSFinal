//
//  MenuViewController.m
//  ProjetoAlex
//
//  Created by Jalan Solutions on 28/02/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "MenuViewController.h"

//controles
#import "MenuTableViewCell.h"
#import "TabelaViewController.h"
#import "TabelaListaViewController.h"
#import "ListCollectionViewController.h"
#import "SwipeViewController.h"
#import "ListaIcarouselViewController.h"
#import "UIAlertTableView.h"

//model
#import "Dadosfeeds.h"
#import "Flickr.h"
#import "FlickrDB.h"

//componentes
#import "Reachability.h"
//protocolos

#import "TabBarPersonProtocolo.h"


@interface MenuViewController ()
{
    Flickr *flickr;
    NSMutableArray * nomes;
    NSMutableArray *imagens;

}
-(void)loadArray;
@end

@implementation MenuViewController
@synthesize dados = _dados;
@synthesize flickr = _flickr;
@synthesize flickrArrays = _flickrArrays;

BARRA_PADRAO


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadArray{
    
    _flickr = [[NSArray alloc]init];
    nomes = [[NSMutableArray alloc]initWithObjects:@"Rotativo",@"Tabela",@"Collection",@"Swipe",@"Carrosel",@"Favoritos", nil];
    
    imagens = [[NSMutableArray alloc]initWithObjects:@"rootativo.png",@"lista.png",@"collection.png",@"swipe.png",@"carrossel.png",@"favoritoIcon.png", nil];

  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"VariasVisões.jpg"]];
    self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];


    [self loadArray];
    [self verifyConnectionAndPlacePresenceLoad];
    [Util layout:self titulobar:@"Varias Visãoes da Mesma Coisa" tipoIconeBarra:tpMenu];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark metodos Auxiliares


- (IBAction)actionPersonAlertView:(id)sender {
    UIAlertTableView *alert = [[UIAlertTableView alloc] initWithTitle:@"Select Option"
                                                              message:@"select option or create one"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"Create", nil];
    alert.tableDelegate = self;
    alert.dataSource = self;
    alert.tableHeight = 120;
    [alert show];
    
}

-(void)verifyConnectionAndPlacePresenceLoad
{
  
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        NSLog(@"Conexão Indisponível - Exibir alert");
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Falha de Conexão"
                                    message:@"Verifique a sua conexão com a internet e tente novamente."delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alerta show];
        
        
    
    }else
    {
        [self myProgressTask];
    
    }

}
- (void)myProgressTask {
	// This just increases the progres
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[Dadosfeeds defaultHandler]reloadDados];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            _flickr = [[Dadosfeeds defaultHandler]loadDados];
            if ([[Dadosfeeds defaultHandler] loadDados]==0) {
                
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Falha de Conexão"
                                                                 message:@"AAAA"
                                                                delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alerta show];
                _tabela.hidden = YES;
                
            }else
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _lbTxtErro.hidden = YES;
                _tabela.hidden = NO;
               
            }
        });
        
    });
    
    
//    [self animateSplash];
    
}

#pragma -mark UITableViewDataSource e UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [nomes count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"idMenu"];
    if (cell == nil) {
        cell = [[MenuTableViewCell alloc]init];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MenuTableViewCell" owner:tableView options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
    }
    cell.lbTitulo.text = nomes[indexPath.row];
    UIImage *image = [UIImage imageNamed:[imagens objectAtIndex:indexPath.row]];
    cell.iconMenu.image = image;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabelaViewController *tabelaviewcontroller;
    TabelaListaViewController *tabelaLista;
    ListCollectionViewController *listaCollection;
    ListaIcarouselViewController *carrossel;
    SwipeViewController *swipe;
    FlickrDB *flickrDB = [[FlickrDB alloc]init];

    switch (indexPath.row) {
        case 0:
            tabelaviewcontroller = [[TabelaViewController alloc]init];
            //tabelaviewcontroller.dados = _dados;
//            tabelaviewcontroller.flickr = flickr;
            [self.navigationController pushViewController:tabelaviewcontroller animated:YES];
            break;
        case 1:
            tabelaLista = [[TabelaListaViewController alloc]init];
            tabelaLista.flickr = _flickr;
            [self.navigationController pushViewController:tabelaLista animated:YES];
            break;
         case 2:
            listaCollection = [[ListCollectionViewController alloc]init];
            listaCollection.flickrs = [[Dadosfeeds defaultHandler]loadDados];
            listaCollection.flagFavorito = NO;
            [self.navigationController pushViewController:listaCollection animated:YES];
            break;
        case 3:
            swipe = [[SwipeViewController alloc]init];
            // listaCollection.dados = _dados;
            [self.navigationController pushViewController:swipe animated:YES];
            break;
         case 4:
            carrossel = [[ListaIcarouselViewController alloc]init];
            
            [self.navigationController pushViewController:carrossel animated:YES];
            break;
         case 5:
            //listando dados do SQLITE
            [flickrDB createDb];            
            _flickrArrays =[[NSMutableArray alloc]initWithArray:[flickrDB findContact]];
            
            
            listaCollection = [[ListCollectionViewController alloc]init];
            listaCollection.flickrs = _flickrArrays;
            listaCollection.flagFavorito = YES;
            [self.navigationController pushViewController:listaCollection animated:YES];
            break;
        default:
            break;
    }
}

@end
