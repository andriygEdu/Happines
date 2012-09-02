//
//  HappinesFaceView.m
//  Happines
//
//  Created by Andriy Gushuley on 26.08.12.
//  Copyright (c) 2012 Andriy Gushuley. All rights reserved.
//

#import "HappinesFaceView.h"

@interface HappinesFaceView()

@property CGFloat scale;
@property IBOutlet id<HappinessForView> happinessProvider;

@end

const CGFloat DEFAULT_FACE_SCALE = 0.9; // 90%
const CGFloat EYES_Y_DISP = 0.35;
const CGFloat EYES_X_DISP = 0.35;
const CGFloat EYES_RADIUS = 0.10;
const CGFloat MOUTH_Y_DISP = 0.35;
const CGFloat MOUTH_HALF_WITH = 0.40;
const CGFloat MOUNT_MAX_DOWN = 0.20;

@implementation HappinesFaceView

@synthesize scale = _scale;

- (void) awakeFromNib
{
    [super awakeFromNib];

    _scale = DEFAULT_FACE_SCALE;
}

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scale = DEFAULT_FACE_SCALE;
    }
    return self;
}

- (void) drawCircleWithContext: (CGContextRef) ctx
                             X: (CGFloat) x Y: (CGFloat) y radius: (CGFloat) radius
                         color: (UIColor*) color fill: (UIColor*) fill
{
    CGContextSaveGState( ctx );
    
    [color setStroke];

    CGContextAddEllipseInRect( ctx, CGRectMake( x - radius, y - radius, radius * 2, radius * 2 ) );
    CGContextStrokePath( ctx );

    if ( fill ) {
        CGContextSetFillColorWithColor( ctx, fill.CGColor );
        CGContextFillPath( ctx );
    }
    
    CGContextRestoreGState( ctx );
}

- (void) drawBezierPath: (CGContextRef) ctx
                   path: (UIBezierPath*) path
                  color: (UIColor*) color
{
    CGContextSaveGState( ctx );
    
    [color setStroke];

    CGContextAddPath( ctx, path.CGPath );
    CGContextStrokePath( ctx );
    
    CGContextRestoreGState( ctx );

}

// Standart draw selector
- (void) drawRect: (CGRect) rect
{
    [super drawRect: rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat radius;
    if ( self.bounds.size.height < self.bounds.size.width ) {
        radius = self.bounds.size.height / 2 * _scale;
    } else {
        radius = self.bounds.size.width / 2 * _scale;
    }
    
    [self drawCircleWithContext: ctx X: self.bounds.size.width / 2
                              Y: self.bounds.size.height / 2 radius: radius
                          color: [UIColor blueColor] fill: [UIColor yellowColor]];
    // Eyes
    [self drawCircleWithContext: ctx
                              X: self.bounds.size.width / 2 - radius * EYES_X_DISP
                              Y: self.bounds.size.height / 2 - radius * EYES_Y_DISP
                         radius: radius * EYES_RADIUS
                          color: [UIColor blueColor] fill: [UIColor lightGrayColor]];
    [self drawCircleWithContext: ctx
                              X: self.bounds.size.width / 2 + radius * EYES_X_DISP
                              Y: self.bounds.size.height / 2 - radius * EYES_Y_DISP
                         radius: radius * EYES_RADIUS
                          color: [UIColor blueColor] fill: [UIColor lightGrayColor]];
    // Mouth
    CGFloat happiness = _happinessProvider.happiness;
    if ( happiness > 1 ) {
        happiness = 1;
    } else  if ( happiness < -1 ) {
        happiness = -1;
    }

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat middleY = self.bounds.size.height / 2 + radius * ( MOUTH_Y_DISP + MOUNT_MAX_DOWN * happiness);
    [path moveToPoint: 
        CGPointMake( self.bounds.size.width / 2 - radius * MOUTH_HALF_WITH,
                    self.bounds.size.height / 2 + radius * MOUTH_Y_DISP )];
    [path addQuadCurveToPoint: CGPointMake( self.bounds.size.width / 2, middleY )
                 controlPoint: CGPointMake(
                    self.bounds.size.width / 2 - radius * MOUTH_HALF_WITH / 2,
                    middleY )];
    [path moveToPoint:
     CGPointMake( self.bounds.size.width / 2 + radius * MOUTH_HALF_WITH,
                 self.bounds.size.height / 2 + radius * MOUTH_Y_DISP )];
    [path addQuadCurveToPoint: CGPointMake( self.bounds.size.width / 2, middleY )
                 controlPoint: CGPointMake(
                    self.bounds.size.width / 2 + radius * MOUTH_HALF_WITH / 2, middleY )];
    [self drawBezierPath: ctx path: path
                   color: [UIColor blueColor]];
}

- (void) resizeFace: (CGFloat) factor {
    _scale = _scale * factor;
    
    [self setNeedsDisplay];
}

@end
