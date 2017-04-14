//
//  TTLanguageTool.m
//  smarteye
//
//  Created by zhang liangwang on 17/4/13.
//  Copyright © 2017年 envo. All rights reserved.
//

#import "TTLanguageTool.h"



@interface TTLanguageTool() 

/** 当前语言 **/
@property (nonatomic,copy) NSString *currentLanguage;

/** 用字典包装语言包 **/
@property (nonatomic,strong) NSDictionary *dicLocalLanguage;

@end

@implementation TTLanguageTool

//MARK:-单例
static  id _instance;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

//MARK:- 根据语言key获取对应的语言
- (NSString *)localizedStringForKey:(NSString *)key {
    
    if (key == nil) {
        return @"";
    }
    if (self.dicLocalLanguage == nil) {
        return key;
    } else {
        NSString *localString = self.dicLocalLanguage[key];
        if (localString == nil) {
            return key;
        } else {
            return localString;
        }
    }
}

/**
 *  设置语种
 *  @param newLanguage 语种名字
 *  @return 是否设置成功
// */
//- (BOOL)setLanguage:(NSString *)newLanguage isAuto:(BOOL)isAuto {
//    
//    if (newLanguage == nil || [newLanguage isEqualToString:self.currentLanguage]) {
//        return false;
//    }
//    
//    NSString *systemLanguage = [self matchShowLanguageWithSimple:[NSLocale preferredLanguages].firstObject];
//    if ([newLanguage isEqualToString:systemLanguage]) {
//        self.currentLanguage = newLanguage;
//        self.dicLocalLanguage = nil;
//        //发出语言改变通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLanguageChangeNotification object:nil];
//        return true;
//    } else {
//        BOOL isLodaingOK = [self localizedStringForKey:newLanguage];
//        if (isLodaingOK) {
//            //发出语言改变通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLanguageChangeNotification object:nil];
//            [self saveObjectToUserDefaults:newLanguage key:kCurrentLanguage];
//        }
//        
//        if (self.currentLanguage == nil) {
//            self.currentLanguage = @"English";
//        }
//        return isLodaingOK;
//    }
//    
//}

//MARK:-获取语言包内容
- (void)loadDictionaryForLanguage:(NSString *)language {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"strings"];
    if (path == nil) {
//        return false;
    } else {
        NSURL *url = [NSURL fileURLWithPath:path];
        if ([[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
            self.dicLocalLanguage = [NSDictionary dictionaryWithContentsOfFile:url.path];
//            return true;
        } else {
//            return false;
        }
    }
}


//MARK:-根据语言简写，获取其对应的名字（设置语言对应的名字）主要针对第一次启动应用
- (NSString *)matchShowLanguageWithSimple:(NSString *)simpleLanguage {
    
    if ([simpleLanguage hasPrefix:@"en"]) {
        return @"English";
    } else if ([simpleLanguage hasPrefix:@"zh"]){
        return @"Chinese";
    } else {
        return @"English";
    }
}

//MARK:- 根据language匹配服务器的语言
- (void)matchServiceLanguage:(NSString *)language {
    
    NSString *serviceLanguage = nil;
    if ([language isEqualToString: @"English"]) {
        serviceLanguage = @"en";
    } else if ([language isEqualToString: @"Chinese"]) {
        serviceLanguage = @"zh";
    } else {
        serviceLanguage = @"en";
    }
    [self saveObjectToUserDefaults:serviceLanguage key:kServiceLanguage];
}

//MARK:- 切换语言
- (void)changeLanguageAction:(NSString *)language {
    
    if (language == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        self.currentLanguage = language;
        [self loadDictionaryForLanguage:[self matchShowLanguageWithSimple:language]];
    } else {
        [self loadDictionaryForLanguage:language];
        // 匹配系统语言
        [self matchServiceLanguage:language];
    }
    
    //发出语言改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kLanguageChangeNotification object:nil];
}

//MARK:- 保存
- (void)saveObjectToUserDefaults:(id)object key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




@end




















































