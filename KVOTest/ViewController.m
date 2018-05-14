//
//  ViewController.m
//  KVOTest
//
//  Created by 乔汝嘉 on 2018/5/14.
//  Copyright © 2018年 ManuQiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) double originScale;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) UIView *subview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _originScale = 1;
    
    _subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _subview.center = self.view.center;
    _subview.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_subview];
    
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [_subview addGestureRecognizer:gesture];
    
    [_subview addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    _subview.frame = CGRectMake(0, 0, 200, 200);//这一步也可以obseve到
}

- (void)pinch:(id)sender {
    UIPinchGestureRecognizer *gesture = (UIPinchGestureRecognizer *)sender;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.originFrame = self.subview.frame;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGRect newFrame = self.originFrame;
        newFrame.size.width = newFrame.size.width * gesture.scale * self.originScale;
        newFrame.size.height = newFrame.size.height * gesture.scale * self.originScale;
        self.subview.frame = newFrame;
        self.subview.center = self.view.center;
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        self.originScale = gesture.scale * self.originScale;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", keyPath);
    NSLog(@"%@", change);
}

@end
