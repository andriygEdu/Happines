//
//  HappinesFaceSelectorViewController.m
//  Happines
//
//  Created by Andriy Gushuley on 02.09.12.
//  Copyright (c) 2012 Andriy Gushuley. All rights reserved.
//

#import "HappinesFaceSelectorViewController.h"
#import "HappinesViewController.h"

@interface HappinesFaceSelectorViewController ()

@end

@implementation HappinesFaceSelectorViewController

- (void) prepareForSegue: (UIStoryboardSegue*) segue sender: (id) sender
{
    HappinesViewController* faceController = [segue destinationViewController];
    if ( [[segue identifier] isEqualToString: @"Sad"] ) {
        faceController.happiness = -0.75;
    } else if ( [[segue identifier] isEqualToString: @"Happy"] ) {
        faceController.happiness = +0.75;
    }
    faceController.title = [segue identifier];
}

@end
