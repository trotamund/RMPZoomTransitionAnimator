//  Copyright (c) 2015 Recruit Marketing Partners Co.,Ltd. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ImageCollectionModalTransitionViewController.h"
#import "ImageCollectionViewCell.h"

@interface ImageCollectionModalTransitionViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ImageCollectionModalTransitionViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    UIViewController *vc = segue.destinationViewController;
    vc.transitioningDelegate = self;
}

#pragma mark - <RMPZoomTransitionAnimating>

- (UIView *)transitionSourceView
{
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
    imageView.contentMode = cell.imageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.collectionView.backgroundColor;
}

- (CGRect)transitionDestinationViewFrame
{
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect cellFrameInSuperview = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    return cellFrameInSuperview;
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id <RMPZoomTransitionAnimating> sourceTransition = (id<RMPZoomTransitionAnimating>)source;
    id <RMPZoomTransitionAnimating> destinationTransition = (id<RMPZoomTransitionAnimating>)presented;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = YES;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id <RMPZoomTransitionAnimating> sourceTransition = (id<RMPZoomTransitionAnimating>)dismissed;
    id <RMPZoomTransitionAnimating> destinationTransition = (id<RMPZoomTransitionAnimating>)self;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = NO;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

@end
