@interface MTLumaDodgePillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState:(NSNotification *)notification;
@end

@interface MTStaticColorPillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState:(NSNotification *)notification;
@end

//#define HOMEBAR_BACKGROUND_COLOR [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.f/255.0f alpha:1]
@interface SBDashBoardHomeAffordanceView : UIView
-(MTLumaDodgePillView *)dynamicHomeAffordance;
-(MTStaticColorPillView *)staticHomeAffordance;
@end

@interface SBDashBoardHomeAffordanceViewController : UIViewController
-(SBDashBoardHomeAffordanceView *)homeAffordanceView;
@end
