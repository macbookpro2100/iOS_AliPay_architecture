//
//  HomeModule.m
//  DTRipper
//
//  Created by 金秋成 on 2017/4/13.
//  Copyright © 2017年 jinqiucheng1006@live.cn. All rights reserved.
//

#import "HomeModule.h"

@implementation HomeModule
+(NSString *)moduleIndentifier{
    return @"home";
}

-(instancetype)initModule:(DTRipperContext *)context{
    self = [super init];
    if (self) {
        NSLog(@"sjdfkd");
    }
    return self;
}

- (void)moduleSetUp:(DTRipperContext *)context{
    
}

- (void)moduleInit:(DTRipperContext *)context{
    
}

- (void)moduleTearDown:(DTRipperContext *)context{
    
}

- (void)moduleWillResignActive:(DTRipperContext *)context{

}

- (void)moduleDidEnterBackground:(DTRipperContext *)context{

}

- (void)moduleWillEnterForeground:(DTRipperContext *)context{

}

- (void)moduleDidBecomeActive:(DTRipperContext *)context{

}

- (void)moduleWillTerminate:(DTRipperContext *)context{

}

- (void)moduleOpenURL:(DTRipperContext *)context{
    

}


@end
