#include "BHBRootListController.h"
#include <spawn.h>

@implementation BHBRootListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(respringDevice)];
    self.navigationItem.rightBarButtonItem = applyButton;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
- (void) respringDevice
{
	UIAlertController *confirmRespringAlert = [UIAlertController alertControllerWithTitle:@"Apply settings?" message:@"This will respring your device" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       	pid_t pid;
		const char *argv[] = {"sbreload", NULL};
		posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)argv, NULL);
    }];

	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    [confirmRespringAlert addAction:cancel];
	[confirmRespringAlert addAction:confirm];

	[self presentViewController:confirmRespringAlert animated:YES completion:nil];
}
- (void) openTwitter
{
	NSURL *twitter = [NSURL URLWithString:@"https://twitter.com/shepgoba"];
	[[UIApplication sharedApplication] openURL:twitter options:@{} completionHandler:nil];
}
@end
