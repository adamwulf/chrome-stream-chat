//
//  ChatLine.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "ChatLine.h"

@implementation ChatLine

@synthesize host;
@synthesize sender;
@synthesize message;

-(id) initWithHost:(NSString*)_host andSender:(NSString*)_sender andMessage:(NSString*)_message{
    if(self = [super init]){
        host = _host;
        sender = _sender;
        message = _message;
    }
    return self;
}

-(NSString*) description{
    return [NSString stringWithFormat:@"[ChatLine %@ %@ %@]", host, sender, message];
}

@end
