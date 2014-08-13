//
//  BusyIndicatorView.m
//  HibuSearch
//
//  Created by Tom York on 02/07/2013.
//  Copyright (c) 2013 HIBU. All rights reserved.
//

#import "HSBusyIndicatorView.h"
#import "HSFadingGradientArcLayer.h"
#import "UIColor+Hotel.h"

static const CGFloat DefaultArcSpan = 0.5f;
static const CGFloat DefaultLineWidth = 2.0f;
static const CGFloat DefaultFadeDistance = 40.0f;
static const CGFloat DefaultRotationDuration = 0.25f;
static NSString* const BusyAnimationKey = @"BusyAnimation";

@interface HSBusyIndicatorView ()
@property (nonatomic,strong) CAShapeLayer* backgroundLayer;
@property (nonatomic,strong) HSFadingGradientArcLayer* graphicLayer;

@property (nonatomic,strong) CABasicAnimation* unavailableAnimation;
@end

@implementation HSBusyIndicatorView

+ (instancetype)transparentBackgroundBusyIndicatorWithSize:(CGSize)size
{
    HSBusyIndicatorView* busyIndicator = [[HSBusyIndicatorView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [busyIndicator applyTransparentBusyIndicatorStyle];
    return busyIndicator;
}

+ (instancetype)solidBackgroundBusyIndicatorWithSize:(CGSize)size
{
    HSBusyIndicatorView* busyIndicator = [[HSBusyIndicatorView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [busyIndicator applySolidBusyIndicatorStyle];
    return busyIndicator;
}

- (void)applyTransparentBusyIndicatorStyle
{
    [self applyInnerBackground:[UIColor clearColor] outerBackground:[UIColor clearColor]];
}

- (void)applySolidBusyIndicatorStyle
{
    [self applyInnerBackground:[UIColor colorWithWhite:1.0f alpha:0.69f] outerBackground:[UIColor whiteColor]];
}

- (void)applyInnerBackground:(UIColor*)innerBackground outerBackground:(UIColor*)outerBackground
{
    self.opaque = NO;
    const CGFloat scaleFactor = sqrtf(MIN(self.bounds.size.height, self.bounds.size.width) / 40.0f);
    self.fadeDistance = 8.0f * scaleFactor;
    self.lineWidth = 4.0f * scaleFactor;
    self.innerBackgroundColor = innerBackground;
    self.outerBackgroundColor = outerBackground;
}


#pragma mark - Lifecycle -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    //Defaults
    _lineWidth = DefaultLineWidth;
    _innerBackgroundColor = [UIColor colorWithWhite:1.0f alpha:0.69f];
    _outerBackgroundColor = [UIColor whiteColor];
    _rotationDuration = DefaultRotationDuration;

    // Circular background
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.lineWidth = _lineWidth;
    _backgroundLayer.strokeColor = _outerBackgroundColor.CGColor;
    _backgroundLayer.fillColor = _innerBackgroundColor.CGColor;
    [self.layer addSublayer:_backgroundLayer];
    
    // Gradient to indicate the level
    _graphicLayer = [HSFadingGradientArcLayer layer];
    _graphicLayer.span = DefaultArcSpan;
    _graphicLayer.lineWidth = _lineWidth;
    _graphicLayer.arcColor = [UIColor colorWithHex:0x74cfe6];
    _graphicLayer.fadeDistance = DefaultFadeDistance;
    _graphicLayer.contentsScale = [[UIScreen mainScreen] scale];
    _graphicLayer.geometryFlipped = YES;
    [self.layer addSublayer:_graphicLayer];
    
    // Observes foreground/background notifications to ensure animation pauses/resumes
    NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(resumeAnimations) name:UIApplicationWillEnterForegroundNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(pauseAnimations) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Accessors -

- (void)setInnerBackgroundColor:(UIColor *)innerBackgroundColor
{
    if(innerBackgroundColor != _innerBackgroundColor)
    {
        _innerBackgroundColor = innerBackgroundColor;
        self.backgroundLayer.fillColor = _innerBackgroundColor.CGColor;
    }
}

- (void)setOuterBackgroundColor:(UIColor *)outerBackgroundColor
{
    if(outerBackgroundColor != _outerBackgroundColor)
    {
        _outerBackgroundColor = outerBackgroundColor;
        self.backgroundLayer.strokeColor = _outerBackgroundColor.CGColor;
    }
}

- (void)setBusyColor:(UIColor *)busyColor
{
    self.graphicLayer.arcColor = busyColor;
}

- (UIColor*)busyColor
{
    return self.graphicLayer.arcColor;
}

- (void)setFadeDistance:(CGFloat)fadeDistance
{
    self.graphicLayer.fadeDistance = fadeDistance;
}

- (CGFloat)fadeDistance
{
    return self.graphicLayer.fadeDistance;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if(_lineWidth != lineWidth)
    {
        _lineWidth = lineWidth;
        self.backgroundLayer.lineWidth = _lineWidth;
        self.graphicLayer.lineWidth = _lineWidth;
    }
}

- (void)setSpan:(CGFloat)span
{
    self.graphicLayer.span = span;
}

- (CGFloat)span
{
    return self.graphicLayer.span;
}


#pragma mark - Layout and setup -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const CGSize boundsSize = self.bounds.size;
    const BOOL isWider = (boundsSize.width > boundsSize.height);
    const CGRect layoutRect = isWider ? CGRectMake(floorf((boundsSize.width - boundsSize.height)/2), 0, boundsSize.height, boundsSize.height) : CGRectMake(0, floorf((boundsSize.height - boundsSize.width)/2), boundsSize.width, boundsSize.width);
    const CGFloat insetDistance = ceilf(self.lineWidth/2);
    const CGRect pathContainerRect = CGRectInset(CGRectMake(0,0, layoutRect.size.width, layoutRect.size.height), insetDistance, insetDistance);
    
    self.backgroundLayer.frame = layoutRect;
    self.backgroundLayer.path = [UIBezierPath bezierPathWithOvalInRect:pathContainerRect].CGPath;
    self.graphicLayer.frame = layoutRect;
    [self.graphicLayer setNeedsDisplay];
}

#pragma - animations -

- (void)pauseAnimations
{
    self.unavailableAnimation = [[self.graphicLayer animationForKey:BusyAnimationKey] copy];
    [self.graphicLayer removeAllAnimations];
}

- (void)resumeAnimations
{
    CABasicAnimation* spinAnimation = self.unavailableAnimation;
    if(!spinAnimation)
    {
        spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        spinAnimation.fromValue = @0.0;
        spinAnimation.toValue = @(M_PI_2);
        spinAnimation.duration = self.rotationDuration;
        spinAnimation.cumulative = YES;
        spinAnimation.repeatCount = HUGE_VALF;
    }
    else
    {
        self.unavailableAnimation = nil;
    }
    [self.graphicLayer addAnimation:spinAnimation forKey:BusyAnimationKey];
}

#pragma mark - Visibility change handling -

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    if(newWindow)
    {
        [self resumeAnimations];
    }
    else
    {
        [self pauseAnimations];
    }
}

@end
