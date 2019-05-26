//
//  DTRipper.m
//  Pods
//
//  Created by 金秋成 on 2017/4/13.
//
//

#import "DTRipper.h"




static DTRipper * _sharedRipper;

@interface DTRipper ()

@end


@implementation DTRipper

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRipper = [[DTRipper alloc]init];
    });
    return _sharedRipper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _moduleManager = [[DTModuleManager alloc]init];
        _context       = [[DTRipperContext alloc] init];
        _appDelegate   = [[DTRipperAppDelegate alloc]init];
    }
    return self;
}

@end
