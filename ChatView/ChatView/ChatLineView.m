//
//  ChatLineView.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "ChatLineView.h"
#import "ChatLine.h"

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
    
    [host sizeToFit];
    [sender sizeToFit];
    [message sizeToFit];

    if(self = [super initWithFrame:NSMakeRect(0, 0, width, host.bounds.size.height + 20 + message.bounds.size.height)]){
        [self addSubview:host];
        [self addSubview:sender];
        [self addSubview:message];
        
        sender.frame = NSMakeRect(0, message.bounds.size.height + 10, sender.bounds.size.width, sender.bounds.size.height);
        host.frame = NSMakeRect(width - host.bounds.size.width, message.bounds.size.height + 10, host.bounds.size.width, host.bounds.size.height);
    }
    return self;
}


@end
