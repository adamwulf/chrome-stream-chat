//
//  ColorView.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

- (void)drawRect:(NSRect)dirtyRect {
    // Fill in background Color
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 0.251,0.251,0.251,0.8);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}


@end
