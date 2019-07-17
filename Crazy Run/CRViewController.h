//
//  CRViewController.h
//  Crazy Run
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAD.h>
#import <Twitter/Twitter.h>


@interface CRViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *adView;
}


-(void)showBanner;
-(void)hidesBanner;

@end
