#line 1 "Tweak.xm"
@interface MTLumaDodgePillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState;
- (id) _viewControllerForAncestor;
@end

@interface MTStaticColorPillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState;
- (id) _viewControllerForAncestor;
@end


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

@class MTLumaDodgePillView; @class MTStaticColorPillView; 
static void (*_logos_orig$_ungrouped$MTLumaDodgePillView$setStyle$)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static void _logos_method$_ungrouped$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL, long long); static MTLumaDodgePillView* (*_logos_orig$_ungrouped$MTLumaDodgePillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTLumaDodgePillView* _logos_method$_ungrouped$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$_ungrouped$MTLumaDodgePillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MTLumaDodgePillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$MTStaticColorPillView$setPillColor$)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$_ungrouped$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL, UIColor *); static MTStaticColorPillView* (*_logos_orig$_ungrouped$MTStaticColorPillView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static MTStaticColorPillView* _logos_method$_ungrouped$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$_ungrouped$MTStaticColorPillView$dealloc)(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MTStaticColorPillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST, SEL); 

#line 13 "Tweak.xm"
#define HOMEBAR_BACKGROUND_COLOR [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.f/255.0f alpha:1]


__attribute__((used)) static UIView * _logos_method$_ungrouped$MTLumaDodgePillView$batteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$MTLumaDodgePillView$batteryPctView); }; __attribute__((used)) static void _logos_method$_ungrouped$MTLumaDodgePillView$setBatteryPctView(MTLumaDodgePillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$MTLumaDodgePillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static void _logos_method$_ungrouped$MTLumaDodgePillView$setStyle$(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1) {
	_logos_orig$_ungrouped$MTLumaDodgePillView$setStyle$(self, _cmd, 0);
}


static MTLumaDodgePillView* _logos_method$_ungrouped$MTLumaDodgePillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTLumaDodgePillView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
	MTLumaDodgePillView *orig = _logos_orig$_ungrouped$MTLumaDodgePillView$initWithFrame$(self, _cmd, arg1);
	orig.backgroundColor = HOMEBAR_BACKGROUND_COLOR;

	orig.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, arg1.size.width, arg1.size.height)];
	[orig updateBatteryBarState];

	[orig addSubview: orig.batteryPctView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState) name:@"UIDeviceBatteryLevelDidChangeNotification" object:nil];

	return orig;
}


static void _logos_method$_ungrouped$MTLumaDodgePillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	_logos_orig$_ungrouped$MTLumaDodgePillView$dealloc(self, _cmd);
}

 

static void _logos_method$_ungrouped$MTLumaDodgePillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTLumaDodgePillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"updated hs");
	
	float batteryLevel = [UIDevice currentDevice].batteryLevel;

	self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * batteryLevel, self.frame.size.height);

	if (batteryLevel * 100 <= 20)
	{
		self.batteryPctView.backgroundColor = [UIColor redColor];
	}
	else
	{
		self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
	
}





__attribute__((used)) static UIView * _logos_method$_ungrouped$MTStaticColorPillView$batteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$MTStaticColorPillView$batteryPctView); }; __attribute__((used)) static void _logos_method$_ungrouped$MTStaticColorPillView$setBatteryPctView(MTStaticColorPillView * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$MTStaticColorPillView$batteryPctView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }


static void _logos_method$_ungrouped$MTStaticColorPillView$setPillColor$(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * a) {
	_logos_orig$_ungrouped$MTStaticColorPillView$setPillColor$(self, _cmd, HOMEBAR_BACKGROUND_COLOR);
}


static MTStaticColorPillView* _logos_method$_ungrouped$MTStaticColorPillView$initWithFrame$(_LOGOS_SELF_TYPE_INIT MTStaticColorPillView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
	
	MTStaticColorPillView *orig = _logos_orig$_ungrouped$MTStaticColorPillView$initWithFrame$(self, _cmd, arg1);
	orig.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, arg1.size.width, arg1.size.height)];
	[orig updateBatteryBarState];

	[orig addSubview: orig.batteryPctView];

	[[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(updateBatteryBarState) 
        name:@"UIDeviceBatteryLevelDidChangeNotification"
        object:nil];

	return orig;
}


