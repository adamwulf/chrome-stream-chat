//
//  ChatLineView.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "ChatLineView.h"
#import "ChatLine.h"
#import "ColorView.h"

@implementation ChatLineView{
    NSTextField* host;
    NSTextField* sender;
    NSTextField* message;
}

-(id) initWithChatLine:(ChatLine*)line forWidth:(CGFloat)width{
    host = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, 100)];
    sender = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, 100)];
    message = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, 100)];
    host.stringValue = line.host;
    sender.stringValue = line.sender;
    message.stringValue = line.message;
    message.lineBreakMode = NSLineBreakByWordWrapping;

    [host sizeToFit];
    NSSize s = [message sizeThatFits:NSMakeSize(width, 1000)];
    NSRect fr = message.frame;
    fr.size.height = s.height;
    message.frame = fr;
    
    if(self = [super initWithFrame:NSMakeRect(0, 0, width, host.bounds.size.height + 10 + message.bounds.size.height)]){
        ColorView* border = [[ColorView alloc] initWithFrame:NSMakeRect(0, 0, width, 1)];
        [self addSubview:border];
        
        [sender setFont:[NSFont boldSystemFontOfSize:sender.font.pointSize]];
        
        [host setEditable:NO];
        [sender setEditable:NO];
        [message setEditable:NO];
        [host setBordered:NO];
        [sender setBordered:NO];
        [message setBordered:NO];
        
        sender.backgroundColor = [NSColor clearColor];
        host.backgroundColor = [NSColor clearColor];
        message.backgroundColor = [NSColor clearColor];
        
        [self addSubview:host];
        [self addSubview:sender];
        [self addSubview:message];
        
        sender.frame = NSMakeRect(0, 5, sender.bounds.size.width, sender.bounds.size.height);
        host.frame = NSMakeRect(width - host.bounds.size.width, 5, host.bounds.size.width, host.bounds.size.height);
        message.frame = NSMakeRect(0, self.bounds.size.height - message.bounds.size.height - 5, message.bounds.size.width, message.bounds.size.height);
    }
    return self;
}


@end
