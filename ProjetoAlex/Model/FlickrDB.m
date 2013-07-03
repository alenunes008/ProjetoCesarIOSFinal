//
//  FlickrDB.m
//  ProjetoAlex
//
//  Created by AFLM on 10/05/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#import "FlickrDB.h"
#import "Flickr.h"
@implementation FlickrDB
@synthesize flickrDB = _flickrDB;
@synthesize databasePath = _databasePath;

- (void)deleteFlickr:(Flickr *)contact
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_flickrDB) == SQLITE_OK)
    {
        char *sql = "DELETE FROM FLICKR WHERE  ID = ?;";
        
        if (sqlite3_prepare_v2(_flickrDB,
                               sql, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_int(statement, 1, contact.ID);
            NSLog(@"%d",[contact ID]);

        }
    
        
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Record removed");
        } else {
            NSLog(@"Failed to removed contact");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_flickrDB);
    }
    
}




- (void) saveDados:(Flickr *)flickr
{
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_flickrDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO FLICKR (TITLE, AUTHOR, LINK, DESCRIPTION) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                               [flickr title], [flickr author], [flickr m],[flickr description]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_flickrDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            //            @"Contact added";
            //            self.name.text = @"";
            //            self.address.text = @"";
            //            self.phone.text = @"";
        } else {
            //            self.status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_flickrDB);
    }
}

- (NSArray*) findContact
{
    NSMutableArray * flickrs = [[NSMutableArray alloc]init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_flickrDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ID,TITLE, AUTHOR, LINK, DESCRIPTION FROM FLICKR"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_flickrDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                Flickr *Oflickr =[[Flickr alloc]init];
                
                int ID = sqlite3_column_int(statement, 0);
                [Oflickr setID:ID];
                NSLog(@"ID: %d",ID);
                NSString *title = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                NSLog(@"Title : %@",title);
                [Oflickr setTitle:title];
                
                NSString *author = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 2)];
//                NSLog(@"Author %@", author);
                [Oflickr setAuthor:author];

                
                
                NSString *link = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 3)];
//                NSLog(@"Link %@", link);
                [Oflickr setM:link];
                
                NSString *description = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 4)];
//                NSLog(@"Endereco %@", description);
                [Oflickr setDescription:description];
                [flickrs addObject:Oflickr];
                
  
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(_flickrDB);
    }
    return flickrs;
}

-(void)createDb{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"flickrDB.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        //Criando Tabela
        if (sqlite3_open(dbpath, &_flickrDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS FLICKR (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE, AUTHOR, LINK, DESCRIPTION)";
            
            if (sqlite3_exec(_flickrDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"%@", @"Failed to create table");
            }
            sqlite3_close(_flickrDB);
        } else {
            NSLog(@"%@", @"Failed to open/create database");
        }
    }
  
}
@end
