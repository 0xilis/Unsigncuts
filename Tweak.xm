#import <UIKit/UIKit.h>

%hook WFShortcutExtractor
-(bool)allowsOldFormatFile {
 return YES;
}
%end
%hook WFSharingSettings
+(bool)shortcutFileSharingEnabled {
 return YES;
}
%end