//
//  ViewController.m
//  pilot-ios-sample
//
//  Created by DinhPhuc on 22/11/2024.
//
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <CoreMedia/CoreMedia.h>

#import "ViewController.h"
#import <pilot-ios-sdk/OTT.h>

@interface ViewController ()
@property (nonatomic, strong) NSArray<NSString *> *mediaItems;
@property (nonatomic, assign) NSInteger currentIndex;

- (void) playCurrentIndex;
- (void) initializePlayer;
- (void) initializeWithAVPlayerViewController;
- (void) initializeWithAVPlayerLayer;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SmMonitor sharedInstance] timeSinceAppStart];
    
    self.playBtn.enabled = NO;
    self.nextBtn.enabled = NO;
    
    self.mediaItems = @[
        @"https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
        @"https://stream.mux.com/v69RSHhFelSm4701snP22dYz2jICy4E4FUyk02rW4gxRM.m3u8",
        @"https://live-on-v2-vndt.sigmaott.com/manifest/test_live/master.m3u8",
    ];
    self.currentIndex = 0;
}

- (IBAction)initialize:(id)sender {
    [self initializePlayer];
    
    self.initialBtn.enabled = NO;
    self.playBtn.enabled = YES;
    self.nextBtn.enabled = YES;
}

- (void) initializePlayer {
    // Khởi tạo AVPlayer
    self.player = [[AVPlayer alloc] init];
    
//    [self initializeWithAVPlayerLayer];
    [self initializeWithAVPlayerViewController];
}

- (void)initializeWithAVPlayerViewController {
    self.playerViewController = [[AVPlayerViewController alloc] init];
    self.playerViewController.player = self.player;
    self.playerViewController.showsPlaybackControls = YES;

    // Đảm bảo rằng AVPlayerViewController được thêm vào view controller hiện tại
    [self addChildViewController:self.playerViewController];

    // Thêm view của playerViewController vào videoContainerView và thiết lập khung hình
    self.playerViewController.view.frame = self.videoContainerView.bounds;
    [self.videoContainerView addSubview:self.playerViewController.view];
    
    [[SmMonitor sharedInstance] attachAVPlayer:self.player withAVPlayerViewController:self.playerViewController];
}

- (void)initializeWithAVPlayerLayer {
    // Khởi tạo AVPlayerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.videoContainerView.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    // Thêm AVPlayerLayer vào videoContainerView
    [self.videoContainerView.layer addSublayer:self.playerLayer];
    
    [[SmMonitor sharedInstance] attachAVPlayer:self.player withAVPlayerLayer:self.playerLayer];
}

- (IBAction)play:(id)sender {
    [self playCurrentIndex];
}

- (IBAction)next:(id)sender {
    self.currentIndex++;
    if (self.currentIndex == self.mediaItems.count) {
        self.currentIndex = 0;
    }
    
    [self playCurrentIndex];
}

- (void) playCurrentIndex {
    NSString *uri = self.mediaItems[self.currentIndex];
    NSURL *url = [NSURL URLWithString:uri];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithURL:url];
    
    SmCustomData * smCustomData = [[SmCustomData alloc] init];;
    smCustomData.userId = @"user_id_123";
    smCustomData.playerSoftware = @"SigmaPlayer";
    smCustomData.playerSoftwareVersion = @"1.0.0";
    smCustomData.streamType = @"vod";
    smCustomData.contentType = @"content_type";
    smCustomData.videoId = @"video_id_123";
    smCustomData.language = @"vn";
    smCustomData.series = @"series_antv";
    smCustomData.title = @"title_antv";
    smCustomData.videoSourceUrl = uri;
    
    [[SmMonitor sharedInstance] setCustomData:smCustomData];

    [self.player replaceCurrentItemWithPlayerItem:currentItem];
    [self.player play];
}

- (void)dealloc {
    [[SmMonitor sharedInstance] destroy];
}

@end
