//
//  DTModuleManager.h
//  Pods
//
//  Created by 金秋成 on 2017/4/12.
//
//

#import <Foundation/Foundation.h>

@protocol DTModuleProtocol;

@interface DTModuleManager : NSObject

-(void)addModulesFilePath:(NSString *)modulesFilePath;

-(void)addModules:(NSArray<Class> *)moduleClasses;

-(void)addModule:(Class)moduleClass;

-(void)removeModuleWithIdentifier:(NSString *)moduleIdentifier;

-(BOOL)isModuleExist:(NSString *)moduleIdentifier;

-(id<DTModuleProtocol>)moduleWithIdentifier:(NSString *)moduleIdentifier;

-(NSSet<id<DTModuleProtocol>> *)getAllModule;

@end
