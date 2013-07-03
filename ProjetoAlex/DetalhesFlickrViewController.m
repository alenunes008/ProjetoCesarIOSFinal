#import "DetalhesFlickrViewController.h"

//componentes
#import "MBProgressHUD.h"

//model
#import "Flickr.h"
#import "Dadosfeeds.h"
#import "FlickrDB.h"

//ViewController
#import "TabelaViewCell.h"

//UTIL
#import "CustonUIActivy.h"
#define ZOOM_STEP 0.7

@interface DetalhesFlickrViewController ()
{

    __block UIImage *image;


}
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation DetalhesFlickrViewController
@synthesize lbTitulo = _lbTitulo;
@synthesize lbAutor = _lbAutor;
@synthesize lbDescricao = _lbDescricao;
@synthesize imageFlicker = _imageFlicker;
@synthesize flickr = _flickr;
@synthesize index = _index;
@synthesize pinVisible ;
@synthesize shouldMakeRegionsAvailable;
@synthesize position ;
@synthesize flagFavorito = _flagFavorito;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  [Util layout:self :@"Detalhes FLICKER":tpDetalhes];
    [Util layout:self titulobar:@"Detalhes" tipoIconeBarra:tpDetalhes];
    
    
    //_flickr = [[[Dadosfeeds defaultHandler]loadDados]objectAtIndex:_index];
    
        _lbTitulo.text    = _flickr.title;
        _lbAutor.text     = _flickr.author ;
        _lbDescricao.text = _flickr.description;
    NSLog (@"Value of my BOOL = %@", _flagFavorito ? @"YES" : @"NO");

    
    
    // add gesture recognizers to the image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [doubleTap setNumberOfTapsRequired:2];
    
    [_imageView addGestureRecognizer:singleTap];
    [_imageView addGestureRecognizer:doubleTap];
    
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [_scrollview frame].size.width  / [_imageView frame].size.width;
//    
    [_scrollview setMinimumZoomScale:minimumScale];
    [_scrollview setZoomScale:minimumScale];
}


-(void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSURL   *url = [NSURL URLWithString:[_flickr m]];
        NSData  *data = [[NSData alloc]initWithContentsOfURL:url];
        image  = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            _imageView.image = image;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        //
    });
    
}

- (void)viewDidUnload
{
    [self setLbTitulo:nil];
    [self setImageFlicker:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma -mark metodos do actionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        FlickrDB *flickrDB = [[FlickrDB alloc]init];
        [flickrDB createDb];
        [flickrDB saveDados:_flickr];
    
}

-(void)actionShared{
    CustonUIActivy *ActivityProvider = [[CustonUIActivy alloc] initWithFlickrDados:image];
    
    UIImage *ImageAtt = [UIImage imageNamed:@"favoritosRemover.png"];
    NSArray *Items =[[NSArray alloc]initWithObjects:ActivityProvider,ImageAtt, nil];
    
    APActivityIcon *ca = [[APActivityIcon alloc] initWithFlickrDados:_flickr];
    NSArray *Acts = @[ca];
    if (_flagFavorito == YES) {
        ca.flagFavorito = YES;
        ca.title = @"Remover dos Favoritos";
    }else{
        ca.flagFavorito = NO;
        ca.title = @"Adicionar aos Favoritos";
    
    }
     
    
    UIActivityViewController *ActivityView = [[UIActivityViewController alloc]
                                              initWithActivityItems:Items
                                              applicationActivities:Acts] ;
    [ActivityView setExcludedActivityTypes:
     @[UIActivityTypeAssignToContact,
     UIActivityTypeCopyToPasteboard,
     UIActivityTypePrint,
     UIActivityTypeSaveToCameraRoll,
     UIActivityTypePostToWeibo
     ]];
    
    
    [self presentViewController:ActivityView animated:YES completion:nil];
    [ActivityView setCompletionHandler:^(NSString *act, BOOL done)
     {
         NSString *ServiceMsg = nil;
         if ( [act isEqualToString:UIActivityTypeMail] )           ServiceMsg = @"Mail sended!";
         if ( [act isEqualToString:UIActivityTypePostToTwitter] )  ServiceMsg = @"Post on twitter, ok!";
         if ( [act isEqualToString:UIActivityTypePostToFacebook] ) ServiceMsg = @"Post on facebook, ok!";
         if ( done )
         {
             UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:ServiceMsg message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
             [Alert show];
         }
     }];
    
    


}


#pragma -mark
-(void)actionVoltar{
    if (_flagFavorito == YES) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //    [self pinPosition];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    CGFloat newScale = 0;
    if (_scrollview.zoomScale > _scrollview.minimumZoomScale) {
        newScale = _scrollview.minimumZoomScale;
    } else {
        newScale = _scrollview.maximumZoomScale;
    }
    
    if (_scrollview.minimumZoomScale < _scrollview.maximumZoomScale) {
        
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        
        [_scrollview zoomToRect:zoomRect animated:YES];
        
    }
    
}


#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [_scrollview frame].size.height / scale;
    zoomRect.size.width  = [_scrollview frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;}



@end