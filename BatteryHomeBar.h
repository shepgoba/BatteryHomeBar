@interface MTPillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UILabel *percentLabel;
- (void) updateBatteryBarState;
@end

@interface MTLumaDodgePillView : MTPillView
@end
@interface MTStaticColorPillView : MTPillView
@end