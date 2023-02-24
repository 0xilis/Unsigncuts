#import <UIKit/UIKit.h>

%hook WFShortcutExtractor
-(bool)allowsOldFormatFile {
 return YES;
}
%end
%hook WFSharingSettings //note: this value is only accepted for importing now on internal builds of voiceshortcuts
+(bool)shortcutFileSharingEnabled {
 return YES;
}
%end
//below is WIP!!
//lock these behind a optional setting to enable incorrectly signed shortcuts to be imported
%hook WFSharedShortcut
-(void)signingStatus {
 return @"APPROVED";
}
%end
%hook WFGalleryWorkflow
-(void)signingStatus {
 return @"APPROVED";
}
%end
%hook WFShortcutSigningContext
-(BOOL)validateAppleIDCertificatesWithError:(NSError**)arg0 {
 return YES;
}
-(BOOL)validateSigningCertificateChainWithICloudIdentifier:(*id)arg0 error:(NSError**)arg1 {
 return YES;
}
-(BOOL)validateWithSigningMethod:(*NSInteger)arg0 error:(NSError**)arg1 {
 return YES;
}
-(BOOL)validateWithSigningMethod:(*NSInteger)arg0 iCloudIdentifier:(*id)arg1 error:(NSError**)arg2 {
 return YES;
}
//lock this behind a optional setting to enable contact signed shortcuts to be imported even if you don't have a matching contact with them
//btw this has the side affect of ignoring when private shortcuts disabled, so in future switch to custom validatedEmailHashes/validatedPhoneHashes
-(SFAppleIDValidationRecord*)appleIDValidationRecord { //lets pass WFShortcutSigningContext validateAppleIDValidationRecordWithCompletion
 SFAppleIDClient* retValidationRecord = %orig;
 SFAppleIDClient* myAppleID = [[SFAppleIDClient alloc]init]; //from the Sharing.framework PrivateFramework
 retValidationRecord.altDSID = [[myAppleID myAccountWithError:nil]altDSID];
 return retValidationRecord;
}
%end
