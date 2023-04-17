#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

HBPreferences *preferences;

@interface WFSharingSettings : NSObject
+(BOOL)isPrivateSharingEnabled;
+(BOOL)sharingEnabled;
+(BOOL)shortcutFileSharingEnabled;
+(id)privateSharingDisabledAlertWithShortcutName:(id)arg0 ;
+(id)privateSharingDisabledErrorWithShortcutName:(id)arg0 ;
+(id)sharingDisabledAlertWithShortcutName:(id)arg0 ;
+(id)sharingDisabledAlertWithWorkflowName:(id)arg0 ;
+(id)shortcutFileSharingDisabledAlert;
+(id)shortcutFileSharingDisabledError;
@end

@interface SFAppleIDClient : NSObject
- (id)myAccountWithError:(id )arg1;
@end

@interface SFAppleIDValidationRecord : NSObject
@property(retain, nonatomic) NSArray *validatedPhoneHashes; // @synthesize validatedPhoneHashes=_validatedPhoneHashes;
@property(retain, nonatomic) NSArray *validatedEmailHashes; // @synthesize validatedEmailHashes=_validatedEmailHashes;
@property(retain, nonatomic) NSString *altDSID; // @synthesize altDSID=_altDSID;
@end

@interface SFAppleIDAccount : NSObject
@property(retain, nonatomic) SFAppleIDValidationRecord *validationRecord; // @synthesize validationRecord=_validationRecord;
@property(retain, nonatomic) NSString *altDSID; // @synthesize altDSID=_altDSID;
@end

@interface WFShortcutSigningContext : NSObject
@property (readonly, copy, nonatomic) NSArray *appleIDCertificateChain; // ivar: _appleIDCertificateChain
@property (readonly, nonatomic) SFAppleIDValidationRecord *appleIDValidationRecord; // ivar: _appleIDValidationRecord
@property (readonly, nonatomic) NSDate *expirationDate; // ivar: _expirationDate
@property (readonly, copy, nonatomic) NSArray *signingCertificateChain; // ivar: _signingCertificateChain
@property (retain, nonatomic) NSData *signingPublicKeySignature; // ivar: _signingPublicKeySignature
@end

%hook WFShortcutExtractor
-(bool)allowsOldFormatFile { //the main thing that allows this
 return YES;
}
%end
%hook WFSharingSettings //note: this value is only accepted for importing now on internal builds of voiceshortcuts (at least when talking about importing)
//however for exporting, it still adds the export shortcut as file option to sharing options so this does still have a use
+(bool)shortcutFileSharingEnabled {
 return YES;
}
%end

%group unsigncutsInvalidSignature
%hook WFSharedShortcut
-(NSString *)signingStatus {
 return @"APPROVED";
}
%end
%hook WFGalleryWorkflow
-(NSString *)signingStatus {
 return @"APPROVED";
}
%end
%end

%hook WFShortcutSigningContext
%group unsigncutsInvalidSignature
-(BOOL)validateAppleIDCertificatesWithError:(NSError**)arg0 {
 return YES;
}
-(BOOL)validateSigningCertificateChainWithICloudIdentifier:(*id)arg0 error:(NSError**)arg1 {
 return YES;
}
-(BOOL)validateWithSigningMethod:(long long*)arg0 error:(NSError**)arg1 {
 return YES;
}
-(BOOL)validateWithSigningMethod:(long long*)arg0 iCloudIdentifier:(*id)arg1 error:(NSError**)arg2 {
 return YES;
}
%end
%group unsigncutsAllowAnyContact
-(void)validateAppleIDValidationRecordWithCompletion:(void (^)(int, int, int, id))completion {
 //the following is a rebuild / reverse engineered of the actual method WorkflowKit has for this
 //but no longer check if sha256 phone/email hashes match in contact shared importing, just auto run completion block
 //while still respecting isPrivateSharingEnabled, as well as self importing
 SFAppleIDAccount* account = [[[%c(SFAppleIDClient) alloc]init]myAccountWithError:nil];
 if ([[account altDSID]isEqualToString:[[self appleIDValidationRecord]altDSID]]) {
  //the alt dsid matches with users - assume this is user's shortcut, no need for private sharing enabled
  completion(0x1,0x3,0x0,0x0);
 } else if ([%c(WFSharingSettings) isPrivateSharingEnabled]) { //respect privatesharingenabled pref
  completion(0x1, 0x2, 0x0, 0x0);
 } else {
  //Skipping AppleID Validation Record due to Private Sharing Disabled
  //(AKA: Error)
  completion(0x0, 0x2, 0x0, [%c(WFSharingSettings) privateSharingDisabledErrorWithShortcutName:nil]);
 }
}
%end
%end

%ctor {
 preferences = [[HBPreferences alloc] initWithIdentifier:@"cum.0xilis.unsigncutsprefs"];
 //if ([preferences boolForKey:@"isUnsigncutsEnabled"]) %init(unsigncuts);
 if ([preferences boolForKey:@"isInvalidSignatureEnabled"]) %init(unsigncutsInvalidSignature);
 if ([preferences boolForKey:@"isAllowAnyContactEnabled"]) %init(unsigncutsAllowAnyContact);
 %init(_ungrouped);
}