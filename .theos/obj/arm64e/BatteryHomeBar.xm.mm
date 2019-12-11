#line 1 "BatteryHomeBar.xm"
#import "BatteryHomeBar.h"
#import <libcolorpicker.h>

static const int offsets = 2;
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

	colors = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.bhbsettings.color.plist"];
	homeBarBackgroundColor = LCPParseColorString([colors objectForKey:@"homeBarBackgroundColor"], @"#000000");
}

static void updateBatteryBarState(MTPillView *self) {
	float batteryLevel = [UIDevice currentDevice].batteryLevel;

	if (shrinkMiddleEnabled && enableOutline)
		self.batteryPctView.frame = CGRectMake(offsets + ((1 - batteryLevel) * (self.frame.size.width / 2)), offsets - 1, (self.frame.size.width * batteryLevel) - offsets * 2, self.frame.size.height - offsets);
	else if (shrinkMiddleEnabled)
		self.batteryPctView.frame = CGRectMake((1 - batteryLevel) * (self.frame.size.width / 2), 0, (self.frame.size.width * batteryLevel), self.frame.size.height);
	else if (enableOutline)
		self.batteryPctView.frame = CGRectMake(offsets, offsets - 1, (self.frame.size.width - offsets * 2) * batteryLevel, self.frame.size.height - offsets);
	else
		self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * (batteryLevel), self.frame.size.height);

	if ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) {
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	} else {
		if (batteryLevel * 100 <= 20)
			self.batteryPctView.backgroundColor = [UIColor redColor];
		else if (batteryLevel * 100 >= 21 && batteryLevel * 100 <= 35)
			self.batteryPctView.backgroundColor = [UIColor yellowColor];
		else
			self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
}

static void commonInit(MTPillView *self) {
	self.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

	if (shrinkMiddleEnabled && !enableOutline)
		self.batteryPctView.layer.cornerRadius = 3;
	if (enableOutline)
		self.batteryPctView.layer.cornerRadius = 2;

	[self addSubview: self.batteryPctView];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState) name: UIDeviceBatteryLevelDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState) name: @"UpdateBHBState" object:nil];
}

static void commonDealloc(MTPillView *self) {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateBHBState" object:nil];
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

@class SpringBoard; @class MTStaticColorPillView; @class MTLumaDodgePillView; 


#line 77 "BatteryHomeBar.xm"
static void (*_logos_orig$Universal$MTStaticColorPillView$setPillColor$)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$Universal$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static MTStaticColorPillView* (*_logos_orig$Universal$MTStaticColorPillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* _logos_method$Universal$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* (*_logos_orig$Universal$MTStaticColorPillView$initWithFrame$settings$)(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* _logos_method$Universal$MTStaticColorPillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Universal$MTStaticColorPillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Universal$MTStaticColorPillView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$MTStaticColorPillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Universal$SpringBoard$_batterySaverModeChanged$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, int); static void _logos_method$Universal$SpringBoard$_batterySaverModeChanged$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, int); 


__attribute__((used)) static UIView * _logos_method$Universal$MTStaticColorPillView$batteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Universal$MTStaticColorPillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Universal$MTStaticColorPillView$setBatteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Universal$MTStaticColorPillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
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

static void _logos_method$Universal$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	commonDealloc(self);
	_logos_orig$Universal$MTStaticColorPillView$dealloc(self, _cmd);
}

static void _logos_method$Universal$MTStaticColorPillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Universal$MTStaticColorPillView$layoutSubviews(self, _cmd);
	[self updateBatteryBarState];
}


static void _logos_method$Universal$MTStaticColorPillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateBatteryBarState(self);
}



static void _logos_method$Universal$SpringBoard$_batterySaverModeChanged$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) {
	_logos_orig$Universal$SpringBoard$_batterySaverModeChanged$(self, _cmd, arg1);
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateBHBState" object:self];
}



static void (*_logos_orig$Tweak12$MTLumaDodgePillView$setStyle$)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$Tweak12$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static MTLumaDodgePillView* (*_logos_orig$Tweak12$MTLumaDodgePillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak12$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Tweak12$MTLumaDodgePillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Tweak12$MTLumaDodgePillView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak12$MTLumaDodgePillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); 

__attribute__((used)) static UIView * _logos_method$Tweak12$MTLumaDodgePillView$batteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak12$MTLumaDodgePillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Tweak12$MTLumaDodgePillView$setBatteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak12$MTLumaDodgePillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
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

static void _logos_method$Tweak12$MTLumaDodgePillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Tweak12$MTLumaDodgePillView$layoutSubviews(self, _cmd);
	[self updateBatteryBarState];
}


static void _logos_method$Tweak12$MTLumaDodgePillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateBatteryBarState(self);
}



static MTLumaDodgePillView* (*_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id, long long) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id, long long) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* (*_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Tweak13$MTLumaDodgePillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Tweak13$MTLumaDodgePillView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak13$MTLumaDodgePillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); 

