//
//  ChatLine.h
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatLine : NSObject

@property (readonly) NSString* host;
@property (readonly) NSString* sender;
@property (readonly) NSString* message;


-(id) initWithHost:(NSString*)host andSender:(NSString*)sender andMessage:(NSString*)message;

@end
