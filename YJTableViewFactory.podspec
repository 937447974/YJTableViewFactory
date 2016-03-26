#
#  Be sure to run `pod spec lint YJTableViewFactory.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "YJTableViewFactory"
  s.version      = "1.0"
  s.summary      = "UITableView工厂，可自动填充数据源，填充Cell，缓存高。"
  s.homepage     = "https://github.com/937447974/YJTableViewFactory"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "阳君" => "937447974@qq.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios
  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.7"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source = { :git => "https://github.com/937447974/YJTableViewFactory.git", :tag => "1.0" }



  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "YJTableViewFactory/Classes/*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"

  # Project Linking
  s.frameworks = "UIKit", "Foundation"
  # Project Settings
  s.requires_arc = true

end
