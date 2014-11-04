//
//  ViewController.m
//  PieGioFab
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "ViewController.h"
#import <STHTTPRequest.h>
#import "DetailViewController.h"
#import "ListViewController.h"


@interface ViewController () 

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController


- (void)viewDidLoad
{
        [super viewDidLoad];
}

// passaggio dei dati

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ListViewController *controller = (ListViewController *)segue.destinationViewController;
    controller.searchDrink = self.textField.text;
    
}

// tastiera che sale

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self performSegueWithIdentifier:@"Search" sender:self];
    return NO;
}


@end
