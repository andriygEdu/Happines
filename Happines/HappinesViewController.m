//
//  HappinesViewController.m
//  Happines
//
//  Created by Andriy Gushuley on 26.08.12.
//  Copyright (c) 2012 Andriy Gushuley. All rights reserved.
//

#import "HappinesViewController.h"
#import "HappinesFaceView.h"

@interface HappinesViewController () <HappinessForView>

- (IBAction) pitch: (UIPinchGestureRecognizer*) sender;
- (IBAction) pan: (UIPanGestureRecognizer*) sender;

@property IBOutlet HappinesFaceView* hapinnesView;

@end

@implementation HappinesViewController

@synthesize hapinnesView = _hapinnesView;
@synthesize happiness = _happiness;

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) pitch: (UIPinchGestureRecognizer*) recognizer
{
    if ( recognizer.state == UIGestureRecognizerStateChanged
            || recognizer.state == UIGestureRecognizerStateEnded )
    {
        [_hapinnesView resizeFace: recognizer.scale];
        recognizer.scale = 1;
    }
}

- (IBAction) pan: (UIPanGestureRecognizer*) recognizer
{
    if ( recognizer.state == UIGestureRecognizerStateChanged
        || recognizer.state == UIGestureRecognizerStateEnded )
    {
        CGPoint translation = [recognizer translationInView: _hapinnesView];
        _happiness += - translation.y / 100;
        [recognizer setTranslation: CGPointZero inView: _hapinnesView];
        [_hapinnesView setNeedsDisplay];
    }
}

@end
