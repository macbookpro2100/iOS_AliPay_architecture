//
//  DTRipperContext.h
//  Pods
//
//  Created by 金秋成 on 2017/4/13.
//
//

#import <Foundation/Foundation.h>

@interface DTRipperContext : NSObject

@property (nonatomic,strong)NSString * envKey;

@property (nonatomic,strong)UIApplication * application;

@property (nonatomic, strong)NSDictionary * launchOptions;

@property (nonatomic, strong)NSDictionary * openURLOptions;

@property (nonatomic, strong)NSURL        * openURL;

@property (nonatomic, strong)NSString     * sourceApplication;

@property (nonatomic, strong)id             annotation;

@end
