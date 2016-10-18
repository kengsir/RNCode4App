//
//  ViewController.m
//  Code4App
//
//  Created by Kengsir on 2016/10/16.
//  Copyright © 2016年 com.imessage. All rights reserved.
//

#import "C4TabBarViewController.h"

@interface C4TabBarViewController ()

@end

@implementation C4TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self conFigureTabBar];
    
    [self conFigureChildViewControllers];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
}


- (void)conFigureTabBar {
    self.tabBar.shadowImage = [UIImage imageNamed:@"tabbartop-line"];
    
}

- (void)conFigureChildViewControllers {
    
    
}

#pragma mark - add childVc


@end
