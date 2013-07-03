//
//  ViewController.m
//  CollectionViewExample
//
//  Created by Tim on 9/5/12.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "ListCollectionViewController.h"
//view controller
#import "MenuViewController.h"
#import "DetalhesFlickrViewController.h"
#import "CVCell.h"

//model
#import "Dadosfeeds.h"
#import "Flickr.h"
#import "FlickrDB.h"

//protocolos
#import "TabBarPersonProtocolo.h"

@interface ListCollectionViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ListCollectionViewController
@synthesize flickrs = _flickrs;
@synthesize flagFavorito = _flagFavorito;

BARRA_PADRAO

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[Util layout:self :@"Flickr":tpLista];
    [Util layout:self titulobar:@"Collection" tipoIconeBarra:tpLista];
    
        
    /* uncomment this block to use subclassed cells */
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    /* end of subclass-based cells block */
    
    // Configure layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(106,75)];
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.headerReferenceSize = CGSizeMake(44, 46);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_collection reloadData];
    
    
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.collectionView = nil;
    self.dataArray = nil;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
   // return [[_dados descMedia] count];
    return [_flickrs count];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cvCell";

        
    /* Uncomment this block to use subclass-based cells */
    CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    dispatch_async(dispatch_get_main_queue(), ^{
        Flickr *flickr = [_flickrs objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:
                    [flickr m]];
       // NSLog(@"URL: %@",[flickr m]);
        
        [cell setImageUrl:url];
        
    });
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetalhesFlickrViewController *dtx = [[DetalhesFlickrViewController alloc]init];
    dtx.index = indexPath.row;
    
    Flickr *flickr;

    if (_flagFavorito == TRUE) {
      flickr =  [_flickrs objectAtIndex:indexPath.row];
        dtx.flickr = flickr;
        dtx.flagFavorito = TRUE;
        
        
    }else{
       flickr = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:indexPath.row];
        dtx.flickr = flickr;
        dtx.flagFavorito = FALSE;
    
    }


    [self.navigationController pushViewController:dtx animated:YES];
}


@end
