//
//  DownloadImageView.h
//  Aula03TabBarController
//
//  Created by CESAR_EDU on 3/23/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImageView : UIImageView
{
    NSString *url;
    NSOperationQueue *queue;
}

@property(nonatomic,copy)NSString * url;


@end
