#import "BatteryHomeBar.h"
#import <libcolorpicker.h>

static int offsets = 2;

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

%group Tweak

%hook MTLumaDodgePillView

%property (nonatomic, retain) UIView *batteryPctView;
- (void) setStyle:(long long)arg1
{
	%orig(0);
}

- (id) initWithFrame:(CGRect)arg1
{
	MTLumaDodgePillView *orig = %orig;
	orig.backgroundColor = homeBarBackgroundColor;

	orig.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	if (enableOutline || shrinkMiddleEnabled)
	{
		orig.batteryPctView.layer.cornerRadius = 2;
	}

	[orig addSubview: orig.batteryPctView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: UIDeviceBatteryLevelDidChangeNotification object:nil];
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: NSProcessInfoPowerStateDidChangeNotification object:nil];
	return orig;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:NSProcessInfoPowerStateDidChangeNotification  object:nil];

	%orig;
}

//Needed for orientation changes
- (void) layoutSubviews
{
	%orig;
	[self updateBatteryBarState:nil];
}

%new 
- (void) updateBatteryBarState:(NSNotification *)notification
{
	float batteryLevel = [UIDevice currentDevice].batteryLevel * 100;

	if (shrinkMiddleEnabled && enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets + ((1 - batteryLevel / 100) * (self.frame.size.width / 2)), offsets - 1, (self.frame.size.width * (batteryLevel / 100)) - offsets * 2, self.frame.size.height - (offsets));
	}
	else if (shrinkMiddleEnabled)
	{
		self.batteryPctView.frame = CGRectMake((1 - batteryLevel / 100) * (self.frame.size.width / 2), offsets - 1, (self.frame.size.width * (batteryLevel / 100)), self.frame.size.height - (offsets));
	}
	else if (enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets, offsets - 1, (self.frame.size.width - offsets * 2) * (batteryLevel / 100), self.frame.size.height - (offsets));
	}
	else
	{
		self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * (batteryLevel / 100), self.frame.size.height);
	}

	/*if ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) 
	{
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	}
	else
	{*/
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
%end


%hook MTStaticColorPillView

%property (nonatomic, retain) UIView *batteryPctView;

- (void) setPillColor:(UIColor *)a
{
	%orig(homeBarBackgroundColor);
}

- (id) initWithFrame:(CGRect)arg1
{
	
	MTStaticColorPillView *orig = %orig;
	orig.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	if (enableOutline || shrinkMiddleEnabled)
	{
		orig.batteryPctView.layer.cornerRadius = 2;
	}

	[orig addSubview: orig.batteryPctView];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: UIDeviceBatteryLevelDidChangeNotification object:nil];
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: NSProcessInfoPowerStateDidChangeNotification object:nil];

	return orig;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:NSProcessInfoPowerStateDidChangeNotification  object:nil];
	%orig;

}

//Needed for orientation changes
- (void) layoutSubviews
{
	%orig;
	[self updateBatteryBarState:nil];
}

%new 
- (void) updateBatteryBarState:(NSNotification *)notification
{
	float batteryLevel = [UIDevice currentDevice].batteryLevel * 100;

	if (shrinkMiddleEnabled && enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets + ((1 - batteryLevel / 100) * (self.frame.size.width / 2)), offsets - 1, (self.frame.size.width * (batteryLevel / 100)) - offsets * 2, self.frame.size.height - (offsets));
	}
	else if (shrinkMiddleEnabled)
	{
		self.batteryPctView.frame = CGRectMake((1 - batteryLevel / 100) * (self.frame.size.width / 2), offsets - 1, (self.frame.size.width * (batteryLevel / 100)), self.frame.size.height - (offsets));
	}
	else if (enableOutline)
	{
		self.batteryPctView.frame = CGRectMake(offsets, offsets - 1, (self.frame.size.width - offsets * 2) * (batteryLevel / 100), self.frame.size.height - (offsets));
	}
	else
	{
		self.batteryPctView.frame = CGRectMake(0, 0, self.frame.size.width * (batteryLevel / 100), self.frame.size.height);
	}

	/*if ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) 
	{
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	}
	else
	{*/
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
%end
%end

%ctor
{
	loadPrefs();

	if (enabled)
	{
		%init(Tweak);
	}
}
