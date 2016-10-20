#
#  Be sure to run `pod spec lint NAME.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='china beijing'
# 验证podspec命令：pod spec lint或 pod spec lint --allow-warnings
# 文档发包:appledoc -c "阳君" --company-id "com.YJ" -p YJTableViewFactory -v 3.0.0 -o ./Documentation ./Classes
# pod发包：pod trunk push YJTableViewFactory.podspec --allow-warnings

Pod::Spec.new do |s|

    # ―――  Spec Metadata
    s.name     = "YJTableViewFactory"
    s.version  = "3.1.1"
    s.summary  = "UITableView工厂，可自动填充数据源，填充Cell，缓存高。"
    s.homepage = "https://github.com/937447974/YJTableViewFactory"
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.author   = { "阳君" => "937447974@qq.com" }
    s.source = { :git => "https://github.com/937447974/YJTableViewFactory.git", :tag => "v#{s.version}" }

    # ――― Build settings
    s.platform = :ios
    s.ios.deployment_target = "6.0"
    s.frameworks = "UIKit", "Foundation"
    s.requires_arc = true

    # ――― Source Code
    s.dependency 'YJCocoa'
    s.deprecated = true
    s.deprecated_in_favor_of = "YJCocoa"

end
