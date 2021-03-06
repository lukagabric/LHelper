//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


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


- (void)ceilFrame;
- (UIImage *)getImage;
- (UIViewController *)viewController;
- (void)placeBelowView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)placeCenterAndBelowView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)placeRightFromView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)placeCenterAndRightFromView:(UIView *)fixedView withPadding:(CGFloat)padding;
- (void)setWidth:(CGFloat)width andHeight:(CGFloat)height;
- (void)setX:(CGFloat)x andY:(CGFloat)y;
- (NSLayoutConstraint *)addTopConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;
- (NSLayoutConstraint *)addBottomConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;
- (NSLayoutConstraint *)addLeftConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;
- (NSLayoutConstraint *)addRightConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;
- (NSLayoutConstraint *)addLeadingConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;
- (NSLayoutConstraint *)addTrailingConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;
- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)attribute fromView:(UIView *)fromView toView:(UIView *)toView;
- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)attribute fromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant;


@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGPoint topLeft;
@property (nonatomic) CGPoint bottomLeft;
@property (nonatomic) CGPoint topRight;
@property (nonatomic) CGPoint bottomRight;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat midX;
@property (nonatomic) CGFloat maxX;

@property (nonatomic) CGFloat midY;
@property (nonatomic) CGFloat maxY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;


@end


#pragma mark - NSObject


@interface NSObject (NSObject_LHelperCategories)


+ (id)getFromNibNamed:(NSString *)nibName;
+ (id)getFromNib;


@end


#pragma mark - UILabel


@interface UILabel (UILabel_LHelperCategories)


- (void)decreaseHeight;
- (void)decreaseWidth;
- (void)adjustHeightWithMaxHeight:(CGFloat)maxHeight;
- (void)adjustWidthWithMaxWidth:(CGFloat)maxWidth;
- (void)adjustHeightToFit;
- (void)adjustWidthToFit;
- (CGFloat)heightForLabelWidth:(CGFloat)width;
- (CGFloat)widthForLabelHeight:(CGFloat)height;
- (CGFloat)heightThatFits;
- (CGFloat)widthThatFits;


@end


#pragma mark - NSArray


@interface NSArray (NSArray_LHelperCategories)


- (NSArray *)randomisedArray;
- (id)randomObject;
- (void)logItems;
- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint;


@end


#pragma mark - NSMutableArray


@interface NSMutableArray (NSMutableArray_LHelperCategories)


+ (id)mutableArrayUsingWeakReferences;
+ (id)mutableArrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity;


@end


#pragma mark - NSDictionary


@interface NSDictionary (NSDictionary_LHelperCategories)


- (NSString *)queryString;
- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint;


@end


#pragma mark - NSDate


@interface NSDate (NSDate_LHelperCategories)


- (NSDate *)dateToBeginningOfDay;
- (NSDate *)dateToEndOfDay;
- (NSDate *)dateToBeginningOfMonth;
- (NSDate *)dateToBeginningOfPreviousMonth;
- (NSDate *)dateToBeginningOfNextMonth;
- (BOOL)beforeDate:(NSDate *)date;
- (BOOL)beforeOrEqualToDate:(NSDate *)date;
- (BOOL)afterDate:(NSDate *)date;
- (BOOL)afterOrEqualToDate:(NSDate *)date;
- (NSString *)stringWithFormat:(NSString *)format;


@end


#pragma mark - UIImage


@interface UIImage (UIImage_LHelperCategories)


- (UIImage *)imageWithFixedOrientation;


@end


#pragma mark - NSString


@interface NSString (NSString_LHelperCategories)


- (BOOL)isEmpty;
- (NSDate *)dateWithFormat:(NSString *)format;
- (NSString *)md5;
- (NSData *)dataFromBase64String;
- (NSString *)AES128EncryptedBase64StringWithKey:(NSString *)key;
- (NSString *)AES128DecryptedBase64StringWithKey:(NSString *)key;
- (NSString *)AES256EncryptedBase64StringWithKey:(NSString *)key;
- (NSString *)AES256DecryptedBase64StringWithKey:(NSString *)key;


@end


#pragma mark - NSData


@interface NSData (NSData_LHelperCategories)


- (NSString *)stringUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)md5;
- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key;
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;


@end


#pragma mark - UIAlertView


typedef void (^LDismissBlock)(int buttonIndex);
typedef void (^LCancelBlock)();


@interface UIAlertView (UIAlertView_LHelperCategories)


+ (void)showAlertWithMessage:(NSString *)message okButtonTitle:(NSString *)okTitle;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle;
+ (void)showAlertWithMessage:(NSString *)message okButtonTitle:(NSString *)okTitle okActionBlock:(void(^)(void))okBlock;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okActionBlock:(void(^)(void))okBlock;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okActionBlock:(void(^)(void))okBlock cancelButtonTitle:(NSString *)cancelTitle andCancelBlock:(void(^)(void))cancelBlock;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtons onDismiss:(LDismissBlock)dismissBlock onCancel:(LCancelBlock)cancelBlock;


@property (nonatomic, copy) LDismissBlock dismissBlock;
@property (nonatomic, copy) LCancelBlock cancelBlock;


@end


#pragma mark - UINavigationBar



@interface UINavigationBar (UINavigationBar_LHelperCategories)


- (void)removeBottomBorder;


@end


#pragma mark - UITableViewCell


@interface UITableViewCell (UITableViewCell_LHelperCategories)


- (UITableView *)getTableView;


@end


#pragma mark -


#pragma mark -
#pragma mark - End Of Categories
#pragma mark -


#pragma mark -