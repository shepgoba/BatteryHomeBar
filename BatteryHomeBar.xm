#import "BatteryHomeBar.h"
#import <libcolorpicker.h>

static const int offsets = 2;

static BOOL enabled;
static BOOL enableOutline;
static BOOL shrinkMiddleEnabled;
static BOOL transparentBackgroundEnabled;
static BOOL barGradientEnabled;
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

  	enabled = [([settings objectForKey:@"enabled"] ? [settings objectForKey:@"enabled"] : @(YES)) boolValue];
	enableOutline = [([settings objectForKey:@"enableOutline"] ? [settings objectForKey:@"enableOutline"] : @(YES)) boolValue];
	shrinkMiddleEnabled = [([settings objectForKey:@"shrinkMiddleEnabled"] ? [settings objectForKey:@"shrinkMiddleEnabled"] : @(NO)) boolValue];
	transparentBackgroundEnabled = [([settings objectForKey:@"transparentBackgroundEnabled"] ? [settings objectForKey:@"transparentBackgroundEnabled"] : @(NO)) boolValue];
	barGradientEnabled = [([settings objectForKey:@"barGradientEnabled"] ? [settings objectForKey:@"barGradientEnabled"] : @(NO)) boolValue];

	colors = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.bhbsettings.color.plist"];
	homeBarBackgroundColor = LCPParseColorString([colors objectForKey:@"homeBarBackgroundColor"], @"#000000");

}

%group Tweak
%hook SBIdleTimerGlobalCoordinator
-(void)_batterySaverModeDidChange
{
	%orig;
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EnableLPMBackground" object:self];
}
%end

%hook MTLumaDodgePillView

%property (nonatomic, retain) UIView *batteryPctView;
- (void) setStyle:(long long)arg1
{
	%orig(0);
}

- (id) initWithFrame:(CGRect)arg1
{
	self = %orig;
	if (self) 
	{
		if (transparentBackgroundEnabled)
		{
			self.backgroundColor = [UIColor clearColor];
		}
		else
		{
			self.backgroundColor = homeBarBackgroundColor;
		}

		self.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];


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
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: @"EnableLPMBackground" object:nil];
	}
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self 	name: @"EnableLPMBackground" object:nil];
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
	if ([[NSProcessInfo processInfo] isLowPowerModeEnabled])
	{
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	}
	else 
	{
		if (batteryLevel <= 20)
		{
			self.batteryPctView.backgroundColor = [UIColor redColor];
		}
		else if (batteryLevel >= 21 && batteryLevel <= 35)
		{
			self.batteryPctView.backgroundColor = [UIColor orangeColor];
		}
		else
		{
			self.batteryPctView.backgroundColor = [UIColor greenColor];
		}
	}

	
}

%end


%hook MTStaticColorPillView

%property (nonatomic, retain) UIView *batteryPctView;

- (void) setPillColor:(UIColor *)a
{
	if (transparentBackgroundEnabled)
	{
		%orig([UIColor clearColor]);
	}
	else
	{
		%orig(homeBarBackgroundColor);
	}
}

- (id) initWithFrame:(CGRect)arg1
{
	
	self = %orig;
	if (self) 
	{
		self.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

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
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState:) 	name: @"EnableLPMBackground" object:nil];
	}
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self 	name: @"EnableLPMBackground" object:nil];
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

	if ([[NSProcessInfo processInfo] isLowPowerModeEnabled])
	{
		self.batteryPctView.backgroundColor = [UIColor yellowColor];
	}
	else 
	{
		if (batteryLevel <= 20)
		{
			self.batteryPctView.backgroundColor = [UIColor redColor];
		}
		else if (batteryLevel >= 21 && batteryLevel <= 35)
		{
			self.batteryPctView.backgroundColor = [UIColor orangeColor];
		}
		else
		{
			self.batteryPctView.backgroundColor = [UIColor greenColor];
		}
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
