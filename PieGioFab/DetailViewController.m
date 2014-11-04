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

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nomeL;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *ingredientiL;
@property (weak, nonatomic) IBOutlet UITextView *ingredientiT;
@property (weak, nonatomic) IBOutlet UILabel *descrizioneL;
@property (weak, nonatomic) IBOutlet UITextView *descrizioneT;





@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nomeL.text = self.jsonData[@"name"];
    self.descrizioneT.text = self.jsonData[@"descriptionPlain"];
    
}




@end
