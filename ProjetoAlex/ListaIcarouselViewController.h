//
//  MenuFotosViewController.h
//  TesteAlex2
//
//  Created by Jalan Solutions on 26/11/12.
//  Copyright (c) 2012 Jalan Tecnologia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@class iCarousel;
@class DownloadImageView;

@interface ListaIcarouselViewController : UIViewController<iCarouselDataSource,iCarouselDelegate>{
//    Dadosfeeds *_dados; 
}
@property (nonatomic,) IBOutlet DownloadImageView *carImg;
@property (nonatomic) IBOutlet iCarousel *carousel;




@end
