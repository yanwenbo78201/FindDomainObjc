#
# Be sure to run `pod lib lint FindDomainObjc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FindDomainObjc'
  s.version          = '0.1.1'
  s.summary          = 'A short description of FindDomainObjc.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yanwenbo78201/FindDomainObjc'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Computer' => 'yanwenbo78201@gmail.com' }
  s.source           = { :git => 'https://github.com/yanwenbo78201/FindDomainObjc.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.5'

  s.source_files = 'FindDomainObjc/Classes/**/*.{h,m,swift}'
  s.exclude_files = 'FindDomainObjc/Classes/SwiftUsageExample.swift'
  
  # s.resource_bundles = {
  #   'FindDomainObjc' => ['FindDomainObjc/Assets/*.png']
  # }

  s.public_header_files = 'FindDomainObjc/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Reachability'
end
