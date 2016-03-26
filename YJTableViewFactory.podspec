Pod::Spec.new do |s|

  s.name     = "YJTableViewFactory"
  s.version  = "1.0"
  s.summary  = "UITableView工厂，可自动填充数据源，填充Cell，缓存高。"
  s.homepage = "https://github.com/937447974/YJTableViewFactory"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author   = { "阳君" => "937447974@qq.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform = :ios, '6.0'


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source = { :git => "https://github.com/937447974/YJTableViewFactory.git", :tag => "1.0" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "YJTableViewFactory/Classes/*.{h,m}"

  # Project Linking
  s.frameworks = "UIKit", "Foundation"
  # Project Settings
  s.requires_arc = true

end
