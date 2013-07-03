//
//  DownloadImageView.m
//  Aula03TabBarController
//
//  Created by CESAR_EDU on 3/23/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DownloadImageView.h"
#import "MBProgressHUD.h"

#define LOG_ON YES
#define CACHE YES

@implementation DownloadImageView
@synthesize url = _url;

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
      
    }
    return self;

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
}

-(void)setUrl:(NSString *)urlParam
{
    if ([urlParam length] == 0) {
        self.url = nil;
        self.image = nil;
        
    }else if(urlParam != _url)
    {
        url  = [urlParam copy];
        self.image = nil;
        if (!queue) {
            queue = [[NSOperationQueue alloc]init];
        }
        [queue cancelAllOperations];
        [MBProgressHUD showHUDAddedTo:self animated:YES];

        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self 
                                                                               selector:@selector(downloadImg) object:nil];
        [queue addOperation:operation];
    }
    
}
-(void)downloadImg
{
    NSString * file = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    file  =   [file stringByReplacingOccurrencesOfString:@"\\" withString:@"_"];
    file  =   [file stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    file  =   [@"Documents/" stringByAppendingString:[NSString stringWithFormat:@"%@",file]];
    
    file  =  [NSHomeDirectory()stringByAppendingString:[NSString stringWithFormat:@"%@",file]];
    
    if (LOG_ON && CACHE) {
        NSLog(@"%@",file);
    }
    
    if (CACHE && [[NSFileManager defaultManager]fileExistsAtPath:file]) {
        NSData *data = [NSData dataWithContentsOfFile:file];
        if (data) {
            if (LOG_ON) {
                NSLog(@"Imagem encontrada em cache: %@",url);
            }
            UIImage *img = [[UIImage alloc]initWithData:data];
            [self performSelectorOnMainThread:@selector(show:) withObject:img waitUntilDone:YES];
            return;
            
        }
    }  
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    if (CACHE) {
        NSLog(@"Salvar cache");
        [data writeToFile:file atomically:YES];
    }
    
    [self performSelectorOnMainThread:@selector(showImg:) withObject:img waitUntilDone:YES];

}

-(void)showImg:(UIImage*)imagem
{
    self.image  = imagem;
    [MBProgressHUD hideAllHUDsForView:self animated:YES];

}


-(void)dealloc{
    
}
@end
