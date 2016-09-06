#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (TTCategory)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

- (UIScrollView*)findFirstScrollView;

- (UIView*)firstViewOfClass:(Class)cls;

- (UIView*)firstParentOfClass:(Class)cls;

- (UIView*)findChildWithDescendant:(UIView*)descendant;

/**
 * Removes all subviews.
 */
- (void)removeSubviews;

/**
 * WARNING: This depends on undocumented APIs and may be fragile.  For testing only.
 */
- (void)simulateTapAtPoint:(CGPoint)location;

- (CGPoint)offsetFromView:(UIView*)otherView;

- (UIImage *)screenshotMH;

@end
