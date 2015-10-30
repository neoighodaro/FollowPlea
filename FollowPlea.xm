//
//  FollowPlea.m
//  FollowPlea
//
//  Created by TapSharp on 28/19/2015.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 TapSharp
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "../FollowPleaSettings.h"
#import "FollowPlea.h"

%group FOLLOW_PLEA

%hook SBLockScreenManager
- (void)_finishUIUnlockFromSource:(int)source withOptions:(id)options {
	%orig;

	// Has run fam
	if ([[NSFileManager defaultManager] fileExistsAtPath:FP_FILE]) return;

	// Register that this function has been run at least once!
	[[NSFileManager defaultManager] createFileAtPath:FP_FILE contents:nil attributes:nil];

	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:FP_PLEA_MSG_TITLE
                                                  message:FP_PLEA_MSG_BODY
                                                 delegate:self
                                        cancelButtonTitle:FP_CANCEL_LABEL
                                        otherButtonTitles:FP_OKAY_LABEL, nil];
	[alertView show];
	[alertView release];
}

%new
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	%log;
    if (buttonIndex != [alertView cancelButtonIndex]) {
		ACAccountStore *accountStore = [[ACAccountStore alloc] init];
		ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

		[accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
		    if(granted) {
		    	NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];

		    	// @TODO find a better way to show accounts list
				for(ACAccount *acc in accountsArray) {
					fpFollowTwitterAccount(acc);
					// break;
					// Follow with just the first account??
				}
		    }
		}];
    }
}
%end

%end


%ctor {
	@autoreleasepool {
		%init(FOLLOW_PLEA);
	}
}