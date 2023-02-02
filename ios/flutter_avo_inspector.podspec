#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_avo_inspector.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_avo_inspector'
  s.version          = '1.0.0'
  s.summary          = 'Avo Inspector for Dart. Find out what\'s wrong with your data. The first step to better analytics governance is knowing what\'s wrong with your data today.'
  s.description      = <<-DESC
Avo Inspector for Dart. Find out what's wrong with your data. The first step to better analytics governance is knowing what's wrong with your data today.
                       DESC
  s.homepage         = 'https://www.avo.app'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Solusi Bejo' => 'chandrashibezzo@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AvoInspector'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
