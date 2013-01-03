#import <UIKit/UIKit.h>


#pragma mark -
#pragma mark - Categories
#pragma mark -


#pragma mark - UIViewController


@interface UIViewController (UIViewController_LHelperCategories)


- (BOOL)isModal;
- (void)autorotate;


@end


#pragma mark - UIView


@interface UIView (UIView_LHelperCategories)


- (UIImage *)getImage;
- (UIViewController *)viewController;
- (void)placeBelowView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)placeCenterAndBelowView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)placeRightFromView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)placeCenterAndRightFromView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)setWidth:(CGFloat)width andHeight:(CGFloat)height;
- (void)setX:(CGFloat)x andY:(CGFloat)y;


@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGPoint topLeft;
@property (nonatomic) CGPoint bottomLeft;
@property (nonatomic) CGPoint topRight;
@property (nonatomic) CGPoint bottomRight;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;


@end


#pragma mark - NSObject


@interface NSObject (NSObject_LHelperCategories)


- (id)getFromNibNamed:(NSString *)nibName;
- (id)getFromNib;
+ (id)getFromNibNamed:(NSString *)nibName;
+ (id)getFromNib;


@end


#pragma mark - UILabel


@interface UILabel (UILabel_LHelperCategories)

- (void)decreaseHeight;
- (void)decreaseWidth;
- (void)adjustHeightWithMaxHeight:(CGFloat)maxHeight;
- (void)adjustWidthWithMaxWidth:(CGFloat)maxWidth;


@end


#pragma mark - NSArray


@interface NSArray (NSArray_LHelperCategories)


- (void)logItems;
- (NSArray *)randomisedArray;


@end


#pragma mark - NSDictionary


@interface NSDictionary (NSDictionary_LHelperCategories)


- (NSString *)queryString;


@end


#pragma mark -


#pragma mark -
#pragma mark - End Of Categories
#pragma mark -


#pragma mark -