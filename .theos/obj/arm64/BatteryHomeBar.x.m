#line 1 "BatteryHomeBar.x"
#import "BatteryHomeBar.h"
#import <libcolorpicker.h>

static int offsets = 0;
static BOOL enabled;
static BOOL enableOutline;
static BOOL shrinkMiddleEnabled;
static UIColor *homeBarBackgroundColor;

static void loadPrefs() {
	static NSMutableDictionary *settings;
	static NSMutableDictionary *colors;

	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.shepgoba.bhbsettings"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (keyList) {
		settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.shepgoba.bhbsettings"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
		CFRelease(keyList);
	} else {
		settings = nil;
	}

	if (!settings) {
		settings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.bhbsettings.plist"];
	}

  	enabled = [([settings objectForKey:@"enabled"] ? [settings objectForKey:@"enabled"] : @(YES)) boolValue];
	enableOutline = [([settings objectForKey:@"enableOutline"] ? [settings objectForKey:@"enableOutline"] : @(YES)) boolValue];
	shrinkMiddleEnabled = [([settings objectForKey:@"shrinkMiddleEnabled"] ? [settings objectForKey:@"shrinkMiddleEnabled"] : @(NO)) boolValue];
	if (enableOutline) {
		offsets = 1;
	}
	colors = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.bhbsettings.color.plist"];
	homeBarBackgroundColor = LCPParseColorString([colors objectForKey:@"homeBarBackgroundColor"], @"#000000");
}
void commonDidMoveToWindow(MTPillView *self) {
	[self.batteryPctView.topAnchor constraintEqualToAnchor:self.topAnchor constant:offsets].active = YES;
	[self.batteryPctView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-offsets].active = YES;
	if (shrinkMiddleEnabled)
		[self.batteryPctView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0].active = YES;
	else 
		[self.batteryPctView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:offsets*2].active = YES;
}

void commonInit(MTPillView *self) {
	self.batteryPctView = [[UIView alloc] init];
	self.batteryPctView.translatesAutoresizingMaskIntoConstraints = false;
	if (shrinkMiddleEnabled) {
		self.batteryPctView.layer.cornerRadius = 3;
	}
	if (enableOutline)
		self.batteryPctView.layer.cornerRadius = 2;

	[self addSubview: self.batteryPctView];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWidthConstraintForBatteryLevel) name: UIDeviceBatteryLevelDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColorState) name: @"UpdateLPMState" object:nil];
}

void updateColorState(MTPillView *self) {
	CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
	if ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) {
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	} else {
		if (batteryLevel <= 20)
			self.batteryPctView.backgroundColor = [UIColor redColor];
		else if (batteryLevel >= 21 && batteryLevel <= 35)
			self.batteryPctView.backgroundColor = [UIColor yellowColor];
		else
			self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
}

void updateWidthConstraintForBatteryLevel(MTPillView *self) {
	if (self.window == nil) 
		return;

	CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel] / 100;
	[self updateColorState];
	NSLog(@"batteryLevel: %f", batteryLevel);
	if (self.batteryWidthConstraint == nil) {
		self.batteryWidthConstraint = [NSLayoutConstraint constraintWithAnchor:self.batteryPctView.widthAnchor relatedBy:NSLayoutRelationEqual toAnchor:self.widthAnchor multiplier:batteryLevel constant:-(offsets*4)];
		self.batteryWidthConstraint.active = YES;
		[self addConstraint:self.batteryWidthConstraint];
		return;
	}
	if (self.batteryWidthConstraint.active == YES) {
		self.batteryWidthConstraint.active = NO;
		[self removeConstraint:self.batteryWidthConstraint];
		self.batteryWidthConstraint = [NSLayoutConstraint constraintWithAnchor:self.batteryPctView.widthAnchor relatedBy:NSLayoutRelationEqual toAnchor:self.widthAnchor multiplier:batteryLevel constant:-(offsets*4)];
		[self addConstraint:self.batteryWidthConstraint];	
	}
}

