//
//  InfiniteScrollingView.m
//  循环滚动
//
//  Created by biznest on 15/4/28.
//  Copyright (c) 2015年 biznest. All rights reserved.
//

#import "InfiniteScrollingView.h"
#import "UIImageView+WebCache.h"

#define TIME_ONECE 1

@interface InfiniteScrollingView () <UIScrollViewDelegate>
{
    CGRect _myFrame;
    UIScrollView *_scrollview;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    NSInteger _current;
}

@end

@implementation InfiniteScrollingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _myFrame = frame;
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    if (images.count > 0) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:images];
        [arr insertObject:[images firstObject] atIndex:images.count];
        [arr insertObject:[images lastObject] atIndex:0];
        _images = arr;
        [self initScrollView];
    }
}

- (void)initScrollView
{
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _myFrame.size.width, _myFrame.size.height)];
    _scrollview.delegate = self;
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.contentSize = CGSizeMake(_images.count * _scrollview.frame.size.width, _scrollview.frame.size.height);
    
    for (int i = 0; i < _images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width * i, 0, _scrollview.frame.size.width, _scrollview.frame.size.height)];
        if ([_images[i] hasPrefix:@"http://"]) {
            [imageView sd_setImageWithURL:_images[i] placeholderImage:nil];
        }else{
            imageView.image = [UIImage imageNamed:_images[i]];
        }
        [_scrollview addSubview:imageView];
    }
    
    [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0)];
    
    [self addSubview:_scrollview];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollview.frame.size.height - 20, _scrollview.frame.size.width, 20)];
    _pageControl.numberOfPages = _images.count - 2;
    _pageControl.currentPage = 0;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
    
    [self beginTimer];
}

- (void)beginTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:TIME_ONECE target:self selector:@selector(infiniteScroll) userInfo:nil repeats:YES];
    }
}

- (void)endTimer
{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)infiniteScroll
{
    int i = _scrollview.contentOffset.x/_scrollview.frame.size.width;
    i++;
    [_scrollview setContentOffset:CGPointMake(i * _scrollview.frame.size.width, 0) animated:YES];
    
    if (_scrollview.contentOffset.x/_scrollview.frame.size.width == _images.count-1) {
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0)];
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/scrollView.frame.size.width == _images.count - 1) {
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width - 0.5;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/scrollView.frame.size.width == _images.count-1) {
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0)];
    }else if (scrollView.contentOffset.x == 0){
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width * (_images.count - 2), 0)];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginTimer];
}
@end
