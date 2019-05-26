//
//  DTRipper.h
//  Pods
//
//  Created by 金秋成 on 2017/4/13.
//
//

#import <Foundation/Foundation.h>
#import "DTModuleManager.h"
#import "DTRipperAppDelegate.h"
#import "DTRipperContext.h"

@interface DTRipper : NSObject

@property (nonatomic,strong,readonly)DTModuleManager * moduleManager;

@property (nonatomic,strong,readonly)DTRipperContext * context;

@property (nonatomic,strong,readonly)DTRipperAppDelegate * appDelegate;

+(instancetype)sharedInstance;

@end
