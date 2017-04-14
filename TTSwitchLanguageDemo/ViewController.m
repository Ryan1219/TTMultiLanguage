//
//  ViewController.m
//  TTSwitchLanguageDemo
//
//  Created by zhangliangwang on 17/4/13.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "ViewController.h"
#import "TTPersonViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = TTLanguage(@"HomePage");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChangeNotification) name:kLanguageChangeNotification object:nil];
    
    
    
}

- (void)languageChangeNotification {
    
    self.title = TTLanguage(@"HomePage");
    NSString *serveceLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kServiceLanguage];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    TTPersonViewController *person = [[TTPersonViewController alloc] init];
    [self.navigationController pushViewController:person animated:true];
    
}












@end





















