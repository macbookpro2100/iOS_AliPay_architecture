//
//  DTModuleProtocol.h
//  Pods
//
//  Created by 金秋成 on 2017/4/12.
//
//

#ifndef DTModuleProtocol_h
#define DTModuleProtocol_h

@class DTRipperContext;

@protocol DTModuleProtocol <NSObject>
@required

+(NSString *)moduleIndentifier;

/*!
 @method
 @abstract   Don't invoke other modules thing
 @discussion If you invoke
 */
- (instancetype)initModule:(DTRipperContext *)context;

@optional

- (void)moduleSetUp:(DTRipperContext *)context;

- (void)moduleTearDown:(DTRipperContext *)context;

- (void)moduleWillResignActive:(DTRipperContext *)context;

- (void)moduleDidEnterBackground:(DTRipperContext *)context;

- (void)moduleWillEnterForeground:(DTRipperContext *)context;

- (void)moduleDidBecomeActive:(DTRipperContext *)context;

- (void)moduleWillTerminate:(DTRipperContext *)context;

- (void)moduleOpenURL:(DTRipperContext *)context;

@end



#endif /* DTModuleProtocol_h */
