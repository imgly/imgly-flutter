#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint imgly_sdk.podspec' to validate before publishing.
#

require 'yaml'

content = YAML.load_file('../pubspec.yaml')

Pod::Spec.new do |s|
  s.name             = content['name']
  s.version          = content['version']
  s.summary          = content['description']
  s.description      = <<-DESC
The official base plugin for the photo_editor_sdk and video_editor_sdk Flutter plugins. Integrate the creative engine of tomorrow\'s world - in minutes!
                       DESC
  s.homepage         = content['homepage']
  s.license          = { :file => '../LICENSE' }
  s.author           = { content['homepage'] => 'contact@img.ly' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.dependency 'imglyKit', '~> 10.30'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
