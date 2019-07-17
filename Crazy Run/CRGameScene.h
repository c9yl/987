//
//  CRGameScene.h
//  Crazy Run
//

#import <SpriteKit/SpriteKit.h>

#import "CRSettings.h"
#import "CREndGameScene.h"
#import "CRSound.h"

@interface CRGameScene : SKScene <SKPhysicsContactDelegate> {
    NSTimer *changeSceneTimer;
    
    int score;
    
    float spawnSpeed;
    float objectSpeed;
    
    BOOL nowPlay;
    
    CRSound *sound;
}

//Time intervals for update methods
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

//Nodes
@property (nonatomic) SKSpriteNode *player;

@property (nonatomic) SKSpriteNode *checker;

@property (nonatomic) SKSpriteNode *block;
@property (nonatomic) SKSpriteNode *target;

@property (nonatomic) SKSpriteNode *bground;

//Inteface
@property (nonatomic) SKLabelNode *labelScore;
@property (nonatomic) SKLabelNode *labelGameOver;

@end
