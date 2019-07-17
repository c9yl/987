//
//  CREndGameScene.h
//  Crazy Run
//

#import <SpriteKit/SpriteKit.h>

#import "CRSettings.h"
#import "CRGameScene.h"
#import "CRSound.h"

@interface CREndGameScene : SKScene {
    CRSound *sound;
}

//Nodes
@property (nonatomic) SKSpriteNode *buttonRestart;
@property (nonatomic) SKSpriteNode *buttonShare;

//Labels
@property (nonatomic) SKLabelNode *labelScore;
@property (nonatomic) SKLabelNode *labelScoreText;

@end
