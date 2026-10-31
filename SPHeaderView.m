// SPHeaderView.m

#import "SPHeaderView.h"

@import CoreText;

@implementation SPHeaderView

- (id)initWithSettings:(NSDictionary *)settings {
	self = [super init];

	if (self) {
		self.settings = settings;

		NSString *fontName = nil;
		if (settings[@"headerFontPath"]) {
			CGDataProviderRef dataProvider = CGDataProviderCreateWithFilename([settings[@"headerFontPath"] UTF8String]);
			CGFontRef font = CGFontCreateWithDataProvider(dataProvider);
			CGDataProviderRelease(dataProvider);
			CTFontManagerRegisterGraphicsFont(font, nil);
			fontName = (NSString *)CFBridgingRelease(CGFontCopyPostScriptName(font));
			CGFontRelease(font);
		}

		self.backgroundColor = settings[@"headerColor"] ?: settings[@"tintColor"];

		self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, self.bounds.size.width, 118)];
		[self addSubview:self.contentView];

		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.bounds.size.width, 50)];
		self.titleLabel.text = settings[@"name"];
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		if (fontName) {
			self.titleLabel.font = [UIFont fontWithName:fontName size:[settings[@"titleFontSize"] floatValue] ?: 42];
		} else {
			self.titleLabel.font = [UIFont boldSystemFontOfSize:[settings[@"titleFontSize"] floatValue] ?: 42];
		}
		self.titleLabel.textColor = settings[@"textColor"] ?: [UIColor whiteColor];
		[self.contentView addSubview:self.titleLabel];

		self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 71, self.bounds.size.width, 32)];
		self.subtitleLabel.text = settings[@"subtitle"];
		self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
		if (fontName) {
			self.subtitleLabel.font = [UIFont fontWithName:fontName size:[settings[@"subtitleFontSize"] floatValue] ?: 28];
		} else {
			self.subtitleLabel.font = [UIFont systemFontOfSize:[settings[@"subtitleFontSize"] floatValue] ?: 28];
		}
		self.subtitleLabel.textColor = self.settings[@"subtitleTextColor"] ?: (self.settings[@"textColor"] ?: [UIColor whiteColor]);
		[self.contentView addSubview:self.subtitleLabel];

		if (@available(iOS 13.0, *)) {
			if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
				if (self.settings[@"darkHeaderColor"]) self.backgroundColor = self.settings[@"darkHeaderColor"];
				if (self.settings[@"darkTextColor"]) {
					self.titleLabel.textColor = self.settings[@"darkTextColor"];
					self.subtitleLabel.textColor = self.settings[@"subtitleTextColor"] ?: self.settings[@"darkTextColor"];
				}
			} else {
				self.backgroundColor = self.settings[@"headerColor"] ?: self.settings[@"tintColor"];
				self.titleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
				self.subtitleLabel.textColor = self.settings[@"subtitleTextColor"] ?: (self.settings[@"textColor"] ?: [UIColor whiteColor]);
			}
		} else {
			self.backgroundColor = self.settings[@"headerColor"] ?: self.settings[@"tintColor"];
			self.titleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
			self.subtitleLabel.textColor = self.settings[@"subtitleTextColor"] ?: (self.settings[@"textColor"] ?: [UIColor whiteColor]);
		}
	}

	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	UIViewController *controller = [self _viewControllerForAncestor];
	CGFloat navigationBarHeight = controller.navigationController.navigationController.navigationBar.bounds.size.height;

	CGFloat statusBarHeight = 20;
	if (@available(iOS 13.0, *)) {
		statusBarHeight = self.window.windowScene.statusBarManager.statusBarFrame.size.height;
	} else {
		statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
	}

	CGFloat offset = statusBarHeight + navigationBarHeight;
	CGFloat width = self.bounds.size.width;
	CGFloat contentHeight = self.contentView.bounds.size.height;
	CGFloat y = (self.bounds.size.height - offset - contentHeight) / 2 + offset - 20;

	self.contentView.frame = CGRectMake(0, y, width, contentHeight);

	CGRect titleFrame = self.titleLabel.frame;
	titleFrame.size.width = width;
	self.titleLabel.frame = titleFrame;

	CGRect subtitleFrame = self.subtitleLabel.frame;
	subtitleFrame.size.width = width;
	self.subtitleLabel.frame = subtitleFrame;
}

- (void)didMoveToWindow {
	[super didMoveToWindow];
	[self setNeedsLayout];
}

- (void)safeAreaInsetsDidChange {
	[super safeAreaInsetsDidChange];
	[self setNeedsLayout];
}

- (CGFloat)contentHeightForWidth:(CGFloat)width {
	return 192;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
	if (@available(iOS 13, *)) {
		if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
			if (self.settings[@"darkHeaderColor"]) self.backgroundColor = self.settings[@"darkHeaderColor"];
			if (self.settings[@"darkTextColor"]) {
				self.titleLabel.textColor = self.settings[@"darkTextColor"];
				self.subtitleLabel.textColor = self.settings[@"subtitleTextColor"] ?: self.settings[@"darkTextColor"];
			}
		} else {
			self.backgroundColor = self.settings[@"headerColor"] ?: self.settings[@"tintColor"];
			self.titleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
			self.subtitleLabel.textColor = self.settings[@"subtitleTextColor"] ?: (self.settings[@"textColor"] ?: [UIColor whiteColor]);
		}
	}
}

@end
