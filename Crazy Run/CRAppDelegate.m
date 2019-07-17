//
//  CRAppDelegate.m
//  Crazy Run
//

#import "CRAppDelegate.h"
//#import <Chartboost/Chartboost.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>

#import "SplashViewController.h"
#import "WebViewController.h"
#import "UIUtil.h"
#import "JSONKit.h"
#import "Reachability.h"


@interface CRAppDelegate () <UINavigationControllerDelegate, UINavigationControllerDelegate>
{
    NSString* _url;
    NSString* _updateUrl;
    
    SplashViewController* _splashViewController;
}

@end

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkConnectedNotification:) name:@"NetworkConnectedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwitchToAppView:) name:@"SwitchToAppViewNotification" object:nil];

    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    _url = [userDefaults objectForKey:@"url"];
 
    if (![[Reachability reachabilityForInternetConnection] isReachable])
    {
        dispatch_async(dispatch_get_main_queue(),
        ^{
            _splashViewController = [[SplashViewController alloc] init];
            [self.window.rootViewController presentViewController:_splashViewController animated:NO completion:nil];
        });
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if (_url.length > 0)
    {
        if ([self.window.rootViewController isKindOfClass:[WebViewController class]])
        {
            [((WebViewController*)self.window.rootViewController) reloadData];
        }else{
            if ([[Reachability reachabilityForInternetConnection] isReachable])
            {
                [self switchToWebViewController];
            }
        }
    }
    else
    {
        if ([[Reachability reachabilityForInternetConnection] isReachable])
        {
            [self getURL];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)shouldDisplayInterstitial:(NSString *)location {
    NSLog(@"about to display interstitial at location %@", location);
    
    // For example:
    // if the user has left the main menu and is currently playing your game, return NO;
    
    // Otherwise return YES to display the interstitial
    return YES;
}


/*
 * didFailToLoadInterstitial
 *
 * This is called when an interstitial has failed to load. The error enum specifies
 * the reason of the failure
 */

//- (void)didFailToLoadInterstitial:(NSString *)location withError:(CBLoadError)error {
//    switch(error){
//        case CBLoadErrorInternetUnavailable: {
//            NSLog(@"Failed to load Interstitial, no Internet connection !");
//        } break;
//        case CBLoadErrorInternal: {
//            NSLog(@"Failed to load Interstitial, internal error !");
//        } break;
//        case CBLoadErrorNetworkFailure: {
//            NSLog(@"Failed to load Interstitial, network error !");
//        } break;
//        case CBLoadErrorWrongOrientation: {
//            NSLog(@"Failed to load Interstitial, wrong orientation !");
//        } break;
//        case CBLoadErrorTooManyConnections: {
//            NSLog(@"Failed to load Interstitial, too many connections !");
//        } break;
//        case CBLoadErrorFirstSessionInterstitialsDisabled: {
//            NSLog(@"Failed to load Interstitial, first session !");
//        } break;
//        case CBLoadErrorNoAdFound : {
//            NSLog(@"Failed to load Interstitial, no ad found !");
//        } break;
//        case CBLoadErrorSessionNotStarted : {
//            NSLog(@"Failed to load Interstitial, session not started !");
//        } break;
//        case CBLoadErrorNoLocationFound : {
//            NSLog(@"Failed to load Interstitial, missing location parameter !");
//        } break;
//        default: {
//            NSLog(@"Failed to load Interstitial, unknown error !");
//        }
//    }
//}

/*
 * didCacheInterstitial
 *
 * Passes in the location name that has successfully been cached.
 *
 * Is fired on:
 * - All assets loaded
 * - Triggered by cacheInterstitial
 *
 * Notes:
 * - Similar to this is: (BOOL)hasCachedInterstitial:(NSString *)location;
 * Which will return true if a cached interstitial exists for that location
 */

- (void)didCacheInterstitial:(NSString *)location {
    NSLog(@"interstitial cached at location %@", location);
}

/*
 * didFailToLoadMoreApps
 *
 * This is called when the more apps page has failed to load for any reason
 *
 * Is fired on:
 * - No network connection
 * - No more apps page has been created (add a more apps page in the dashboard)
 * - No publishing campaign matches for that user (add more campaigns to your more apps page)
 *  -Find this inside the App > Edit page in the Chartboost dashboard
 */

//- (void)didFailToLoadMoreApps:(CBLoadError)error {
//    switch(error){
//        case CBLoadErrorInternetUnavailable: {
//            NSLog(@"Failed to load More Apps, no Internet connection !");
//        } break;
//        case CBLoadErrorInternal: {
//            NSLog(@"Failed to load More Apps, internal error !");
//        } break;
//        case CBLoadErrorNetworkFailure: {
//            NSLog(@"Failed to load More Apps, network error !");
//        } break;
//        case CBLoadErrorWrongOrientation: {
//            NSLog(@"Failed to load More Apps, wrong orientation !");
//        } break;
//        case CBLoadErrorTooManyConnections: {
//            NSLog(@"Failed to load More Apps, too many connections !");
//        } break;
//        case CBLoadErrorFirstSessionInterstitialsDisabled: {
//            NSLog(@"Failed to load More Apps, first session !");
//        } break;
//        case CBLoadErrorNoAdFound: {
//            NSLog(@"Failed to load More Apps, Apps not found !");
//        } break;
//        case CBLoadErrorSessionNotStarted : {
//            NSLog(@"Failed to load More Apps, session not started !");
//        } break;
//        default: {
//            NSLog(@"Failed to load More Apps, unknown error !");
//        }
//    }
//}

/*
 * didDismissInterstitial
 *
 * This is called when an interstitial is dismissed
 *
 * Is fired on:
 * - Interstitial click
 * - Interstitial close
 *
 */

- (void)didDismissInterstitial:(NSString *)location {
    NSLog(@"dismissed interstitial at location %@", location);
}

- (void)switchToWebViewController
{
    WebViewController* viewController = [[WebViewController alloc] init];
    viewController.url = _url;
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
}

- (void)switchToAppViewController
{
    if (nil != _splashViewController)
    {
        [_splashViewController dismissViewControllerAnimated:NO completion:^{
            _splashViewController = nil;
        }];
    }
}

- (void)handleNetworkConnectedNotification:(NSNotification*)notification
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    _url = [userDefaults objectForKey:@"url"];
    if (_url.length > 0)
    {
        [self switchToWebViewController];
    }
    else
    {
        [self getURL];
    }
}

- (void)handleSwitchToAppView:(NSNotification*)notification
{
    [self switchToAppViewController];
}

- (void)getURL
{
    [self switchToAppViewController];
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
    ^{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
       
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zgzysqbj.com/appversion.php?id=%@&ver=%@", [infoDictionary objectForKey:@"CFBundleIdentifier"], [infoDictionary objectForKey:@"CFBundleShortVersionString"]]]];
        [request setHTTPMethod:@"GET"];
       
        NSError* error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        if (nil != data)
        {
            NSString* strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSData* decodedData = [[NSData alloc] initWithBase64EncodedString:strData options:NSDataBase64DecodingIgnoreUnknownCharacters];
            //strData = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
            if (nil != strData)
            {
                NSDictionary* dic = [strData objectFromJSONString];
                _url = [dic objectForKey:@"go_url"];
                if (_url.length > 0)
                {
                    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:_url forKey:@"url"];
                    [userDefaults synchronize];
                   
                    dispatch_async(dispatch_get_main_queue(),
                    ^{
                        [self switchToWebViewController];
                    });
                }
                else
                {
                    _updateUrl = [dic objectForKey:@"app_ios"];
                    NSString* new_version = [dic objectForKey:@"new_version"];
                    NSString* min_version = [dic objectForKey:@"min_version"];
                    if (_updateUrl.length > 0)
                    {
                        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
                        NSString* currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
                       
                        if (NSOrderedAscending == [currentVersion compare:min_version])
                        {
                            // 当前版本号＜最低版本号，则重复弹框（只能点击确定，并跳转到网址）
                           
                            dispatch_async(dispatch_get_main_queue(),
                            ^{
                                UIAlertView* alertView = [UIUtil showWarning:@"有新版本，是否现在更新？" title:nil delegate:self];
                               alertView.tag = 2;
                            });
                       }
                        else if (NSOrderedAscending == [currentVersion compare:new_version])
                        {
                            // 当前版本号＜最新版本号，则弹框一次（确定则跳转/取消则无操作）
                           
                            dispatch_async(dispatch_get_main_queue(),
                            ^{
                                UIAlertView* alertView = [UIUtil showQuestion:@"有新版本，是否现在更新？" title:nil delegate:self];
                                alertView.tag = 1;
                            });
                        }
                        else
                        {
                            // 当前版本号>=最新版本号，无弹框
                           
                            dispatch_async(dispatch_get_main_queue(),
                            ^{
                                [self switchToAppViewController];
                           });
                        }
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(),
                        ^{
                            [self switchToAppViewController];
                        });
                    }
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(),
                ^{
                    [self switchToAppViewController];
                });
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),
            ^{
                [self switchToAppViewController];
            });
        }
    });*/
}

#pragma mark - alert sheet delegate

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == alertView.tag)
    {
        if (1 == buttonIndex)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),
            ^{
                [self switchToAppViewController];
            });
        }
    }
    else if (2 == alertView.tag)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
        
        UIAlertView* alertView = [UIUtil showWarning:@"有新版本，是否现在更新？" title:nil delegate:self];
        alertView.tag = 2;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer
{
    UINavigationController* naviController = self.navigationController;
    
    if ([naviController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (gestureRecognizer == naviController.interactivePopGestureRecognizer)
        {
            return [naviController.viewControllers count] > 1;
        }
    }
    
    return YES;
}

@end