void commonDealloc(MTPillView *self) {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SpringBoard; @class MTStaticColorPillView; @class MTLumaDodgePillView; @class UIDevice; 


#line 98 "BatteryHomeBar.x"
static float (*_logos_orig$Universal$UIDevice$batteryLevel)(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL); static float _logos_method$Universal$UIDevice$batteryLevel(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Universal$MTStaticColorPillView$setPillColor$)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$Universal$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static MTStaticColorPillView* (*_logos_orig$Universal$MTStaticColorPillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* _logos_method$Universal$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* (*_logos_orig$Universal$MTStaticColorPillView$initWithFrame$settings$)(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* _logos_method$Universal$MTStaticColorPillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Universal$MTStaticColorPillView$didMoveToWindow)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Universal$MTStaticColorPillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$updateWidthConstraintForBatteryLevel(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$updateColorState(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Universal$SpringBoard$_batterySaverModeChanged$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, int); static void _logos_method$Universal$SpringBoard$_batterySaverModeChanged$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, int); 

static float _logos_method$Universal$UIDevice$batteryLevel(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return 100;
}


__attribute__((used)) static UIView * _logos_method$Universal$MTStaticColorPillView$batteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Universal$MTStaticColorPillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Universal$MTStaticColorPillView$setBatteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Universal$MTStaticColorPillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static NSLayoutConstraint * _logos_method$Universal$MTStaticColorPillView$batteryWidthConstraint(MTStaticColorPillView * __unused self, SEL __unused _cmd) { return (NSLayoutConstraint *)objc_getAssociatedObject(self, (void *)_logos_method$Universal$MTStaticColorPillView$batteryWidthConstraint); }; __attribute__((used)) static void _logos_method$Universal$MTStaticColorPillView$setBatteryWidthConstraint(MTStaticColorPillView * __unused self, SEL __unused _cmd, NSLayoutConstraint * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Universal$MTStaticColorPillView$batteryWidthConstraint, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static void _logos_method$Universal$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * a) {
	_logos_orig$Universal$MTStaticColorPillView$setPillColor$(self, _cmd, homeBarBackgroundColor);
}

static MTStaticColorPillView* _logos_method$Universal$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Universal$MTStaticColorPillView$initWithFrame$(self, _cmd, arg1);
	if (self)  {
		commonInit(self);
	}
	return self;
}

static MTStaticColorPillView* _logos_method$Universal$MTStaticColorPillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView* __unused self, SEL __unused _cmd, CGRect arg1, id arg2) _LOGOS_RETURN_RETAINED {

	self = _logos_orig$Universal$MTStaticColorPillView$initWithFrame$settings$(self, _cmd, arg1, arg2);
	if (self) {
		commonInit(self);
	}
	return self;
}

static void _logos_method$Universal$MTStaticColorPillView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Universal$MTStaticColorPillView$didMoveToWindow(self, _cmd);
	commonDidMoveToWindow(self);
	[self updateWidthConstraintForBatteryLevel];
}

static void _logos_method$Universal$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	commonDealloc(self);
	_logos_orig$Universal$MTStaticColorPillView$dealloc(self, _cmd);
}


static void _logos_method$Universal$MTStaticColorPillView$updateWidthConstraintForBatteryLevel(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateWidthConstraintForBatteryLevel(self);
}

static void _logos_method$Universal$MTStaticColorPillView$updateColorState(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateColorState(self);
}




static void _logos_method$Universal$SpringBoard$_batterySaverModeChanged$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) {
	_logos_orig$Universal$SpringBoard$_batterySaverModeChanged$(self, _cmd, arg1);
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateLPMState" object:self];
}




static void (*_logos_orig$Tweak12$MTLumaDodgePillView$setStyle$)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$Tweak12$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static MTLumaDodgePillView* (*_logos_orig$Tweak12$MTLumaDodgePillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak12$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Tweak12$MTLumaDodgePillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Tweak12$MTLumaDodgePillView$didMoveToWindow)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$updateWidthConstraintForBatteryLevel(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$updateColorState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); 

