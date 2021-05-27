#include "NSARootListController.h"

@implementation NSARootListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)viewDidLoad {
	[super viewDidLoad];
	self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
	self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
	[[self headerImageView] setContentMode:UIViewContentModeScaleAspectFill];
	[[self headerImageView] setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/NoSpatialAudioBtnPreferences.bundle/banner.png"]];
	[[self headerImageView] setClipsToBounds:YES];
	[[self headerView] addSubview:[self headerImageView]];

	self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[NSLayoutConstraint activateConstraints:@[
		[self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
		[self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
		[self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
		[self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
	]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	tableView.tableHeaderView = [self headerView];
	tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
	return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(id)readPreferenceValue:(PSSpecifier *)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
}

-(void)twitter {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/semvis123"] options:@{} completionHandler:nil];
}
-(void)github {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/semvis123"] options:@{} completionHandler:nil];
}
-(void)donate {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.buymeacoffee.com/semvis123"] options:@{} completionHandler:nil];
}

-(void)respring:(id)sender {
	pid_t pid;
	const char *args[] = {"sbreload", NULL, NULL, NULL};
	posix_spawn(&pid, "usr/bin/sbreload", NULL, NULL, (char *const *)args, NULL);
}

@end
