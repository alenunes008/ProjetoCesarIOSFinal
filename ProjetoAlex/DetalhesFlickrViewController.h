//
//  DetalhesFlickrViewController.h
//  Exercicio01
//
//  Created by Jalan Solutions on 04/06/12.
//  Copyright (c) 2012 Jalan Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <sqlite3.h>


@class Flickr;
@class MBProgressHUD;
@interface DetalhesFlickrViewController : UIViewController<UIActionSheetDelegate>{
//    NSMutableDictionary *dicFlick;
    UILabel * _lbTitulo;
    UILabel * _lbAutor;
    UILabel * _lbDescricao;
    UIImageView * _imageFlicker;
    
    
    
    IBOutlet UIImageView* _imageView;
    IBOutlet UIScrollView *_scrollview;
    
    UIImageView* pin;
    CGPoint position;
    BOOL pinVisible;
    
    BOOL _zoomed;
    
    BOOL shouldMakeRegionsAvailable;
    NSMutableArray *_regionRects;
    



}
//@property (strong, nonatomic) NSString *databasePath;
//@property (nonatomic) sqlite3 *contactDB;
@property (assign) NSString*nomMenu;
@property (assign) BOOL pinVisible;
@property (assign) CGPoint position;
@property BOOL shouldMakeRegionsAvailable;


@property(nonatomic)NSUInteger index;
@property(nonatomic,strong)Flickr *flickr;
@property(nonatomic)BOOL flagFavorito;

@property (retain, nonatomic) IBOutlet UILabel *lbTitulo;
@property (retain, nonatomic) IBOutlet UILabel *lbAutor;
@property (retain, nonatomic) IBOutlet UILabel *lbDescricao;
@property (retain, nonatomic) IBOutlet UIImageView *imageFlicker;




@end
