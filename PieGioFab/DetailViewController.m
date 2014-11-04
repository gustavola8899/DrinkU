//
//  DetailViewController.m
//  PieGioFab
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
#import "ListViewController.h"
#import <STHTTPRequest.h>



@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nomeL;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *ingredientiL;
@property (weak, nonatomic) IBOutlet UILabel *descrizioneL;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *ingredientiT;
@property (weak, nonatomic) IBOutlet UILabel *descrizioneT;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *buttonVideo;



#define kOPEN_IMG @"http://assets.absolutdrinks.com/drinks/solid-background-black/soft-shadow/floor-reflection/300x300/"
#define KOPEN_PNG @".png"
#define kOPEN_URL_VIDEO @"https://www.youtube.com/watch?v="

@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.nomeL.text = self.jsonData[@"name"];
    self.descrizioneT.text = self.jsonData[@"descriptionPlain"];
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    NSMutableString *ingredientsList = [NSMutableString string];
    
    for (NSDictionary *ingredient in self.jsonData[@"ingredients"]) {
        [ingredientsList appendFormat:@"%@\n", ingredient[@"textPlain"]];
        
    }
    
    self.ingredientiT.text = ingredientsList;
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", kOPEN_IMG, self.jsonData[@"id"], KOPEN_PNG];
    
    NSString *safeURL = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"%@", safeURL);
    
    STHTTPRequest *request = [STHTTPRequest requestWithURLString:safeURL];
    
    request.completionDataBlock = ^(NSDictionary *headers, NSData *body)
    {
        UIImage *image = [UIImage imageWithData:body];
        
        self.img.image = image;
        
        [self.indicatorView stopAnimating];
        
    };
    
    request.errorBlock = ^(NSError *error) {
        
    };
    
    [request startAsynchronous];
    
}

-(void)viewDidLayoutSubviews
{
        NSLog(@"%@", NSStringFromCGRect(self.scrollView.bounds));
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.buttonVideo.frame.origin.y + self.buttonVideo.frame.size.height + 20);
}
- (IBAction)actionVideo:(id)sender
{
    NSString *videoUrl = [NSString stringWithFormat:@"%@%@", kOPEN_URL_VIDEO, self.jsonData[@"videos"][0][@"video"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:videoUrl]];
}

@end
