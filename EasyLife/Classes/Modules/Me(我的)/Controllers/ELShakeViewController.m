//
//  ELShakeViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/10/13.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELShakeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ELShakeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (nonatomic, assign) SystemSoundID soundID;
@end

@implementation ELShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SystemSoundID)soundID {
    SystemSoundID id = 100;
    if (!_soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"glass.wav" withExtension:nil];
        
        CFURLRef urlRef = (__bridge CFURLRef)url;
        AudioServicesCreateSystemSoundID(urlRef, &id);
    }
    
    return id;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    CGFloat animationDuration = 0.3;
    CGFloat offsetY = 50;
    if (motion == UIEventSubtypeMotionShake) { // 摇一摇
        [UIView animateWithDuration:animationDuration animations:^{
            self.upImageView.transform = CGAffineTransformMakeTranslation(0, -offsetY);
            self.downImageView.transform = CGAffineTransformMakeTranslation(0, offsetY);
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:animationDuration animations:^{
                    self.upImageView.transform = CGAffineTransformIdentity;
                    self.downImageView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    // 加载tableView
                    AudioServicesPlayAlertSound(self.soundID);
                }];
            });
        }];
    }
}

@end
