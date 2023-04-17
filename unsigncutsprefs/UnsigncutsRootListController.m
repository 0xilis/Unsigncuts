#import <Foundation/Foundation.h>
#import "UnsigncutsRootListController.h"
#include <unistd.h>

@implementation UnsigncutsRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)openGitHub {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://github.com/0xilis"]
	options:@{}
	completionHandler:nil];
}

-(void)openTwitter {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://twitter.com/QuickUpdate5"]
	options:@{}
	completionHandler:nil];
}

-(void)openReddit {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://reddit.com/user/0xilis"]
	options:@{}
	completionHandler:nil];
}

-(void)buyBadger {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://havoc.app/package/badger"]
	options:@{}
	completionHandler:nil];
}
@end
