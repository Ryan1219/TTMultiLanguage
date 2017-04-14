//
//  TTLanguageTool.h
//  smarteye
//
//  Created by zhang liangwang on 17/4/13.
//  Copyright © 2017年 envo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TTLanguage(key) [[TTLanguageTool sharedInstance] localizedStringForKey:key]

#define kLanguageChangeNotification @"languageChangeNotification"
#define kServiceLanguageChangeNotification @"serviceLanguageChangeNotification"



@interface TTLanguageTool : NSObject

//单例
+ (instancetype)sharedInstance;

/**
 *  根据语言key获取对应的语言
 *  @param key 最初语言
 *  @return 返回设置语言
 */
- (NSString *)localizedStringForKey:(NSString *)key;


/**
 *  切换语言
 *  @param language 语种名字
 */
- (void)changeLanguageAction:(NSString *)language;

/**
 *  设置语种
 *  @param newLanguage 语种名字
 *  @return 是否设置成功
 */
//- (BOOL)setLanguage:(NSString*)newLanguage isAuto:(BOOL)isAuto;




@end










