__attribute__((used)) static UIView * _logos_method$Tweak12$MTLumaDodgePillView$batteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak12$MTLumaDodgePillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Tweak12$MTLumaDodgePillView$setBatteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak12$MTLumaDodgePillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static NSLayoutConstraint * _logos_method$Tweak12$MTLumaDodgePillView$batteryWidthConstraint(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (NSLayoutConstraint *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak12$MTLumaDodgePillView$batteryWidthConstraint); }; __attribute__((used)) static void _logos_method$Tweak12$MTLumaDodgePillView$setBatteryWidthConstraint(MTLumaDodgePillView * __unused self, SEL __unused _cmd, NSLayoutConstraint * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak12$MTLumaDodgePillView$batteryWidthConstraint, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static void _logos_method$Tweak12$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1) {
	_logos_orig$Tweak12$MTLumaDodgePillView$setStyle$(self, _cmd, 0);
}
static MTLumaDodgePillView* _logos_method$Tweak12$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Tweak12$MTLumaDodgePillView$initWithFrame$(self, _cmd, arg1);
	if (self) {
		self.backgroundColor = homeBarBackgroundColor;
		commonInit(self);
	}
	return self;
}

static void _logos_method$Tweak12$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	commonDealloc(self);
	_logos_orig$Tweak12$MTLumaDodgePillView$dealloc(self, _cmd);
}
static void _logos_method$Tweak12$MTLumaDodgePillView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Tweak12$MTLumaDodgePillView$didMoveToWindow(self, _cmd);
	commonDidMoveToWindow(self);
	[self updateWidthConstraintForBatteryLevel];
}


static void _logos_method$Tweak12$MTLumaDodgePillView$updateWidthConstraintForBatteryLevel(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateWidthConstraintForBatteryLevel(self);
}

static void _logos_method$Tweak12$MTLumaDodgePillView$updateColorState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateColorState(self);
}




static MTLumaDodgePillView* (*_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id, long long) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id, long long) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* (*_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Tweak13$MTLumaDodgePillView$didMoveToWindow)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Tweak13$MTLumaDodgePillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$updateWidthConstraintForBatteryLevel(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$updateColorState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); 

__attribute__((used)) static UIView * _logos_method$Tweak13$MTLumaDodgePillView$batteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Tweak13$MTLumaDodgePillView$setBatteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIView * _logos_method$Tweak13$MTLumaDodgePillView$backgroundView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$backgroundView); }; __attribute__((used)) static void _logos_method$Tweak13$MTLumaDodgePillView$setBackgroundView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$backgroundView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static NSLayoutConstraint * _logos_method$Tweak13$MTLumaDodgePillView$batteryWidthConstraint(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (NSLayoutConstraint *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$batteryWidthConstraint); }; __attribute__((used)) static void _logos_method$Tweak13$MTLumaDodgePillView$setBatteryWidthConstraint(MTLumaDodgePillView * __unused self, SEL __unused _cmd, NSLayoutConstraint * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$batteryWidthConstraint, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1, id arg2, long long arg3) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$(self, _cmd, arg1, arg2, arg3);
	if (self) {
		self.backgroundView = [[UIView alloc] init];
		self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}
static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1, id arg2) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$(self, _cmd, arg1, arg2);
	if (self) {
		self.backgroundView = [[UIView alloc] init];
		self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}

static void _logos_method$Tweak13$MTLumaDodgePillView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Tweak13$MTLumaDodgePillView$didMoveToWindow(self, _cmd);
	commonDidMoveToWindow(self);

	[self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0].active = YES;
	[self.backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.0].active = YES;
	[self.backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0.0].active = YES;
	[self.backgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0.0].active = YES;

	[self updateWidthConstraintForBatteryLevel];
}

static void _logos_method$Tweak13$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	commonDealloc(self);
	_logos_orig$Tweak13$MTLumaDodgePillView$dealloc(self, _cmd);
}


static void _logos_method$Tweak13$MTLumaDodgePillView$updateWidthConstraintForBatteryLevel(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateWidthConstraintForBatteryLevel(self);
}

static void _logos_method$Tweak13$MTLumaDodgePillView$updateColorState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateColorState(self);
}




