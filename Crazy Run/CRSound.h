//
//  CRSound.h
//  Crazy Run
//
#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface CRSound : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    SystemSoundID buttonClick;
    SystemSoundID endGame;
    SystemSoundID getOnePoint;
    
    AVAudioPlayer *audioPlayer;
}

-(void)initSound;

-(void)playSoundButtonClick;
-(void)playGetOnePoint;

@end
