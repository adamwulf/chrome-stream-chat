//
//  DraggableView.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "DraggableView.h"

@implementation DraggableView

-(void) awakeFromNib{
    self.wantsLayer = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [NSColor blackColor].CGColor;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


-(BOOL) mouseDownCanMoveWindow{
    return YES;
}

@end