__attribute__((used)) static UIView * _logos_method$Tweak13$MTLumaDodgePillView$batteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Tweak13$MTLumaDodgePillView$setBatteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIView * _logos_method$Tweak13$MTLumaDodgePillView$backgroundView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$backgroundView); }; __attribute__((used)) static void _logos_method$Tweak13$MTLumaDodgePillView$setBackgroundView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak13$MTLumaDodgePillView$backgroundView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1, id arg2, long long arg3) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$(self, _cmd, arg1, arg2, arg3);
	if (self) {
		self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}

static MTLumaDodgePillView* _logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1, id arg2) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$(self, _cmd, arg1, arg2);
	if (self) {
		self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}

static void _logos_method$Tweak13$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	commonDealloc(self);
	_logos_orig$Tweak13$MTLumaDodgePillView$dealloc(self, _cmd);
}

static void _logos_method$Tweak13$MTLumaDodgePillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Tweak13$MTLumaDodgePillView$layoutSubviews(self, _cmd);
	[self updateBatteryBarState];
}


static void _logos_method$Tweak13$MTLumaDodgePillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	updateBatteryBarState(self);
	self.backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}



static __attribute__((constructor)) void _logosLocalCtor_a863115f(int __unused argc, char __unused **argv, char __unused **envp) {
	loadPrefs();

	if (enabled) {
		{Class _logos_class$Universal$MTStaticColorPillView = objc_getClass("MTStaticColorPillView"); MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(setPillColor:), (IMP)&_logos_method$Universal$MTStaticColorPillView$setPillColor$, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$setPillColor$);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(initWithFrame:), (IMP)&_logos_method$Universal$MTStaticColorPillView$initWithFrame$, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$initWithFrame$);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(initWithFrame:settings:), (IMP)&_logos_method$Universal$MTStaticColorPillView$initWithFrame$settings$, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$initWithFrame$settings$);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, sel_registerName("dealloc"), (IMP)&_logos_method$Universal$MTStaticColorPillView$dealloc, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$dealloc);MSHookMessageEx(_logos_class$Universal$MTStaticColorPillView, @selector(layoutSubviews), (IMP)&_logos_method$Universal$MTStaticColorPillView$layoutSubviews, (IMP*)&_logos_orig$Universal$MTStaticColorPillView$layoutSubviews);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(updateBatteryBarState), (IMP)&_logos_method$Universal$MTStaticColorPillView$updateBatteryBarState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(batteryPctView), (IMP)&_logos_method$Universal$MTStaticColorPillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Universal$MTStaticColorPillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Universal$MTStaticColorPillView$setBatteryPctView, _typeEncoding); } Class _logos_class$Universal$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$Universal$SpringBoard, @selector(_batterySaverModeChanged:), (IMP)&_logos_method$Universal$SpringBoard$_batterySaverModeChanged$, (IMP*)&_logos_orig$Universal$SpringBoard$_batterySaverModeChanged$);}
		if (@available(iOS 13, *)) {
			{Class _logos_class$Tweak13$MTLumaDodgePillView = objc_getClass("MTLumaDodgePillView"); MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, @selector(initWithFrame:settings:graphicsQuality:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$graphicsQuality$);MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, @selector(initWithFrame:settings:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$initWithFrame$settings$, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$initWithFrame$settings$);MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, sel_registerName("dealloc"), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$dealloc, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$dealloc);MSHookMessageEx(_logos_class$Tweak13$MTLumaDodgePillView, @selector(layoutSubviews), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$layoutSubviews, (IMP*)&_logos_orig$Tweak13$MTLumaDodgePillView$layoutSubviews);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(updateBatteryBarState), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$updateBatteryBarState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(batteryPctView), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$setBatteryPctView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(backgroundView), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$backgroundView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak13$MTLumaDodgePillView, @selector(setBackgroundView:), (IMP)&_logos_method$Tweak13$MTLumaDodgePillView$setBackgroundView, _typeEncoding); } }
		} else {
			{Class _logos_class$Tweak12$MTLumaDodgePillView = objc_getClass("MTLumaDodgePillView"); MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, @selector(setStyle:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$setStyle$, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$setStyle$);MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, @selector(initWithFrame:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$initWithFrame$, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$initWithFrame$);MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, sel_registerName("dealloc"), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$dealloc, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$dealloc);MSHookMessageEx(_logos_class$Tweak12$MTLumaDodgePillView, @selector(layoutSubviews), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$layoutSubviews, (IMP*)&_logos_orig$Tweak12$MTLumaDodgePillView$layoutSubviews);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(updateBatteryBarState), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$updateBatteryBarState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(batteryPctView), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak12$MTLumaDodgePillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Tweak12$MTLumaDodgePillView$setBatteryPctView, _typeEncoding); } }
		}
	}
}
