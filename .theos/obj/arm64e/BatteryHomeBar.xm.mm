#line 1 "BatteryHomeBar.xm"
#import "BatteryHomeBar.h"
#import <libcolorpicker.h>

static const int offsets = 2;

static BOOL enabled;
static BOOL enableOutline;
static BOOL shrinkMiddleEnabled;
static UIColor *homeBarBackgroundColor;

static void loadPrefs() 
{
	static NSMutableDictionary *settings;
	static NSMutableDictionary *colors;
	
	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.shepgoba.bhbsettings"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if(keyList) {
		settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.shepgoba.bhbsettings"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
		CFRelease(keyList);
	} else {
		settings = nil;
	}

	if (settings == nil)
	{
		settings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.bhbsettings.plist"];
	}

	colors = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.bhbsettings.color.plist"];

  	enabled = [([settings objectForKey:@"enabled"] ? [settings objectForKey:@"enabled"] : @(YES)) boolValue];
	enableOutline = [([settings objectForKey:@"enableOutline"] ? [settings objectForKey:@"enableOutline"] : @(YES)) boolValue];
	shrinkMiddleEnabled = [([settings objectForKey:@"shrinkMiddleEnabled"] ? [settings objectForKey:@"shrinkMiddleEnabled"] : @(NO)) boolValue];

	homeBarBackgroundColor = LCPParseColorString([colors objectForKey:@"homeBarBackgroundColor"], @"#000000");

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

@class MTStaticColorPillView; @class MTLumaDodgePillView; 


#line 39 "BatteryHomeBar.xm"
static void (*_logos_orig$Tweak$MTLumaDodgePillView$setStyle$)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$Tweak$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static MTLumaDodgePillView* (*_logos_orig$Tweak$MTLumaDodgePillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$Tweak$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Tweak$MTLumaDodgePillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Tweak$MTLumaDodgePillView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak$MTLumaDodgePillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak$MTLumaDodgePillView$updateBatteryBarState$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, NSNotification *); static void (*_logos_orig$Tweak$MTStaticColorPillView$setPillColor$)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$Tweak$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static MTStaticColorPillView* (*_logos_orig$Tweak$MTStaticColorPillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* _logos_method$Tweak$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Tweak$MTStaticColorPillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$Tweak$MTStaticColorPillView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak$MTStaticColorPillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Tweak$MTStaticColorPillView$updateBatteryBarState$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, NSNotification *); 



__attribute__((used)) static UIView * _logos_method$Tweak$MTLumaDodgePillView$batteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak$MTLumaDodgePillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Tweak$MTLumaDodgePillView$setBatteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak$MTLumaDodgePillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static void _logos_method$Tweak$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1) {
	_logos_orig$Tweak$MTLumaDodgePillView$setStyle$(self, _cmd, 0);
}


static MTLumaDodgePillView* _logos_method$Tweak$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
	self = _logos_orig$Tweak$MTLumaDodgePillView$initWithFrame$(self, _cmd, arg1);
	if (self) 
	{

		self.backgroundColor = homeBarBackgroundColor;

		self.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		if (shrinkMiddleEnabled)
		{
			self.batteryPctView.layer.cornerRadius = 3;
		}
		if (enableOutline)
		{
			self.batteryPctView.layer.cornerRadius = 2;
		}

		[self addSubview: self.batteryPctView];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: UIDeviceBatteryLevelDidChangeNotification object:nil];
	}
	return self;
}


static void _logos_method$Tweak$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	_logos_orig$Tweak$MTLumaDodgePillView$dealloc(self, _cmd);
}



static void _logos_method$Tweak$MTLumaDodgePillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Tweak$MTLumaDodgePillView$layoutSubviews(self, _cmd);
	[self updateBatteryBarState:nil];
}

 

static void _logos_method$Tweak$MTLumaDodgePillView$updateBatteryBarState$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSNotification * notification) {
	float batteryLevel = [UIDevice currentDevice].batteryLevel * 100;

	if (shrinkMiddleEnabled && enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets + ((1 - batteryLevel / 100) * (self.frame.size.width / 2)), offsets - 1, (self.frame.size.width * (batteryLevel / 100)) - offsets * 2, self.frame.size.height - (offsets));
	}
	else if (shrinkMiddleEnabled)
	{
		self.batteryPctView.frame = CGRectMake((1 - batteryLevel / 100) * (self.frame.size.width / 2), 0, (self.frame.size.width * (batteryLevel / 100)), self.frame.size.height);
	}
	else if (enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets, offsets - 1, (self.frame.size.width - offsets * 2) * (batteryLevel / 100), self.frame.size.height - (offsets));
	}
	else
	{
		self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * (batteryLevel / 100), self.frame.size.height);
	}

	if (batteryLevel <= 20)
	{
		self.batteryPctView.backgroundColor = [UIColor redColor];
	}
	else if (batteryLevel >= 21 && batteryLevel <= 35)
	{
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	}
	else
	{
		self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
	
}






__attribute__((used)) static UIView * _logos_method$Tweak$MTStaticColorPillView$batteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$Tweak$MTStaticColorPillView$batteryPctView); }; __attribute__((used)) static void _logos_method$Tweak$MTStaticColorPillView$setBatteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$Tweak$MTStaticColorPillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }


static void _logos_method$Tweak$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * a) {
	_logos_orig$Tweak$MTStaticColorPillView$setPillColor$(self, _cmd, homeBarBackgroundColor);
}


