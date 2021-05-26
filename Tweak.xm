#import <Tweak.h>

bool isEnabled = true;

%hook AVOutputDevice

-(BOOL)supportsHeadTrackedSpatialAudio {
	return isEnabled? false : %orig;
}

%end

static void updatePrefs() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.semvis123.nospatialaudiobtnpreferences.plist"];
	if(prefs){
		isEnabled = [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : isEnabled;
	}
}


%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)updatePrefs, CFSTR("com.semvis123.nospatialaudiobtnpreferences/update"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	updatePrefs();
}
