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

#define kLeftPadding 10

@implementation ChatLineView{
    NSTextField* host;
    NSTextField* sender;
    NSTextField* message;
}

static NSMutableDictionary* colors;

+(NSColor*) randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(NSColor*) colorForSender:(NSString*)name{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [NSMutableDictionary dictionary];
    });
    if(![colors objectForKey:name]){
        [colors setObject:[ChatLineView randomColor] forKey:name];
    }
    return [colors objectForKey:name];
}

-(id) initWithChatLine:(ChatLine*)line forWidth:(CGFloat)width{
    host = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, 100)];
    sender = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, 100)];
    message = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, 100)];
    [sender setFont:[NSFont boldSystemFontOfSize:15]];
    [host setFont:[NSFont systemFontOfSize:15]];
    [message setFont:[NSFont boldSystemFontOfSize:20]];

    host.stringValue = line.host;
    sender.stringValue = line.sender;
    sender.textColor = [self colorForSender:line.sender];
    message.stringValue = line.message;
    message.lineBreakMode = NSLineBreakByWordWrapping;

    [host sizeToFit];
    NSSize s = [message sizeThatFits:NSMakeSize(width, 1000)];
    NSRect fr = message.frame;
    fr.size.height = s.height;
    message.frame = fr;

    message.autoresizingMask = NSViewWidthSizable;
    sender.autoresizingMask = NSViewWidthSizable | NSViewMaxXMargin;
    host.autoresizingMask = NSViewWidthSizable | NSViewMinXMargin;

    if(self = [super initWithFrame:NSMakeRect(0, 0, width, host.bounds.size.height + 10 + message.bounds.size.height)]){
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

        self.wantsLayer = YES;
        self.layer.backgroundColor = [[NSColor whiteColor] colorWithAlphaComponent:.8].CGColor;
        
        sender.frame = NSMakeRect(kLeftPadding, 5, sender.bounds.size.width, sender.bounds.size.height);
        host.frame = NSMakeRect(width - host.bounds.size.width, 5, host.bounds.size.width, host.bounds.size.height);
        message.frame = NSMakeRect(kLeftPadding, self.bounds.size.height - message.bounds.size.height - 5, width - kLeftPadding, message.bounds.size.height);
    }
    return self;
}


@end
