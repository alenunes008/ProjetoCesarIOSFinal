//
//  SwipeViewController.m
//  ProjetoAlex
//
//  Created by Jalan Solutions on 26/03/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "SwipeViewController.h"

//model
#import "Flickr.h"
#import "Dadosfeeds.h"

//componentes
#import "AFNetworking.h"
#import "MBProgressHUD.h"

//ViewController
#import "DetalhesFlickrViewController.h"
//Protocolos
#import "TabBarPersonProtocolo.h"


@interface SwipeViewController ()
{
@private
    int rand;
}

@end

@implementation SwipeViewController
@synthesize indexPag = _indexPag;
@synthesize uiimageSwipe = _uiimageSwipe;

BARRA_PADRAO
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"voltar" style:UIBarButtonItemStylePlain target:self action:@selector(actionVoltarRoot)] ;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Util layout:self titulobar:@"Swipe" tipoIconeBarra:tpLista];
    
    _pageControl.numberOfPages = [[[Dadosfeeds defaultHandler]loadDados] count];
    NSInteger firstName = [[Dadosfeeds defaultHandler]loadPag];
    
    if (firstName) {
        rand = firstName;
        [[Dadosfeeds defaultHandler]addDadosRand:rand];
    }else
    {
        [[Dadosfeeds defaultHandler]addDadosRand:0];
    }
    _pageControl.currentPage = rand;

    Flickr *flickr = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:[[Dadosfeeds defaultHandler]loadPag]];
    NSURL *currentImageUrl =[NSURL URLWithString:[flickr m]];
    [self setImage:currentImageUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionSwipe:(id)sender {
    UISwipeGestureRecognizer *oSwipe = (UISwipeGestureRecognizer*)sender;
    switch ([oSwipe direction]) {
        case 1:
            if (rand > 0) {
                rand--;

            }
            break;
        case 2:
            rand++;

            
        default:
            break;
    }

    dispatch_async(
      dispatch_get_global_queue(
        DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
          ^(void) {
            if (rand <= 19 ) {
               [[Dadosfeeds defaultHandler]addDadosRand:rand];
            }
                       
            dispatch_async(dispatch_get_main_queue(),
               ^(void) {
              SwipeViewController *swiper  = [[SwipeViewController alloc]initWithNibName:@"SwipeViewController" bundle:nil];
            [self.navigationController pushViewController:swiper animated:YES];
                                          
                   }
                );
            }
    );

}

//metodo para toque na imagem
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == _uiimageSwipe)
    {
        Flickr *flickr = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:[[Dadosfeeds defaultHandler]loadPag]];

        DetalhesFlickrViewController *dtx = [[DetalhesFlickrViewController alloc]init];
        dtx.index = rand;
        dtx.flickr = flickr;
        [self.navigationController pushViewController:dtx animated:YES];
   
    }
    
}

-(void)setImage:(NSURL *)url
{
    _uiimageSwipe.image = nil;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_uiimageSwipe setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
        //        //
    }];
    
    
}

@end
