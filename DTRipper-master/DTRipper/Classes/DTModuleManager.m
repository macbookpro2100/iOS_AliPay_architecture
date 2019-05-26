//
//  DTModuleManager.m
//  Pods
//
//  Created by 金秋成 on 2017/4/12.
//
//

#import "DTModuleManager.h"
#import "DTModuleProtocol.h"
#import "DTRipper.h"



@interface DTModuleManager ()

@property (nonatomic,strong)NSMutableSet<id<DTModuleProtocol>> * modules;

@end

@implementation DTModuleManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modules = [[NSMutableSet alloc]initWithCapacity:0];
    }
    return self;
}


-(void)addModulesFilePath:(NSString *)modulesFilePath{
    __weak typeof(self) weakSelf = self;
    NSArray<NSString *> * moduleNameArr = [[NSArray alloc]initWithContentsOfFile:modulesFilePath];
    if (moduleNameArr == nil) {
        DTLog(@"The Modules File must be plist file contains the array data,please check and make it work!");
        return;
    }

    [moduleNameArr enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Class class = NSClassFromString(obj);
        if (class == 0x0) {
            DTLog(@"Did not found class called '%@' ",obj);
        }
        else{
            [weakSelf addModule:NSClassFromString(obj)];
        }
    }];
   
}


-(void)addModules:(NSArray<Class> *)moduleClasses{
    __weak typeof(self) weakSelf = self;
    [moduleClasses enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf addModule:obj];
    }];
}


-(void)addModule:(Class)moduleClass{
    
    NSString * identifier = [self getModuleIdentifierWithClass:moduleClass];
    if (!identifier) return;
    
    if (![self isModuleExist:identifier]) {
        id<DTModuleProtocol> moduleObj = [[moduleClass alloc] initModule:[DTRipper sharedInstance].context];
        [self.modules addObject:moduleObj];
        DTLog(@"Add module called '%@' success",identifier);
    }
    else{
        DTLog(@"Module called '%@' is already exist",identifier);
    }
}

-(void)removeModuleWithIdentifier:(NSString *)moduleIdentifier{
    id<DTModuleProtocol> module = [self moduleWithIdentifier:moduleIdentifier];
    if (module) {
        [self.modules removeObject:module];
        DTLog(@"Module called '%@' removed success",moduleIdentifier);
    }
    else{
        DTLog(@"Module called '%@' doesn't exist",moduleIdentifier);
    }
}



-(BOOL)isModuleExist:(NSString *)moduleIdentifier{
    if ([self moduleWithIdentifier:moduleIdentifier]) {
        return YES;
    }
    return NO;
}

-(id<DTModuleProtocol>)moduleWithIdentifier:(NSString *)moduleIdentifier{
    if (moduleIdentifier) {
        for (id<DTModuleProtocol> module in self.modules) {
            NSString * identifier = [self getModuleIdentifierWithClass:[module class]];
            if (!identifier) return nil;
            if ([identifier isEqualToString:moduleIdentifier]) {
                return module;
            }
        }
        return nil;
    }
    return nil;
}

-(NSString *)getModuleIdentifierWithClass:(Class)moduleClass{

    if (![moduleClass conformsToProtocol:@protocol(DTModuleProtocol)]) {
        DTLog(@"'%@' did not conforms to protocol 'DTModuleProtocol'",NSStringFromClass(moduleClass));
        return nil;
    }
    
    if (![moduleClass respondsToSelector:@selector(moduleIndentifier)]) {
        DTLog(@"'%@' did not responder to protocol 'DTModuleProtocol' class method '%@'",NSStringFromClass(moduleClass),NSStringFromSelector(@selector(moduleIndentifier)));
        return nil;
    }
    
    NSMethodSignature * ms = [moduleClass methodSignatureForSelector:@selector(moduleIndentifier)];
    NSString * identifier = nil;
    NSInvocation * iv = [NSInvocation invocationWithMethodSignature:ms];
    iv.target = moduleClass;
    iv.selector = @selector(moduleIndentifier);
    [iv invoke];
    [iv getReturnValue:&identifier];
    return identifier;
}

-(NSSet *)getAllModule{
    return self.modules;
}

@end
