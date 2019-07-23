#
# Be sure to run `pod lib lint HPCustomAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HCPCustomAlertController'
  s.version          = '0.1.8'
  s.summary          = 'custom alertController same as UIAlertController'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
这是用于自定义弹窗组件，方便用来自定义上面显示的视图，自定义按钮颜色。项目依赖Snapkit和SnapkitArrayExtension,
依赖的版本都没有设置限制，均为最新
                       DESC

  s.homepage         = 'https://github.com/hpzerozero/HPCustomAlertController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hpzerozero' => 'fly_dapeng@163.com' }
  s.source           = { :git => 'https://github.com/hpzerozero/HPCustomAlertController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HCPCustomAlertController/Classes/**/*'
  s.swift_version = '4.0'
  # s.resource_bundles = {
  #   'HPCustomAlertController' => ['HPCustomAlertController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
   s.dependency 'SnapKit'
   s.dependency 'SnapkitArrayExtention'
end
