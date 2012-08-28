//
//  HappinesViewController.m
//  Happines
//
//  Created by Andriy Gushuley on 26.08.12.
//  Copyright (c) 2012 Andriy Gushuley. All rights reserved.
//

#import "HappinesViewController.h"
#import "HappinesFaceView.h"

@interface HappinesViewController ()

- (IBAction) pitch: (id) sender;

@property IBOutlet UIPinchGestureRecognizer* pitchRecognizer;
@property IBOutlet HappinesFaceView* hapinnesView;

@end

@implementation HappinesViewController

@synthesize pitchRecognizer = _pitchRecognizer;
@synthesize hapinnesView = _hapinnesView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) pitch: (id) sender
{
    NSLog( @"Pith received %g", _pitchRecognizer.scale );
    [_hapinnesView resizeFace: _pitchRecognizer.scale];
    _pitchRecognizer.scale = 1;
}

@end
