//
//  CRSettings.h
//  Crazy Run
//
#ifndef Crazy_Run_CRSettings_h
#define Crazy_Run_CRSettings_h

//Color
#define FONT_COLOR_DARK [UIColor colorWithRed:(52/255.0) green:(52/255.0) blue:(52/255.0) alpha:1]
#define FONT_COLOR_WHITE [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1]

#define COLOR_FOR_PLAYER [UIColor colorWithRed:(18/255.0) green:(178/255.0) blue:(173/255.0) alpha:1]
#define COLOR_FOR_TARGET [UIColor colorWithRed:(0/255.0) green:(255/255.0) blue:(246/255.0) alpha:1]
#define COLOR_FOR_BLOCK [UIColor colorWithRed:(255/255.0) green:(25/255.0) blue:(208/255.0) alpha:1]
#define COLOR_FOR_BACKGROUND [UIColor colorWithRed:(255/255.0) green:(250/255.0) blue:(226/255.0) alpha:1]

//Sizes
#define SIZE_OF_PLAYER self.size.width / 100 * 5
#define SIZE_OF_BLOCK self.size.width / 100 * 6
#define SIZE_OF_TARGET self.size.width / 100 * 6

#define SIZE_OF_BUTTON_START self.size.width / 100 * 25
#define SIZE_OF_LOGO self.size.width / 100 * 80

#define SIZE_OF_BUTTON_TWITTER self.size.width / 100 * 20
#define SIZE_OF_BUTTON_RESTART self.size.width / 100 * 30

//Font size
#define FONT_SIZE_1 20
#define FONT_SIZE_2 30
#define FONT_SIZE_3 40
#define FONT_SIZE_4 50

//Positions
#define POSITION_OF_PLAYER_Y self.frame.size.height / 100 * 20
#define POSITION_OF_BLOCK_AND_TARGET_Y self.frame.size.height / 100 * 120
#define POSITION_OF_LABEL_Y self.frame.size.height / 100 * 87

//Game settings
#define SPEED_OF_OBJECT 5.0
#define SPEED_OF_OBJECT_LIMIT 0.5
#define SPEED_OF_OBJECT_CHANGE 0.1

#define SPAWN_SPEED 60
#define SPAWN_SPEED_LIMIT 60
#define SPAWN_SPEED_CHANGE 0.10

//Times
#define TIME_TO_REMOVE_TARGET 0.3
#define TIME_TO_REMOVE_BLOCK 1.5

#define TIME_TO_ROTATE 0.2

#endif
