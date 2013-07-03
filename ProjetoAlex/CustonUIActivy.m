//
//  CustonUIActivy.m
//  ProjetoActiveYndicator
//
//  Created by AFLM on 11/05/13.
//  Copyright (c) 2013 Alex. All rights reserved.
//

#import "CustonUIActivy.h"
#import "Flickr.h"
#import "FlickrDB.h"

@implementation APActivityIcon

-(id)initWithFlickrDados:(Flickr *)flickr
{
    self = [super init];
    if (self) {
        _oFlickr = flickr;
    }
    return self;
}

- (NSString *)activityType
{
    return @"favorito";
}
- (NSString *)activityTitle {
    return _title;
}
- (UIImage *) activityImage {
    return [UIImage imageNamed:@"favorito.png"];
}
- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems
{ return YES;
}
- (void) prepareWithActivityItems:(NSArray *)activityItems
{
}

- (UIViewController *) activityViewController
{
    return nil;

}

- (void) performActivity {
    if (_flagFavorito == NO) {
        FlickrDB *flickrDB = [[FlickrDB alloc]init];
        [flickrDB createDb];
        [flickrDB saveDados:_oFlickr];
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"MSG" message:@"Foto Adicionado aos Favoritos com sucesso!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
        [self activityDidFinish:NO];
        
    }else{
    
        FlickrDB *flickrDB = [[FlickrDB alloc]init];
        [flickrDB createDb];
        [flickrDB deleteFlickr:_oFlickr];
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"MSG" message:@"Foto removida com sucesso!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
        [self activityDidFinish:NO];
        
     
    
    
    }
    
}


@end

@implementation CustonUIActivy
@synthesize oFlickr = _oFlickr;


-(id)initWithFlickrDados:(UIImage *)flickr;
{
    self = [super init];
    if (self) {

        _oFlickr = flickr;
        
    }
    return self;

}
#pragma mark UIActivityItemSource
- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return @"";
}
// called to determine data type
- (id) activityViewController:(UIActivityViewController *)activityViewController
          itemForActivityType:(NSString *)activityType
{    
    if ( [activityType isEqualToString:UIActivityTypePostToTwitter]||
                     [activityType isEqualToString:UIActivityTypePostToFacebook]||
                                       [activityType isEqualToString:UIActivityTypeMail] )
    {
        return _oFlickr;
    }else if([activityType isEqualToString:@"favorito"])
    {
       return @"";
    }
      return nil;
}// called to fetch data

@end
