//
//  ListViewController.m
//  PieGioFab
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import "ListViewController.h"
#import <STHTTPRequest.h>
#import "ViewController.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *jsonData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSIndexPath *index;


@end

#define kOPEN_DRINK_URL @"http://addb.absolutdrinks.com/quickSearch/drinks/"
#define kOPEN_API @"?apiKey=b37cebedc25249b58eb5adb476c52959"

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", kOPEN_DRINK_URL, self.searchDrink, kOPEN_API];
    
    NSString *safeURL = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    STHTTPRequest *request = [STHTTPRequest requestWithURLString:safeURL];
    
    request.completionBlock = ^(NSDictionary *headers, NSString *body)
    {
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        self.jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
        NSLog(@"%@", self.jsonData);
        
        [self.tableView reloadData];
        
    };
    
    request.errorBlock = ^(NSError *error) {
        
        NSLog(@"%@", error);
    };
    
    [request startAsynchronous];
}


// numero di celle

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jsonData[@"result"] count];
}


// riempire la cella


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = self.jsonData[@"result"][indexPath.row][@"name"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath;
    [self performSegueWithIdentifier:@"Detail" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
    controller.jsonData = self.jsonData[@"result"][self.index.row];
}



@end
