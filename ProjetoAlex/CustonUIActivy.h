//
//  CustonUIActivy.h
//  ProjetoActiveYndicator
//
//  Created by AFLM on 11/05/13.
//  Copyright (c) 2013 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Flickr;
@interface CustonUIActivy : UIActivityItemProvider<UIActivityItemSource>

@property(nonatomic)UIImage *oFlickr;
-(id)initWithFlickrDados:(UIImage *)flickr;

@end
@interface APActivityIcon : UIActivity
@property(nonatomic)Flickr *oFlickr;
@property(nonatomic,retain)NSString *title;
@property(nonatomic)BOOL flagFavorito;
-(id)initWithFlickrDados:(Flickr *)flickr;

@end
