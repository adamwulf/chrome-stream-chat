//
//  DraggableWindow.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "DraggableWindow.h"

@implementation DraggableWindow

-(void) awakeFromNib{
    [self setHasShadow:NO];
}

-(BOOL) isMovableByWindowBackground{
    return YES;
}

@end
