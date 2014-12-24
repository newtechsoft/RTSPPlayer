//
//  ViewController.m
//  TestVideo
//
//  Created by Admin on 12/21/14.
//  Copyright (c) 2014 Sutan. All rights reserved.
//

#import "ViewController.h"
#import "RTSPPlayer.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *nextFrameTimer;

@end

@implementation ViewController

@synthesize video;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    video = [[RTSPPlayer alloc] initWithVideo:@"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov" usesTcp:YES];
    video.outputWidth = 426;
    video.outputHeight = 320;
}

- (void)viewWillAppear:(BOOL)animated {
    [_nextFrameTimer invalidate];
    self.nextFrameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                                           target:self
                                                         selector:@selector(displayNextFrame:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_nextFrameTimer invalidate];
    self.nextFrameTimer = nil;
}
-(void)displayNextFrame:(NSTimer *)timer
{
    if (![video stepFrame]) {
        [timer invalidate];
        [video closeAudio];
        return;
    }
    image.image = video.currentImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