static __attribute__((constructor)) void _logosLocalCtor_689aa836(int __unused argc, char __unused **argv, char __unused **envp) {
	loadPrefs();
	[UIDevice currentDevice].batteryMonitoringEnabled = YES;
	if (enabled) {
			{Class _logos_class$Universal$UIDevice = objc_getClass("UIDevice"); MSHookMessageEx(_logos_class$Universal$UIDevice, @selector(batteryLevel), (IMP)&_logos_method$Universal$UIDevice$batteryLevel, (IMP*)&_logos_orig$Universal$UIDevice$batteryLevel);Class _logos_class$Universal$MTStaticColorPillView = objc_getClass("MTStaticColorPillView"); MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(setPillColor:), (IMP)&_logos_method$Universal$MTStaticColorPillView$setPillColor$, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$setPillColor$);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(initWithFrame:), (IMP)&_logos_method$Universal$MTStaticColorPillView$initWithFrame$, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$initWithFrame$);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(initWithFrame:settings:), (IMP)&_logos_method$Universal$MTStaticColorPillView$initWithFrame$settings$, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$initWithFrame$settings$);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(didMoveToWindow), (IMP)&_logos_method$Universal$MTStaticColorPillView$didMoveToWindow, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$didMoveToWindow);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, sel_registerName("dealloc"), (IMP)&_logos_method$Universal$MTStaticColorPillView$dealloc, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$dealloc);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(updateWidthConstraintForBatteryLevel), (IMP)&_logos_method$Universal$MTStaticColorPillView$updateWidthConstraintForBatteryLevel, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(updateColorState), (IMP)&_logos_method$Universal$MTStaticColorPillView$updateColorState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(batteryPctView), (IMP)&_logos_method$Universal$MTStaticColorPillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Universal$MTStaticColorPillView$setBatteryPctView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(NSLayoutConstraint *)); class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(batteryWidthConstraint), (IMP)&_logos_method$Universal$MTStaticColorPillView$batteryWidthConstraint, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(NSLayoutConstraint *)); class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(setBatteryWidthConstraint:), (IMP)&_logos_method$Universal$MTStaticColorPillView$setBatteryWidthConstraint, _typeEncoding); } Class _logos_class$Universal$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$Universal$SpringBoard, @selector(_batterySaverModeChanged:), (IMP)&_logos_method$Universal$SpringBoard$_batterySaverModeChanged$, (IMP*)&_logos_orig$Universal$SpringBoard$_batterySaverModeChanged$);}
		if (@available(iOS 13, *)) {
			{Class _logos_class$Tweak13$MTLumaDodgePillView = objc_getClass("MTLumaDodgePillView"); MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, @selector(initWithFrame:settings:graphicsQuality:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$);MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, @selector(initWithFrame:settings:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$);MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, @selector(didMoveToWindow), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$didMoveToWindow, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$didMoveToWindow);MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, sel_registerName("dealloc"), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$dealloc, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$dealloc);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(updateWidthConstraintForBatteryLevel), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$updateWidthConstraintForBatteryLevel, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(updateColorState), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$updateColorState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(batteryPctView), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$setBatteryPctView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(backgroundView), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$backgroundView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(setBackgroundView:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$setBackgroundView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(NSLayoutConstraint *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(batteryWidthConstraint), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$batteryWidthConstraint, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(NSLayoutConstraint *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(setBatteryWidthConstraint:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$setBatteryWidthConstraint, _typeEncoding); } }
		} else {
			{Class _logos_class$Tweak12$MTLumaDodgePillView = objc_getClass("MTLumaDodgePillView"); MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, @selector(setStyle:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$setStyle$, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$setStyle$);MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, @selector(initWithFrame:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$initWithFrame$, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$initWithFrame$);MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, sel_registerName("dealloc"), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$dealloc, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$dealloc);MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, @selector(didMoveToWindow), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$didMoveToWindow, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$didMoveToWindow);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(updateWidthConstraintForBatteryLevel), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$updateWidthConstraintForBatteryLevel, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(updateColorState), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$updateColorState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(batteryPctView), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$setBatteryPctView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(NSLayoutConstraint *)); class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(batteryWidthConstraint), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$batteryWidthConstraint, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(NSLayoutConstraint *)); class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(setBatteryWidthConstraint:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$setBatteryWidthConstraint, _typeEncoding); } }
		}
	}
}
