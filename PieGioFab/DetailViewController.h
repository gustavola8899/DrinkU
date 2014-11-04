//
//  DetailViewController.h
//  PieGioFab
//
//  Created by Studente on 28/10/14.
//  Copyright (c) 2014 Studente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, weak) NSString *name;
@property (nonatomic, strong) NSDictionary *jsonData;
@end
