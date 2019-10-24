#
# Be sure to run `pod lib lint OLCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OLCore'
  s.version          = '0.9.0'
  s.summary          = 'One Labs Core Library'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/ndv6/core-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NDV6' => 'admin@ndv6.net' }
  s.source           = { :git => 'https://github.com/ndv6/core-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'OLCore/Classes/**/*'
  s.dependency 'SDWebImage'
end
