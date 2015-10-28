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

#import "FollowPleaSettings.h"
#import "FollowPlea.h"

%group FOLLOW_PLEA

%hook SBLockScreenManager
- (void)_finishUIUnlockFromSource:(int)source withOptions:(id)options {
	%orig;

	[UIAlertView showWithTitle:FP_PLEA_MSG_TITLE
	                   message:FP_PLEA_MSG_BODY
	         cancelButtonTitle:FP_CANCEL_LABEL
	         otherButtonTitles:@[ FP_OKAY_LABEL ]
	                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
	                    if (buttonIndex != [alertView cancelButtonIndex]) {
							ACAccountStore *accountStore = [[ACAccountStore alloc] init];
							ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

							[accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
							    if(granted) {
							    	NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
							    	NSMutableArray *accs = [NSMutableArray array];

									for(ACAccount *acc in accountsArray) {
										[accs addObject:[NSString stringWithFormat:@"@%@", acc.username]];
									}

									if ([accountsArray count] > 1) {
										dispatch_async(dispatch_get_main_queue(), ^{
											[UIAlertView showWithTitle:FP_WHICH_ACCOUNT_TITLE
											                   message:FP_WHICH_ACCOUNT_BODY
											         cancelButtonTitle:FP_ALL_ACCOUNTS_LABEL
											         otherButtonTitles:[accs copy]
											                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
											                    if (buttonIndex == [alertView cancelButtonIndex]) {
										                    		for (ACAccount *twitterAccount in accountsArray) {
																		fpFollowTwitterAccount(twitterAccount);
										                    		}
											                    } else {
											                        ACAccount *twitterAccount = [accountsArray objectAtIndex:buttonIndex-1];
																	fpFollowTwitterAccount(twitterAccount);
											                    }
											                  }];
										});
									} else if([accountsArray count] == 1) {
										ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
										fpFollowTwitterAccount(twitterAccount);
									}
							    }
							}];
	                    }
	                  }];


	// Register that this function has been run at least once!
	FP_FIRST_RUN_REGISTRAR();
}
%end

%end


%ctor {
	@autoreleasepool {
		if (FP_FIRST_RUN) {
			HBLogDebug(@"Initialized");
			%init(FOLLOW_PLEA);
		}
		HBLogDebug(@"Should Have Initialized");
	}
}