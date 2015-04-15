# chrome-stream-chat
a simple Chrome extension to combine youtube + livecoding + twitch chat

## Instructions

1. install as chrome extension
   - drag ext directory into chrome://extensions window
2. open your youtube + twitch + livecoding.tv channels into their own tabs
3. launch the native mac app (not yet built)
4. all chats from #2 will display in #3


## How it works

This chrome extension installs a small javascript into each youtube/twitch/livecoding page that looks for chat logs. when a chat log is found, it HTTP POSTs each chat line to a localhost URL. The mac app is running a small http server which is listening for these post calls.

As the mac app hears each POST of a chat line, it appends it to the chat window for display.

In this way, the chat from all three tabs is merged into a single chat window to read. This window can be used in OBS to display chat from all sites overlayed together into the stream.