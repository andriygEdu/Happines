//
//  HappinesFaceView.h
//  Happines
//
//  Created by Andriy Gushuley on 26.08.12.
//  Copyright (c) 2012 Andriy Gushuley. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HappinessForView
    @property (readonly) CGFloat happiness;
@end


@interface HappinesFaceView : UIView

- (void) resizeFace: (CGFloat) factor;

@end
