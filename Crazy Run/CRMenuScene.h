//
//  CRMenuScene.h
//  Crazy Run
//

#import <SpriteKit/SpriteKit.h>

#import "CRSettings.h"
#import "CRGameScene.h"
#import "CRSound.h"

@interface CRMenuScene : SKScene {
    CRSound *sound;
}

//Nodes
@property (nonatomic) SKSpriteNode *buttonStart;
@property (nonatomic) SKSpriteNode *logo;

//Labels
@property (nonatomic) SKLabelNode *bestScore;
@property (nonatomic) SKLabelNode *bestScoreLabel;
@property (nonatomic) SKLabelNode *privacyLabel;

@end
