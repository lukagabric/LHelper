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


@end


#pragma mark - NSArray


@interface NSArray (NSArray_LHelperCategories)


- (NSArray *)randomisedArray;
- (id)randomObject;
- (void)logItems;


@end


#pragma mark - NSDictionary


@interface NSDictionary (NSDictionary_LHelperCategories)


- (NSString *)queryString;


@end


#pragma mark - NSDate


@interface NSDate (NSDate_LHelperCategories)


- (NSDate *)dateToBeginningOfDay;
- (NSDate *)dateToEndOfDay;
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

void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

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


@property (nonatomic, copy) LDismissBlock dismissBlock;
@property (nonatomic, copy) LCancelBlock cancelBlock;


@end


#pragma mark -


#pragma mark -
#pragma mark - End Of Categories
#pragma mark -


#pragma mark -