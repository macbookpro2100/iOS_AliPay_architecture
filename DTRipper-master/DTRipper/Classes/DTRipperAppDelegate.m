//
//  DTRipperAppDelegate.m
//  Pods
//
//  Created by 金秋成 on 2017/4/12.
//
//

#import "DTRipperAppDelegate.h"
#import "DTRipper.h"
#import "DTRipperContext.h"
#import "DTModuleManager.h"
#import "DTModuleProtocol.h"

//- (void)moduleSetUp:(DTRipperContext *)context;
//
//- (void)moduleTearDown:(DTRipperContext *)context;
//
//- (void)moduleWillResignActive:(DTRipperContext *)context;
//
//- (void)moduleDidEnterBackground:(DTRipperContext *)context;
//
//- (void)moduleWillEnterForeground:(DTRipperContext *)context;
//
//- (void)moduleDidBecomeActive:(DTRipperContext *)context;
//
//- (void)moduleWillTerminate:(DTRipperContext *)context;
//
//- (void)moduleOpenURL:(DTRipperContext *)context;


typedef NS_ENUM(NSUInteger, DTApplicationEventType) {
    DTApplicationEventType_setup,
    DTApplicationEventType_tearDown,
    DTApplicationEventType_willResignActive,
    DTApplicationEventType_didEnterBackground,
    DTApplicationEventType_willEnterForeground,
    DTApplicationEventType_didBecomeActive,
    DTApplicationEventType_willTerminate,
    DTApplicationEventType_openURL,
    DTApplicationEventType_recieveMemoryWarning,
    
};


@implementation DTRipperAppDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        //TODO:注册通知中心
    }
    return self;
}


-(void)dealloc{
    //TODO:移除通知
}


-(void)applicationEventHandler:(DTApplicationEventType)eventType{
    
    NSSet<id<DTModuleProtocol>> * moduleSet = [[DTRipper sharedInstance].moduleManager getAllModule];
    SEL selector = @selector(moduleSetUp:);
    switch (eventType) {
        case DTApplicationEventType_setup:
            selector = @selector(moduleSetUp:);
            break;
        case DTApplicationEventType_tearDown:
            selector = @selector(moduleTearDown:);
            break;
        case DTApplicationEventType_willResignActive:
            selector = @selector(moduleWillResignActive:);
            break;
        case DTApplicationEventType_didEnterBackground:
            selector = @selector(moduleDidEnterBackground:);
            break;
        case DTApplicationEventType_willEnterForeground:
            selector = @selector(moduleWillEnterForeground:);
            break;
        case DTApplicationEventType_didBecomeActive:
            selector = @selector(moduleDidBecomeActive:);
            break;
        case DTApplicationEventType_willTerminate:
            selector = @selector(moduleWillTerminate:);
            break;
        case DTApplicationEventType_openURL:
            selector = @selector(moduleOpenURL:);
            break;
        default:
            break;
    }
    
    [moduleSet enumerateObjectsUsingBlock:^(id<DTModuleProtocol>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:selector]) {
            DTLog(@"%@ is selector : %@ called",NSStringFromClass([obj class]),NSStringFromSelector(selector));
            [obj performSelector:selector withObject:[DTRipper sharedInstance].context];
        }
    }];
}



#pragma mark appdelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_setup];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions{
//    [self applicationEventHandler:DTApplicationEventType_setup];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions{
    [DTRipper sharedInstance].context.application = application;
    [DTRipper sharedInstance].context.launchOptions = launchOptions;
    [self applicationEventHandler:DTApplicationEventType_setup];
    return YES;
}



- (void)applicationDidBecomeActive:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_didBecomeActive];
}
- (void)applicationWillResignActive:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_willResignActive];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [DTRipper sharedInstance].context.application = application;
    [DTRipper sharedInstance].context.openURL     = url;
    [self applicationEventHandler:DTApplicationEventType_openURL];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    [DTRipper sharedInstance].context.application = application;
    [DTRipper sharedInstance].context.openURL     = url;
    [DTRipper sharedInstance].context.sourceApplication     = sourceApplication;
    [DTRipper sharedInstance].context.annotation            = annotation;
    [self applicationEventHandler:DTApplicationEventType_openURL];
    return NO;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    [DTRipper sharedInstance].context.application = app;
    [DTRipper sharedInstance].context.openURL     = url;
    [DTRipper sharedInstance].context.openURLOptions     = options;
    [self applicationEventHandler:DTApplicationEventType_openURL];
    return NO;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_recieveMemoryWarning];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_willTerminate];
}


- (void)applicationDidEnterBackground:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_didEnterBackground];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [DTRipper sharedInstance].context.application = application;
    [self applicationEventHandler:DTApplicationEventType_willEnterForeground];
}

#pragma mark notification

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}

// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler{
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler{
    
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler{
    
}

/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    
}

// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
    
}

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler{
    
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply{
    
}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application{
    
}






- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    
}


// Applications may reject specific types of extensions based on the extension point identifier.
// Constants representing common extension point identifiers are provided further down.
// If unimplemented, the default behavior is to allow the extension point identifier.
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier{
    
    return NO;
}





#pragma mark unused implementation

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration{
    
}
- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation{
    
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    
}
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    
}

- (void) application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata{
    
}

#pragma mark -- User Activity Continuation protocol adopted by UIApplication delegate --

// Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
// so use this as an opportunity to show the user that an activity will be continued shortly.
// For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
// or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType{
    
    return NO;
}

// Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
// You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
// invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
// restoreUserActivityState on all objects.
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler {
    
    return NO;
}

// If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error{
    
}

#pragma mark 应用程序保持状态
// This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    
}


- (nullable UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    
    
    return nil;
    
}
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    
    return NO;
}
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    
    return NO;
}
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    
}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application{
    
}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application{
    
}

- (void)applicationSignificantTimeChange:(UIApplication *)application{
    
}

@end
