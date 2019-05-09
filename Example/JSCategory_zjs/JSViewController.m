//
//  JSViewController.m
//  JSCategory_zjs
//
//  Created by zSky on 05/08/2019.
//  Copyright (c) 2019 zSky. All rights reserved.
//

#import "JSViewController.h"
#import <JSCategory_zjs.h>
@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *zjsStr = @"15060400611";
    BOOL isNumber = [zjsStr js_validatePhoneNO];
    NSLog(@"%@",isNumber?@"是电话号码":@"不是电话花吗");
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
