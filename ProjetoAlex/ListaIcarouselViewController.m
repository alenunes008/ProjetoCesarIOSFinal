//
//  MenuFotosViewController.m
//  TesteAlex2
//
//  Created by Jalan Solutions on 26/11/12.
//  Copyright (c) 2012 Jalan Tecnologia. All rights reserved.
//

#import "ListaIcarouselViewController.h"

//compomentes
#import "UIImageView+AFNetworking.h"
#import "iCarousel.h"
#import "DownloadImageView.h"

//ViewController
#import "DetalhesFlickrViewController.h"
#import "MenuViewController.h"

//model
#import "Flickr.h"
#import "Dadosfeeds.h"

//Protocolos
#import "TabBarPersonProtocolo.h"


@interface ListaIcarouselViewController ()

@end

@implementation ListaIcarouselViewController
//@synthesize dados = _dados;

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
    // Do any additional setup after loading the view from its nib.
    _carousel.type = iCarouselTypeCoverFlow2;
    
    
    [Util layout:self titulobar:@"iCarousel" tipoIconeBarra:tpLista];
    
}

-(void)viewDidUnload{

    self.carousel = nil;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark ICAROUSELDELEGATE
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [[[Dadosfeeds defaultHandler]loadDados]count];

}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels

    return [[[Dadosfeeds defaultHandler]loadDados]count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
//   
    if (view == nil)
    {
//
         Flickr *flickr = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:index];
         DownloadImageView *image = [[DownloadImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 284)];
//
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, 250.0f)];
//        [imageView setImageWithURL:[NSURL URLWithString:[flickr m]] placeholderImage:[UIImage imageNamed:@""]];
        image.url = [flickr m];

        view = image;
    }
    return view;
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    Flickr *flickr = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:index];

    DetalhesFlickrViewController *dtfv  = [[DetalhesFlickrViewController alloc]init];
    dtfv.flickr = flickr;
    [self.navigationController pushViewController:dtfv animated:YES];

}



-(void)setImageUrl:(NSURL *)url andImage:(UIImageView *)_PhotoView
{
    _PhotoView.image = nil;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_PhotoView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
        //
    }];
    
    
}

@end
