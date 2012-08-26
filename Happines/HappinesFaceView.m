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

@end

const CGFloat DEFAULT_FACE_SCALE = 0.9; // 90%
const CGFloat EYES_Y_DISP = 0.35;
const CGFloat EYES_X_DISP = 0.35;
const CGFloat EYES_RADIUS = 0.10;
const CGFloat MOUTH_Y_DISP = 0.35;
const CGFloat MOUTH_HALF_WITH = 0.40;
const CGFloat MOUNT_MAX_DOWN = 0.15;

@implementation HappinesFaceView

@synthesize scale = _scale;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawCircleWithContext: (CGContextRef) ctx
                             X: (CGFloat) x Y: (CGFloat) y radius: (CGFloat) radius
                         color: (UIColor*) color fill: (UIColor*) fill
{
    CGContextSaveGState( ctx );
    
    [color setStroke];

    CGContextAddArc( ctx, x, y, radius, 0, 2 * M_PI, 1 );
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
        radius = self.bounds.size.height / 2 * DEFAULT_FACE_SCALE;
    } else {
        radius = self.bounds.size.width / 2 * DEFAULT_FACE_SCALE;
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
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: 
        CGPointMake( self.bounds.size.width / 2 - radius * MOUTH_HALF_WITH,
                    self.bounds.size.height / 2 + radius * MOUTH_Y_DISP )];
    [path addQuadCurveToPoint: CGPointMake( self.bounds.size.width / 2,
                    self.bounds.size.height / 2 + radius * ( MOUTH_Y_DISP + MOUNT_MAX_DOWN ) )
                 controlPoint: CGPointMake(
                    self.bounds.size.width / 2 - radius * MOUTH_HALF_WITH / 2,
                    self.bounds.size.height / 2 + radius * ( MOUTH_Y_DISP + MOUNT_MAX_DOWN ) )];
    [path moveToPoint:
     CGPointMake( self.bounds.size.width / 2 + radius * MOUTH_HALF_WITH,
                 self.bounds.size.height / 2 + radius * MOUTH_Y_DISP )];
    [path addQuadCurveToPoint: CGPointMake( self.bounds.size.width / 2,
                    self.bounds.size.height / 2 + radius * ( MOUTH_Y_DISP + MOUNT_MAX_DOWN ) )
                 controlPoint: CGPointMake(
                    self.bounds.size.width / 2 + radius * MOUTH_HALF_WITH / 2,
                    self.bounds.size.height / 2 + radius * ( MOUTH_Y_DISP + MOUNT_MAX_DOWN ) )];
    [self drawBezierPath: ctx path: path
                   color: [UIColor blueColor]];
}

@end
