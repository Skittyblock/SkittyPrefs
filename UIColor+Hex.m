// UIColor

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (id)colorFromHex:(NSString *)hexString {
	// Hex string
	if ([hexString hasPrefix:@"#"]) {
		unsigned int rgbValue = 0;

		NSScanner *scanner = [NSScanner scannerWithString:hexString];
		[scanner setScanLocation:1];
		[scanner scanHexInt:&rgbValue];

		NSString *newString = [hexString substringFromIndex:1];

		CGFloat r, g, b, a;
		switch (newString.length) {
			case 3:
				r = ((rgbValue & 0xF00) >> 8) / 255.0;
				g = ((rgbValue & 0xF0) >> 4) / 255.0;
				b = (rgbValue & 0xF) / 255.0;
				a = 1.0;
				break;
			case 4:
				r = ((rgbValue & 0xF000) >> 16) / 255.0;
				g = ((rgbValue & 0xF00) >> 8) / 255.0;
				b = ((rgbValue & 0xF0) >> 4) / 255.0;
				a = (rgbValue & 0xF) / 255.0;
				break;
			case 6:
				r = ((rgbValue & 0xFF0000) >> 16) / 255.0;
				g = ((rgbValue & 0xFF00) >> 8) / 255.0;
				b = (rgbValue & 0xFF) / 255.0;
				a = 1.0;
				break;
			case 8:
				r = ((rgbValue & 0xFF000000) >> 24) / 255.0;
				g = ((rgbValue & 0xFF0000) >> 16) / 255.0;
				b = ((rgbValue & 0xFF00) >> 8) / 255.0;
				a = (rgbValue & 0xFF) / 255.0;
				break;
			default:
				r = 0;
				g = 0;
				b = 0;
				a = 0;
				break;
		}

		return [UIColor colorWithRed:r green:g blue:b alpha:a];
	}
	// System colors
	NSArray *colors = @[@"red", @"green", @"blue", @"cyan", @"magenta", @"yellow", @"brown", @"indigo", @"orange", @"pink", @"purple", @"teal", @"white", @"black", @"clear", @"label", @"secondaryLabel", @"background", @"secondayBackground", @"grouped", @"secondayGrouped", @"darkText", @"lightText"];
	int color = [colors indexOfObject:hexString];
	switch (color) {
		case 0: return [UIColor systemRedColor];
		case 1: return [UIColor systemGreenColor];
		case 2: return [UIColor systemBlueColor];
		case 3: return [UIColor cyanColor];
		case 4: return [UIColor magentaColor];
		case 5: return [UIColor systemYellowColor];
		case 6: return [UIColor brownColor];
		case 7:
			if (@available(iOS 13, *)) return [UIColor systemIndigoColor];
			return [UIColor colorWithRed: 0.35 green: 0.34 blue: 0.84 alpha: 1];
		case 8: return [UIColor systemOrangeColor];
		case 9: return [UIColor systemPinkColor];
		case 10: return [UIColor systemPurpleColor];
		case 11: return [UIColor systemTealColor];
		case 12: return [UIColor whiteColor];
		case 13: return [UIColor blackColor];
		case 14: return [UIColor clearColor];
		case 15:
			if (@available(iOS 13, *)) return [UIColor labelColor];
			return [UIColor blackColor];
		case 16:
			if (@available(iOS 13, *)) return [UIColor secondaryLabelColor];
			return [UIColor blackColor];
		case 17:
			if (@available(iOS 13, *)) return [UIColor systemBackgroundColor];
			return [UIColor whiteColor];
		case 18:
			if (@available(iOS 13, *)) return [UIColor secondarySystemBackgroundColor];
			return [UIColor whiteColor];
		case 19:
			if (@available(iOS 13, *)) return [UIColor systemGroupedBackgroundColor];
			return [UIColor groupTableViewBackgroundColor];
		case 20:
			if (@available(iOS 13, *)) return [UIColor secondarySystemGroupedBackgroundColor];
			return [UIColor groupTableViewBackgroundColor];
		case 21: return [UIColor darkTextColor];
		case 22: return [UIColor lightTextColor];
		default: break;
	}
	return [UIColor blackColor];
}

@end