static MTStaticColorPillView* _logos_method$Tweak$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
	
	self = _logos_orig$Tweak$MTStaticColorPillView$initWithFrame$(self, _cmd, arg1);
	if (self) 
	{
		self.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		if (shrinkMiddleEnabled)
		{
			self.batteryPctView.layer.cornerRadius = 3;
		}
		if (enableOutline)
		{
			self.batteryPctView.layer.cornerRadius = 2;
		}

		[self addSubview: self.batteryPctView];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: UIDeviceBatteryLevelDidChangeNotification object:nil];
	}
	return self;
}


static void _logos_method$Tweak$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	_logos_orig$Tweak$MTStaticColorPillView$dealloc(self, _cmd);

}



static void _logos_method$Tweak$MTStaticColorPillView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$Tweak$MTStaticColorPillView$layoutSubviews(self, _cmd);
	[self updateBatteryBarState:nil];
}

 

static void _logos_method$Tweak$MTStaticColorPillView$updateBatteryBarState$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSNotification * notification) {
	float batteryLevel = [UIDevice currentDevice].batteryLevel * 100;

	if (shrinkMiddleEnabled && enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets + ((1 - batteryLevel / 100) * (self.frame.size.width / 2)), offsets - 1, (self.frame.size.width * (batteryLevel / 100)) - offsets * 2, self.frame.size.height - (offsets));
	}
	else if (shrinkMiddleEnabled)
	{
		self.batteryPctView.frame = CGRectMake((1 - batteryLevel / 100) * (self.frame.size.width / 2), 0, (self.frame.size.width * (batteryLevel / 100)), self.frame.size.height);
	}
	else if (enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets, offsets - 1, (self.frame.size.width - offsets * 2) * (batteryLevel / 100), self.frame.size.height - (offsets));
	}
	else
	{
		self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * (batteryLevel / 100), self.frame.size.height);
	}

	if (batteryLevel <= 20)
	{
		self.batteryPctView.backgroundColor = [UIColor redColor];
	}
	else if (batteryLevel >= 21 && batteryLevel <= 35)
	{
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	}
	else
	{
		self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
	
}




static __attribute__((constructor)) void _logosLocalCtor_6f3ef77a(int __unused argc, char __unused **argv, char __unused **envp)
{
	loadPrefs();

	if (enabled)
	{
		{Class _logos_class$Tweak$MTLumaDodgePillView = objc_getClass("MTLumaDodgePillView"); MSHookMessageEx(_logos_class$Tweak$MTLumaDodgePillView, @selector(setStyle:), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$setStyle$, (IMP*)&_logos_orig$Tweak$MTLumaDodgePillView$setStyle$);MSHookMessageEx(_logos_class$Tweak$MTLumaDodgePillView, @selector(initWithFrame:), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$initWithFrame$, (IMP*)&_logos_orig$Tweak$MTLumaDodgePillView$initWithFrame$);MSHookMessageEx(_logos_class$Tweak$MTLumaDodgePillView, sel_registerName("dealloc"), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$dealloc, (IMP*)&_logos_orig$Tweak$MTLumaDodgePillView$dealloc);MSHookMessageEx(_logos_class$Tweak$MTLumaDodgePillView, @selector(layoutSubviews), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$layoutSubviews, (IMP*)&_logos_orig$Tweak$MTLumaDodgePillView$layoutSubviews);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSNotification *), strlen(@encode(NSNotification *))); i += strlen(@encode(NSNotification *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak$MTLumaDodgePillView, @selector(updateBatteryBarState:), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$updateBatteryBarState$, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak$MTLumaDodgePillView, @selector(batteryPctView), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak$MTLumaDodgePillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Tweak$MTLumaDodgePillView$setBatteryPctView, _typeEncoding); } Class _logos_class$Tweak$MTStaticColorPillView = objc_getClass("MTStaticColorPillView"); MSHookMessageEx(_logos_class$Tweak$MTStaticColorPillView, @selector(setPillColor:), (IMP)&_logos_method$Tweak$MTStaticColorPillView$setPillColor$, (IMP*)&_logos_orig$Tweak$MTStaticColorPillView$setPillColor$);MSHookMessageEx(_logos_class$Tweak$MTStaticColorPillView, @selector(initWithFrame:), (IMP)&_logos_method$Tweak$MTStaticColorPillView$initWithFrame$, (IMP*)&_logos_orig$Tweak$MTStaticColorPillView$initWithFrame$);MSHookMessageEx(_logos_class$Tweak$MTStaticColorPillView, sel_registerName("dealloc"), (IMP)&_logos_method$Tweak$MTStaticColorPillView$dealloc, (IMP*)&_logos_orig$Tweak$MTStaticColorPillView$dealloc);MSHookMessageEx(_logos_class$Tweak$MTStaticColorPillView, @selector(layoutSubviews), (IMP)&_logos_method$Tweak$MTStaticColorPillView$layoutSubviews, (IMP*)&_logos_orig$Tweak$MTStaticColorPillView$layoutSubviews);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSNotification *), strlen(@encode(NSNotification *))); i += strlen(@encode(NSNotification *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Tweak$MTStaticColorPillView, @selector(updateBatteryBarState:), (IMP)&_logos_method$Tweak$MTStaticColorPillView$updateBatteryBarState$, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$Tweak$MTStaticColorPillView, @selector(batteryPctView), (IMP)&_logos_method$Tweak$MTStaticColorPillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$Tweak$MTStaticColorPillView, @selector(setBatteryPctView:), (IMP)&_logos_method$Tweak$MTStaticColorPillView$setBatteryPctView, _typeEncoding); } }
	}
}
