//
//  ChatLineView.h
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ChatLine.h"

@interface ChatLineView : NSView

-(id) initWithChatLine:(ChatLine*)line forWidth:(CGFloat)width;

@end
