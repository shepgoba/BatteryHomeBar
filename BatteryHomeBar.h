@interface MTLumaDodgePillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState:(NSNotification *)notification;
@end

@interface MTStaticColorPillView : UIView
@property (nonatomic, retain) UIView *batteryPctView;
- (void) updateBatteryBarState:(NSNotification *)notification;
@end

/* 
Possible rewrite eventually

@interface SBDashBoardHomeAffordanceView : UIView
-(MTLumaDodgePillView *)dynamicHomeAffordance;
-(MTStaticColorPillView *)staticHomeAffordance;
@end

@interface SBDashBoardHomeAffordanceViewController : UIViewController
-(SBDashBoardHomeAffordanceView *)homeAffordanceView;
@end
*/