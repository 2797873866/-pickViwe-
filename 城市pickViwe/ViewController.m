//
//  ViewController.m
//  城市pickViwe
//
//  Created by ljf on 2017/2/9.
//  Copyright © 2017年 LJF. All rights reserved.
//

#import "ViewController.h"
#import "LJFShopClaimController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LJFShopClaimController * shop = [[LJFShopClaimController alloc] init];
    shop.view.frame = self.view.bounds;
    
    [self addChildViewController: shop];
    [self.view addSubview:shop.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
