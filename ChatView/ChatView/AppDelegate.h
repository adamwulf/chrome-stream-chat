//
//  AppDelegate.h
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ChatLine.h"

@class HTTPServer;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    HTTPServer *httpServer;
}

-(void) chatViewerCountUpdated:(NSInteger)lcCount;

-(void) chatLineAdded:(ChatLine*)chat;


@end

