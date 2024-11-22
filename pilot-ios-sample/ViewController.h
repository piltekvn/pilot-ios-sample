//
//  ViewController.h
//  pilot-ios-sample
//
//  Created by DinhPhuc on 22/11/2024.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, strong) AVPlayerViewController *playerViewController;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (weak, nonatomic) IBOutlet UIButton *initialBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

