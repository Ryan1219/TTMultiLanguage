//
//  TTPersonViewController.m
//  TTSwitchLanguageDemo
//
//  Created by zhangliangwang on 17/4/13.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTPersonViewController.h"
#import "TTLanguageViewController.h"

@interface TTPersonViewController ()

/** <#注释#> **/
@property (nonatomic,strong) UILabel *nameLable;


@end

@implementation TTPersonViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = TTLanguage(@"Person");
    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    self.nameLable.text = TTLanguage(@"Person");
    self.nameLable.textColor = [UIColor redColor];
    self.nameLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.nameLable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    TTLanguageViewController *language = [[TTLanguageViewController alloc] init];
    [self.navigationController pushViewController:language animated:true];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
