#import "ImglySDKPlugin.h"
#if __has_include(<imgly_sdk/imgly_sdk-Swift.h>)
#import <imgly_sdk/imgly_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "imgly_sdk-Swift.h"
#endif

@implementation ImglySDKPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {}
@end
