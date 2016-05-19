//
//  ViewController.m
//  循环滚动
//
//  Created by biznest on 15/4/28.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import "ViewController.h"
#import "InfiniteScrollingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        [images addObject:[NSString stringWithFormat:@"banner%d.jpg",i+1]];
    }
    
    NSArray *images1 = @[
                         @"http://hf.cnitcloud.com:8899/swallow/show/35cf896cd822705f2a43753d0cdc0d2d.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/66f64863c68edcfbf9f03fcddcc18a99.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/435e35d72bbe1283b4bb15510f89f538.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/35cf896cd822705f2a43753d0cdc0d2d.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/66f64863c68edcfbf9f03fcddcc18a99.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/435e35d72bbe1283b4bb15510f89f538.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/35cf896cd822705f2a43753d0cdc0d2d.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/66f64863c68edcfbf9f03fcddcc18a99.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/435e35d72bbe1283b4bb15510f89f538.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/35cf896cd822705f2a43753d0cdc0d2d.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/66f64863c68edcfbf9f03fcddcc18a99.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/435e35d72bbe1283b4bb15510f89f538.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/35cf896cd822705f2a43753d0cdc0d2d.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/66f64863c68edcfbf9f03fcddcc18a99.jpg",
                         @"http://hf.cnitcloud.com:8899/swallow/show/435e35d72bbe1283b4bb15510f89f538.jpg"];
    
    InfiniteScrollingView *infiniteScrollingView = [[InfiniteScrollingView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 160)];
    infiniteScrollingView.images = images;
    //    infiniteScrollingView.images = images1;
    [self.view addSubview:infiniteScrollingView];
}

@end
