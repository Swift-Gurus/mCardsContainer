#
# Be sure to run `pod lib lint mCardsContainer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'mCardsContainer'
  s.version          = '0.1.3'
  s.summary          = 'A short description of mCardsContainer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aldo-dev/mCardsContainer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ALDO INC' => 'aldodev@aldogroup.com' }
  s.source           = { :git => 'https://github.com/aldo-dev/mCardsContainer.git', :tag => s.version.to_s }


  s.ios.deployment_target = '11.0'
  s.swift_version   = '5.0'

  s.source_files = 'mCardsContainer/Classes/**/*'
  
  s.dependency 'AHContainer'

end
