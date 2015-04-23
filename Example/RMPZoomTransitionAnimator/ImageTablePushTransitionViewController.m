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

#import "ImageTablePushTransitionViewController.h"
#import "ImageTableViewCell.h"

@interface ImageTablePushTransitionViewController ()

@end

@implementation ImageTablePushTransitionViewController

#pragma mark <RMPZoomTransitionAnimating>

- (UIView *)transitionSourceView
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    ImageTableViewCell *cell = (ImageTableViewCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.thumbImageView.image];
    imageView.contentMode = cell.thumbImageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [cell.thumbImageView convertRect:cell.thumbImageView.frame toView:self.tableView.superview];
    frameInSuperview.origin.x -= [cell.thumbImageView layoutMargins].left;
    frameInSuperview.origin.y -= [cell.thumbImageView layoutMargins].top;
    imageView.frame = frameInSuperview;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.tableView.backgroundColor;
}

- (CGRect)transitionDestinationViewFrame
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    ImageTableViewCell *cell = (ImageTableViewCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    CGRect frameInSuperview = [cell.thumbImageView convertRect:cell.thumbImageView.frame toView:self.tableView.superview];
    frameInSuperview.origin.x -= [cell.thumbImageView layoutMargins].left;
    frameInSuperview.origin.y -= [cell.thumbImageView layoutMargins].top;
    return frameInSuperview;
}

@end
