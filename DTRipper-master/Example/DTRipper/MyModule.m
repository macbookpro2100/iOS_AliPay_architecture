//
//  MyModule.m
//  DTRipper
//
//  Created by 金秋成 on 2017/4/13.
//  Copyright © 2017年 jinqiucheng1006@live.cn. All rights reserved.
//

#import "MyModule.h"

@implementation MyModule

+(NSString *)moduleIndentifier{
    return @"my";
}

-(instancetype)initModule:(DTRipperContext *)context{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)moduleSetUp:(DTRipperContext *)context{
    
}


@end
