#
# Be sure to run `pod lib lint JUNFlex.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JUNFlex'
  s.version          = '0.1.15'
  s.summary          = 'A ui framework that makes ios development easier.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Jun2786184671/JUNFlex'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jun Ma' => 'maxinchun5@gmail.com' }
  s.source           = { :git => 'git@github.com:Jun2786184671/JUNFlex.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'JUNFlex/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JUNFlex' => ['JUNFlex/Assets/*.png']
  # }

  s.public_header_files = 'JUNFlex/Classes/*.h', 'JUNFlex/Classes/core/builder/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'JUNTableView', '~> 0.1.0'
  s.dependency 'JUNCollectionView', '~> 0.1.0'
  s.dependency 'SDWebImage', '~> 5.0'
end
