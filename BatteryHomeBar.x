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
		if (batteryLevel <= 0.20)
			self.batteryPctView.backgroundColor = [UIColor redColor];
		else if (batteryLevel >= 0.21 && batteryLevel <= 0.35)
			self.batteryPctView.backgroundColor = [UIColor yellowColor];
		else
			self.batteryPctView.backgroundColor = [UIColor greenColor];
	}
}

void updateWidthConstraintForBatteryLevel(MTPillView *self) {
	if (self.window == nil) 
		return;

	CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
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

%group Universal
%hook MTStaticColorPillView
%property (nonatomic, strong) UIView *batteryPctView;
%property (nonatomic, strong) NSLayoutConstraint *batteryWidthConstraint;

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

-(void) didMoveToWindow {
	%orig;
	commonDidMoveToWindow(self);
	[self updateWidthConstraintForBatteryLevel];
}

-(void)dealloc {
	commonDealloc(self);
	%orig;
}

%new
-(void) updateWidthConstraintForBatteryLevel {
	updateWidthConstraintForBatteryLevel(self);
}
%new
-(void) updateColorState {
	updateColorState(self);
}

%end

%hook SpringBoard
-(void)_batterySaverModeChanged:(int)arg1 {
	%orig;
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateLPMState" object:self];
}
%end
%end


%group Tweak12
%hook MTLumaDodgePillView
%property (nonatomic, strong) UIView *batteryPctView;
%property (nonatomic, strong) NSLayoutConstraint *batteryWidthConstraint;

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
-(void) didMoveToWindow {
	%orig;
	commonDidMoveToWindow(self);
	[self updateWidthConstraintForBatteryLevel];
}

%new
-(void) updateWidthConstraintForBatteryLevel {
	updateWidthConstraintForBatteryLevel(self);
}
%new
-(void)updateColorState {
	updateColorState(self);
}

%end
%end

%group Tweak13
%hook MTLumaDodgePillView
%property (nonatomic, strong) UIView *batteryPctView;
%property (nonatomic, strong) UIView *backgroundView;
%property (nonatomic, strong) NSLayoutConstraint *batteryWidthConstraint;

-(id)initWithFrame:(CGRect)arg1 settings:(id)arg2 graphicsQuality:(long long)arg3 {
	self = %orig;
	if (self) {
		self.backgroundView = [[UIView alloc] init];
		self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}
-(id)initWithFrame:(CGRect)arg1 settings:(id)arg2 {
	self = %orig;
	if (self) {
		self.backgroundView = [[UIView alloc] init];
		self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
		self.backgroundView.backgroundColor = homeBarBackgroundColor;
		[self addSubview: self.backgroundView];
		commonInit(self);
	}
	return self;
}

-(void) didMoveToWindow {
	%orig;
	commonDidMoveToWindow(self);

	[self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0].active = YES;
	[self.backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.0].active = YES;
	[self.backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0.0].active = YES;
	[self.backgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0.0].active = YES;

	[self updateWidthConstraintForBatteryLevel];
}

-(void)dealloc {
	commonDealloc(self);
	%orig;
}

%new
-(void) updateWidthConstraintForBatteryLevel {
	updateWidthConstraintForBatteryLevel(self);
}
%new
-(void) updateColorState {
	updateColorState(self);
}

%end
%end

%ctor {
	loadPrefs();
	[UIDevice currentDevice].batteryMonitoringEnabled = YES;
	if (enabled) {
			%init(Universal);
		if (@available(iOS 13, *)) {
			%init(Tweak13);
		} else {
			%init(Tweak12);
		}
	}
}
