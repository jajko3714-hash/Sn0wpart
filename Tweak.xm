#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface Sn0wpartEmitterView : UIView
@property (nonatomic, strong) CAEmitterLayer *emitter;
@end

@implementation Sn0wpartEmitterView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.emitter = [CAEmitterLayer layer];
        self.emitter.emitterPosition = CGPointMake(frame.size.width / 2, -10);
        self.emitter.emitterShape = kCAEmitterLayerLine;
        self.emitter.emitterSize = CGSizeMake(frame.size.width, 1);
        
        CAEmitterCell *flake = [CAEmitterCell emitterCell];
        flake.birthRate = 22.0;
        flake.lifetime = 8.0;
        flake.velocity = 55.0;
        flake.velocityRange = 25.0;
        flake.emissionLongitude = M_PI;
        flake.spin = 0.8;
        flake.spinRange = 1.2;
        flake.scale = 0.15;
        flake.scaleRange = 0.08;
        
        CGFloat diameter = 24.0;
        CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
        CGContextRef ctx = CGBitmapContextCreate(NULL, diameter, diameter, 8, 4 * diameter, cs, kCGImageAlphaPremultipliedLast);
        if (ctx) {
            CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 0.65);
            CGContextFillEllipseInRect(ctx, CGRectMake(2, 2, diameter - 4, diameter - 4));
            CGImageRef imgRef = CGBitmapContextCreateImage(ctx);
            flake.contents = (__bridge id)imgRef;
            CGImageRelease(imgRef);
            CGContextRelease(ctx);
        }
        CGColorSpaceRelease(cs);
        
        self.emitter.emitterCells = @[flake];
        [self.layer addSublayer:self.emitter];
    }
    return self;
}
@end

// Hook into SpringBoard controller
@interface SBIconController : UIViewController
@end

%hook SBIconController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    UIView *mainView = [self view];
    if (mainView && ![mainView viewWithTag:9944]) {
        Sn0wpartEmitterView *snow = [[Sn0wpartEmitterView alloc] initWithFrame:mainView.bounds];
        snow.tag = 9944;
        [mainView addSubview:snow];
    }
}
%end
