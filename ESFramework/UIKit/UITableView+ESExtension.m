//
//  UITableView+ESExtension.m
//  ESFramework
//
//  Created by Elf Sundae on 5/19/14.
//  Copyright © 2014-2020 https://0x123.com All rights reserved.
//

#import "UITableView+ESExtension.h"
#if TARGET_OS_IOS || TARGET_OS_TV

#import "UIView+ESExtension.h"

@implementation UITableView (ESExtension)

- (void)performBatchUpdates:(void (NS_NOESCAPE ^ _Nullable)(void))updates
{
    if (@available(iOS 11, tvOS 11, *)) {
        [self performBatchUpdates:updates completion:nil];
    } else {
        [self beginUpdates];
        if (updates) {
            updates();
        }
        [self endUpdates];
    }
}

- (void)scrollToFirstResponderAnimated:(BOOL)animated atScrollPosition:(UITableViewScrollPosition)scrollPosition
{
    UIView *responder = [self.window findFirstResponder];
    UITableViewCell *cell = (UITableViewCell *)[responder findSuperviewOfClass:[UITableViewCell class]];
    if (cell) {
        NSIndexPath *indexPath = [self indexPathForCell:cell];
        if (indexPath) {
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
        }
    }
}

- (void)touchRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    if (![self cellForRowAtIndexPath:indexPath]) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        [self.delegate tableView:self willSelectRowAtIndexPath:indexPath];
    }

    [self selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];

    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)setVisibleCellsNeedDisplay
{
    for (UITableViewCell *cell in self.visibleCells) {
        [cell setNeedsDisplay];
    }
}

- (void)setVisibleCellsNeedLayout
{
    for (UITableViewCell *cell in self.visibleCells) {
        [cell setNeedsLayout];
    }
}

@end

#endif
