#
# Be sure to run `pod lib lint LCNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LCNetworking'
  s.version          = '0.1.0'
  s.summary          = '基于NSURLSession的网络库。'

  s.description      = '基于NSURLSession的网络库。'

  s.homepage         = 'https://github.com/mlcldh/LCNetworking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'menglingchao' => '1228225993@qq.com' }
  s.source           = { :git => 'https://github.com/mlcldh/LCNetworking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LCNetworking/**/*'

   s.frameworks = 'CoreFoundation', 'QuartzCore'
   s.static_framework  =  true
  end
