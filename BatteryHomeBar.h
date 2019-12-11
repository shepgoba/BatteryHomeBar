@interface MTPillView : UIView
@property (nonatomic, strong) UIView *batteryPctView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) NSLayoutConstraint *batteryWidthConstraint;
-(void)updateWidthConstraintForBatteryLevel;
-(void)updateColorState;
@end

@interface MTLumaDodgePillView : MTPillView
@end
@interface MTStaticColorPillView : MTPillView
@end

@interface NSLayoutConstraint (poop)
+(id)constraintWithAnchor:(id)arg1 relatedBy:(long long)arg2 toAnchor:(id)arg3 multiplier:(double)arg4 constant:(double)arg5 ;
@end
