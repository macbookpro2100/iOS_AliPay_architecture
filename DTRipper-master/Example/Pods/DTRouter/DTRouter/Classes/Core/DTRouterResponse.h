//
//  DTRouterResponse.h
//  Pods
//
//  Created by 金秋成 on 2017/2/21.
//
//

#import <Foundation/Foundation.h>
#import "DTURLPattern.h"
@interface DTRouterResponse : NSObject

@property (nonatomic,strong)DTURLPattern * pattern;

@property (nonatomic,strong)NSError * error;

@property (nonatomic,strong)id resultValue;

@end
