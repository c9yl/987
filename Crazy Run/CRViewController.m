//
//  CRViewController.m
//  Crazy Run
//

#import "CRViewController.h"
#import "CRMenuScene.h"



@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //AdMob
   // NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    


    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [CRMenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    //Add view controller as observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"hideAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"showAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTwitter) name:@"sendTwitter" object:nil];
    
    //iAd View settings
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectOffset(adView.frame, 0, 0.0f);
    adView.delegate=self;
    [adView setAlpha:0];
    [self.view addSubview:adView];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark iAd banner methods

//Handle Notification
- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"hideAd"]) {
        [self hidesBanner];
    }
    else if ([notification.name isEqualToString:@"showAd"]) {
        [self showBanner];
    }
}

//Hide iAd banner
-(void)hidesBanner {
    NSLog(@"Hide banner");
    [adView setAlpha:0];
}

//Show iAd banner
-(void)showBanner {
    NSLog(@"Show banner");
    [adView setAlpha:1];
}

#pragma mark Twitter

- (void)sendTwitter {
    //Initial object
    SLComposeViewController *tweetContent;
    tweetContent = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //Set text of message
    [tweetContent setInitialText:[NSString stringWithFormat:@"See, I scored %ld points in Crazy Red Ball !", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"score"]]];
    //See message to send
    [self presentViewController:tweetContent animated:YES completion:nil];
}

@end
