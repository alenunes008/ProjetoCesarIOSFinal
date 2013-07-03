//
//  FlickrDB.h
//  ProjetoAlex
//
//  Created by AFLM on 10/05/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class Flickr;

@interface FlickrDB : NSObject{
    
}

@property(nonatomic)sqlite3 *flickrDB;
@property(nonatomic)NSString *databasePath;

//- (void)createDatabase;
//- (void)insertContact:(Flickr *)flickr;
//- (NSArray *)getAllContacts;

-(void)saveDados:(Flickr *)flickr;
-(void)createDb;
- (NSArray*) findContact;
- (void)deleteFlickr:(Flickr *)contact;


@end
