//
//  ViewController.m
//  DPPassword
//
//  Created by Heaven on 2017/12/7.
//  Copyright © 2017年 heaven. All rights reserved.
//

#import "ViewController.h"
#import "DPPasswordView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pw;

@end

@implementation ViewController
- (IBAction)pay:(id)sender {
    [DPPasswordView showPaddwordViewBack:^(NSString *passWord) {
        
        self.pw.text = passWord;
        
    } cancle:^{
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
