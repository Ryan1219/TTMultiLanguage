//
//  TTLanguageViewController.m
//  TTSwitchLanguageDemo
//
//  Created by zhangliangwang on 17/4/13.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTLanguageViewController.h"

@interface TTLanguageViewController () <UITableViewDelegate,UITableViewDataSource>

/** <#注释#> **/
@property (nonatomic,strong) UITableView *tableView;
/** <#注释#> **/
@property (nonatomic,strong) NSArray *showLanguageArray;
/** <#注释#> **/
@property (nonatomic,strong) NSArray *languageArray;


/** <#注释#> */
@property (nonatomic,assign) NSInteger selectIndex;



@end

@implementation TTLanguageViewController

- (NSArray *)showLanguageArray {
    if (_showLanguageArray == nil) {
        _showLanguageArray = [[NSArray alloc] initWithObjects:@"Automatic",@"English",@"简体中文", nil];
    }
    return _showLanguageArray;
}

/* <#description#> */
- (NSArray *)languageArray {
    if (_languageArray == nil) {
        _languageArray = [[NSArray alloc] initWithObjects:@"Automatic",@"English",@"Chinese", nil];
    }
    return _languageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = TTLanguage(@"Language");
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSString *keyLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLanguage];
    if (keyLanguage == nil) {
        self.selectIndex = 0;
    } else {
        for (NSString *language in self.languageArray) {
            if ([keyLanguage isEqualToString:language]) {
                 self.selectIndex = [self.languageArray indexOfObject:language];
            }
        }
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    
}

//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.showLanguageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *languageCellIdentifier = @"languageCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:languageCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:languageCellIdentifier];
    }
    
    cell.textLabel.text = self.showLanguageArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (self.selectIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    self.selectIndex = indexPath.row;
    
    if (indexPath.row == 0) {
        [[TTLanguageTool sharedInstance] changeLanguageAction:nil];
        [self saveObjectToUserDefaults:nil key:kCurrentLanguage];
    } else {
        [[TTLanguageTool sharedInstance] changeLanguageAction:self.languageArray[indexPath.row]];
        [self saveObjectToUserDefaults:self.languageArray[indexPath.row] key:kCurrentLanguage];
    }
    
    self.title = TTLanguage(@"Language");
    [self.tableView reloadData];
    
    [self.navigationController popToRootViewControllerAnimated:true];
    
}

//MARK:- 保存
- (void)saveObjectToUserDefaults:(id)object key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dealloc {
    
    NSLog(@"---我被干掉了--%s---",__FUNCTION__);
}

@end












































