//
//  CVCell.h
//  CollectionViewExample
//
//  Created by Tim on 9/5/12.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgCell;

-(void)setImageUrl:(NSURL *)url;
@end
