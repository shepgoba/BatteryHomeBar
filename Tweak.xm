@interface MTLumaDodgePillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState;
@end

@interface MTStaticColorPillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState;
@end

#define HOMEBAR_BACKGROUND_COLOR [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.f/255.0f alpha:1]
%hook MTLumaDodgePillView

%property (nonatomic, retain) UIView *batteryPctView;
- (void) setStyle:(long long)arg1
{
	%orig(0);
}

- (id) initWithFrame:(CGRect)arg1
{
	MTLumaDodgePillView *orig = %orig;
	orig.backgroundColor = HOMEBAR_BACKGROUND_COLOR;

	orig.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, arg1.size.width, arg1.size.height)];
	[orig updateBatteryBarState];

	[orig addSubview: orig.batteryPctView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryBarState) name:@"UIDeviceBatteryLevelDidChangeNotification" object:nil];

	return orig;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	%orig;
}

%new 
- (void) updateBatteryBarState
{
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
%end


%hook MTStaticColorPillView

%property (nonatomic, retain) UIView *batteryPctView;

- (void) setPillColor:(UIColor *)a
{
	%orig(HOMEBAR_BACKGROUND_COLOR);
}

- (id) initWithFrame:(CGRect)arg1
{
	
	MTStaticColorPillView *orig = %orig;
	orig.batteryPctView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, arg1.size.width, arg1.size.height)];
	[orig updateBatteryBarState];

	[orig addSubview: orig.batteryPctView];

	[[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(updateBatteryBarState) 
        name:@"UIDeviceBatteryLevelDidChangeNotification"
        object:nil];

	return orig;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	%orig;
}

%new 
- (void) updateBatteryBarState
{
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
%end