static void _logos_method$_ungrouped$MTStaticColorPillView$dealloc(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	_logos_orig$_ungrouped$MTStaticColorPillView$dealloc(self, _cmd);
}

 

static void _logos_method$_ungrouped$MTStaticColorPillView$updateBatteryBarState(_LOGOS_SELF_TYPE_NORMAL MTStaticColorPillView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSLog(@"updated ls ");
	
	float batteryLevel = [UIDevice currentDevice].batteryLevel;

	self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * batteryLevel, self.frame.size.height);

	if (batteryLevel * 100 <= 20)
	{
		self.batteryPctView.backgroundColor = [UIColor redColor];
	}
	else
	{
		self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
	
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MTLumaDodgePillView = objc_getClass("MTLumaDodgePillView"); MSHookMessageEx(_logos_class$_ungrouped$MTLumaDodgePillView, @selector(setStyle:), (IMP)&_logos_method$_ungrouped$MTLumaDodgePillView$setStyle$, (IMP*)&_logos_orig$_ungrouped$MTLumaDodgePillView$setStyle$);MSHookMessageEx(_logos_class$_ungrouped$MTLumaDodgePillView, @selector(initWithFrame:), (IMP)&_logos_method$_ungrouped$MTLumaDodgePillView$initWithFrame$, (IMP*)&_logos_orig$_ungrouped$MTLumaDodgePillView$initWithFrame$);MSHookMessageEx(_logos_class$_ungrouped$MTLumaDodgePillView, sel_registerName("dealloc"), (IMP)&_logos_method$_ungrouped$MTLumaDodgePillView$dealloc, (IMP*)&_logos_orig$_ungrouped$MTLumaDodgePillView$dealloc);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MTLumaDodgePillView, @selector(updateBatteryBarState), (IMP)&_logos_method$_ungrouped$MTLumaDodgePillView$updateBatteryBarState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$_ungrouped$MTLumaDodgePillView, @selector(batteryPctView), (IMP)&_logos_method$_ungrouped$MTLumaDodgePillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$_ungrouped$MTLumaDodgePillView, @selector(setBatteryPctView:), (IMP)&_logos_method$_ungrouped$MTLumaDodgePillView$setBatteryPctView, _typeEncoding); } Class _logos_class$_ungrouped$MTStaticColorPillView = objc_getClass("MTStaticColorPillView"); MSHookMessageEx(_logos_class$_ungrouped$MTStaticColorPillView, @selector(setPillColor:), (IMP)&_logos_method$_ungrouped$MTStaticColorPillView$setPillColor$, (IMP*)&_logos_orig$_ungrouped$MTStaticColorPillView$setPillColor$);MSHookMessageEx(_logos_class$_ungrouped$MTStaticColorPillView, @selector(initWithFrame:), (IMP)&_logos_method$_ungrouped$MTStaticColorPillView$initWithFrame$, (IMP*)&_logos_orig$_ungrouped$MTStaticColorPillView$initWithFrame$);MSHookMessageEx(_logos_class$_ungrouped$MTStaticColorPillView, sel_registerName("dealloc"), (IMP)&_logos_method$_ungrouped$MTStaticColorPillView$dealloc, (IMP*)&_logos_orig$_ungrouped$MTStaticColorPillView$dealloc);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MTStaticColorPillView, @selector(updateBatteryBarState), (IMP)&_logos_method$_ungrouped$MTStaticColorPillView$updateBatteryBarState, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$_ungrouped$MTStaticColorPillView, @selector(batteryPctView), (IMP)&_logos_method$_ungrouped$MTStaticColorPillView$batteryPctView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$_ungrouped$MTStaticColorPillView, @selector(setBatteryPctView:), (IMP)&_logos_method$_ungrouped$MTStaticColorPillView$setBatteryPctView, _typeEncoding); } } }
#line 116 "Tweak.xm"
