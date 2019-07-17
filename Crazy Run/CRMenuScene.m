//
//  CRMenuScene.m
//  Crazy Run
//


#import "CRMenuScene.h"
#import "CRAppDelegate.h"
#import "PrivacyViewController.h"


@implementation CRMenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //Set background color
        self.backgroundColor = COLOR_FOR_BACKGROUND;
        
        //Initial sound
        sound = [[CRSound alloc] init];
        [sound initSound];
        
        //Send message to RPViewController to hide iAd.
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
        
        //Set interface
        [self setButtonStart];
        [self setLogo];
        [self setLabels];
    }
    return self;
}

#pragma mark Interface

- (void)setButtonStart {
    //Set object image size and position.
    _buttonStart = [SKSpriteNode spriteNodeWithImageNamed:@"buttonStart"];
    _buttonStart.size = CGSizeMake(SIZE_OF_BUTTON_START, SIZE_OF_BUTTON_START);
    _buttonStart.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _buttonStart.zPosition = 40;
    //Add object to scene
    [self addChild:_buttonStart];
}

- (void)setLogo {
    //Set object image size and position.
    _logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
    _logo.size = CGSizeMake(SIZE_OF_LOGO, SIZE_OF_LOGO / 2.7);
    _logo.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 85);
    _logo.zPosition = 45;
    //Add object to scene
    [self addChild:_logo];
}

- (void)setLabels {
    //Set font type
    _bestScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _bestScore.fontSize = FONT_SIZE_4 * 2;
    }
    else {
        _bestScore.fontSize = FONT_SIZE_4;
    }
    //Set font color
    _bestScore.fontColor = FONT_COLOR_DARK;
    //Set object positions
    _bestScore.zPosition = 30;
    _bestScore.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 10);
    //Set label text
    _bestScore.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScore"]];
    //Add object to scene
    [self addChild:_bestScore];
    
    //Set font type
    _bestScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _bestScoreLabel.fontSize = FONT_SIZE_1 * 2;
    }
    else {
        _bestScoreLabel.fontSize = FONT_SIZE_1;
    }
    //Set font color
    _bestScoreLabel.fontColor = FONT_COLOR_DARK;
    //Set object positions
    _bestScoreLabel.zPosition = 30;
    _bestScoreLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 5);
    //Set label text
    _bestScoreLabel.text = [NSString stringWithFormat:@"Best score"];
    //Add object to scene
    [self addChild:_bestScoreLabel];
    
    //Set font type
    _privacyLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _privacyLabel.fontSize = FONT_SIZE_1 * 2;
    }
    else {
        _privacyLabel.fontSize = FONT_SIZE_1;
    }
    //Set font color
    _privacyLabel.fontColor = [UIColor purpleColor];
    //Set object positions
    _privacyLabel.zPosition = 30;
    _privacyLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 20);
    //Set label text
    _privacyLabel.text = [NSString stringWithFormat:@"Privacy"];
    //Add object to scene
    [self addChild:_privacyLabel];
}

#pragma mark Programm

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Get location
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //If touch _buttonStart
        if ([_buttonStart containsPoint:location])
        {
            //Change scene
            [self changeSceneToGame];
            //Play sound
            [sound playSoundButtonClick];
        }
        else if ([_privacyLabel containsPoint:location])
        {
            CRAppDelegate* appDelegate = (CRAppDelegate*)[UIApplication sharedApplication].delegate;
            
            PrivacyViewController* viewController = [[PrivacyViewController alloc] init];
            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            [appDelegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }
}

#pragma mark Change Scene

- (void)changeSceneToGame {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:1];
    SKScene *level = [[CRGameScene alloc] initWithSize:skView.bounds.size];
    
    [self.view presentScene:level transition:reveal];
}

@end
