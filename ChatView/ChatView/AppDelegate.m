//
//  AppDelegate.m
//  ChatView
//
//  Created by Adam Wulf on 4/15/15.
//  Copyright (c) 2015 Milestone Made. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"
#import "ChatLineView.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate{
    NSMutableArray* chatLines;
    IBOutlet NSScrollView* scrollView;
    NSView* documentView;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    // Configure our logging framework.
    // To keep things simple and fast, we're just going to log to the Xcode console.
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    chatLines = [NSMutableArray array];
    
    // Initalize our http server
    httpServer = [[HTTPServer alloc] init];
    
    // Tell the server to broadcast its presence via Bonjour.
    // This allows browsers such as Safari to automatically discover our service.
    [httpServer setType:@"_http._tcp."];
    
    // Normally there's no need to run our server on any specific port.
    // Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
    // However, for easy testing you may want force a certain port so you can just hit the refresh button.
    [httpServer setPort:54545];
    
    // Serve files from the standard Sites folder
    NSString *docRoot = [[self applicationDirectory] path];
    DDLogInfo(@"Setting document root: %@", docRoot);
    
    [httpServer setDocumentRoot:docRoot];
    
    // We're going to extend the base HTTPConnection class with our MyHTTPConnection class.
    // This allows us to do all kinds of customizations.
    [httpServer setConnectionClass:[MyHTTPConnection class]];

    NSError *error = nil;
    if(![httpServer start:&error])
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
    
    documentView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, scrollView.bounds.size.width, 1)];
    scrollView.documentView = documentView;

    
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
    [self chatLineAdded:[[ChatLine alloc] initWithHost:@"testhost.com" andSender:@"adam" andMessage:@"hasdfl;asdjflasfdj"]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


-(void) chatLineAdded:(ChatLine*)chat{
    dispatch_async(dispatch_get_main_queue(), ^{
        [chatLines addObject:chat];
        
        ChatLineView* v = [[ChatLineView alloc] initWithChatLine:chat forWidth:scrollView.bounds.size.width];
        
        NSRect fr = [[documentView.subviews lastObject] frame];
        v.frame = NSMakeRect(0, fr.origin.y + fr.size.height, v.bounds.size.width, v.bounds.size.height);
        
        
        fr = [scrollView.documentView frame];
        fr.size.height += v.bounds.size.height;
        [scrollView.documentView setFrame:fr];
        
        [documentView addSubview:v];
        
        scrollView.hasHorizontalScroller = NO;
        scrollView.hasVerticalScroller = YES;
    });
}




- (NSURL*)applicationDirectory
{
    NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSFileManager*fm = [NSFileManager defaultManager];
    NSURL*    dirPath = nil;
    
    // Find the application support directory in the home directory.
    NSArray* appSupportDir = [fm URLsForDirectory:NSApplicationSupportDirectory
                                        inDomains:NSUserDomainMask];
    if ([appSupportDir count] > 0)
    {
        // Append the bundle ID to the URL for the
        // Application Support directory
        dirPath = [[appSupportDir objectAtIndex:0] URLByAppendingPathComponent:bundleID];
        
        // If the directory does not exist, this method creates it.
        // This method is only available in OS X v10.7 and iOS 5.0 or later.
        NSError*    theError = nil;
        if (![fm createDirectoryAtURL:dirPath withIntermediateDirectories:YES
                           attributes:nil error:&theError])
        {
            // Handle the error.
            
            return nil;
        }
    }
    
    return dirPath;
}


@end
