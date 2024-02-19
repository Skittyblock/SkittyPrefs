// SPStepperCell.m
// thanks to libcephei for some reference: https://github.com/hbang/libcephei/blob/main/prefs/HBStepperTableCell.m

#import "SPStepperCell.h"
#import <Preferences/PSSpecifier.h>

@implementation SPStepperCell

@dynamic control;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		self.accessoryView = self.control;
	}

	return self;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];

	self.control.minimumValue = [(NSNumber *)specifier.properties[@"min"] doubleValue];
	self.control.maximumValue = [(NSNumber *)specifier.properties[@"max"] doubleValue];
	[self _updateLabel];
}

- (void)setCellEnabled:(BOOL)cellEnabled {
	[super setCellEnabled:cellEnabled];
	self.control.enabled = cellEnabled;
}

- (UIStepper *)newControl {
	UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
	stepper.continuous = NO;
	return stepper;
}

- (NSNumber *)controlValue {
	return @(self.control.value);
}

- (void)setValue:(NSNumber *)value {
	[super setValue:value];
	self.control.value = value.doubleValue;
}

- (void)controlChanged:(UIStepper *)stepper {
	[super controlChanged:stepper];
	[self _updateLabel];
}

- (void)_updateLabel {
	if (!self.control) return;

	self.textLabel.text = [NSString stringWithFormat:self.specifier.name, (int)self.control.value];
	[self setNeedsLayout];
}

- (void)prepareForReuse {
	[super prepareForReuse];

	self.control.value = 0;
	self.control.minimumValue = 0;
	self.control.maximumValue = 100;
}

@end
