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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState) name: @"EnableLPMBackground" object:nil];
}

static void commonDealloc(MTPillView *self) {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnableLPMBackground" object:nil];
}

%group Universal

%hook MTStaticColorPillView
%property (nonatomic, retain) UIView *batteryPctView;
-(void)setPillColor:(UIColor *)a {
	%orig(homeBarBackgroundColor);
}

-(id)initWithFrame:(CGRect)arg1 {
	self = %orig;
	if (self)  {
		commonInit(self);
	}
	return self;
}

-(id)initWithFrame:(CGRect)arg1 settings:(id)arg2 {

	self = %orig;
	if (self) {
		commonInit(self);
	}
	return self;
}

-(void)dealloc {
	commonDealloc(self);
	%orig;
}

-(void)layoutSubviews {
	%orig;
	[self updateBatteryBarState];
}

%new
-(void)updateBatteryBarState {
	updateBatteryBarState(self);
}
%end

%hook SpringBoard
-(void)_batterySaverModeChanged:(int)arg1 {
	%orig;
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EnableLPMBackground" object:self];
}
%end
%end

%group Tweak12
%hook MTLumaDodgePillView
%property (nonatomic, retain) UIView *batteryPctView;
-(void)setStyle:(long long)arg1 {
	%orig(0);
}
-(id)initWithFrame:(CGRect)arg1 {
	self = %orig;
	if (self) {
		self.backgroundColor = homeBarBackgroundColor;
		commonInit(self);
	}
	return self;
}

-(void)dealloc {
	commonDealloc(self);
	%orig;
}

-(void)layoutSubviews {
	%orig;
	[self updateBatteryBarState];
}

%new
-(void)updateBatteryBarState {
	updateBatteryBarState(self);
}
%end
%end

%group Tweak13
%hook MTLumaDodgePillView
%property (nonatomic, retain) UIView *batteryPctView;
%property (nonatomic, retain) UIView *backgroundView;

-(id)initWithFrame:(CGRect)arg1 settings:(id)arg2 graphicsQuality:(long long)arg3 {
	self = %orig;
	if (self) {
		self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}

-(id)initWithFrame:(CGRect)arg1 settings:(id)arg2 {
	self = %orig;
	if (self) {
		self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}

-(void)dealloc {
	commonDealloc(self);
	%orig;
}

-(void)layoutSubviews {
	%orig;
	[self updateBatteryBarState];
}

%new
-(void)updateBatteryBarState {
	updateBatteryBarState(self);
	self.backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
%end
%end

%ctor {
	loadPrefs();

	if (enabled) {
		%init(Universal);
		if (@available(iOS 13, *)) {
			%init(Tweak13);
		} else {
			%init(Tweak12);
		}
	}
}
