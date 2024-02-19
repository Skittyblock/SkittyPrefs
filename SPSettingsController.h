// SPSettingsController.h

#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import <UserNotifications/UserNotifications.h>
#import "SPHeaderView.h"

@interface UIStatusBar : NSObject
@property (nonatomic, assign) UIColor *foregroundColor;
@end

@interface UIApplication (Private)
@property (nonatomic, retain) UIStatusBar *statusBar;
@end

@interface SPSettingsController : PSListController <UIScrollViewDelegate, UNUserNotificationCenterDelegate>

@property (nonatomic, retain) NSMutableDictionary *settings;
@property (nonatomic, retain) NSMutableDictionary *requiredToggles;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) SPHeaderView *headerView;
@property (nonatomic, retain) UIColor *themeColor;
@property (nonatomic, assign) BOOL navbarThemed;

@property (nonatomic, retain) UINavigationBarAppearance *savedStandardAppearance API_AVAILABLE(ios(13.0));
@property (nonatomic, retain) UINavigationBarAppearance *savedScrollEdgeAppearance API_AVAILABLE(ios(13.0));

- (void)layoutHeader;
- (NSBundle *)resourceBundle;

@end
