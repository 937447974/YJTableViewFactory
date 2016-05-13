#
#  Be sure to run `pod spec lint NAME.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='china beijing'
# 验证podspec命令：pod spec lint或 pod spec lint --allow-warnings
# 文档发包:appledoc -c "阳君" --company-id "com.YJFactory" -p YJTableViewFactory -v 2.0 -o ./Documentation ./Classes
# pod发包：pod trunk push YJTableViewFactory.podspec --allow-warnings

Pod::Spec.new do |s|

    # ―――  Spec Metadata
    s.name     = "YJTableViewFactory"
    s.version  = "2.1.0"
    s.summary  = "UITableView工厂，可自动填充数据源，填充Cell，缓存高。"
    s.homepage = "https://github.com/937447974/YJTableViewFactory"

    # ―――  Spec License
    s.license  = { :type => "MIT", :file => "LICENSE" }

    # ――― Author Metadata
    s.author   = { "阳君" => "937447974@qq.com" }

    # ――― Platform Specifics
    s.platform = :ios
    s.ios.deployment_target = "6.0"

    # ――― Source Location
    s.source = { :git => "https://github.com/937447974/YJTableViewFactory.git", :tag => "v#{s.version}" }

    # ――― Source Code
    s.source_files  = "Classes/*.{h,m}"
    s.default_subspec = 'Core'

    # ――― Project Linking
    s.frameworks = "UIKit", "Foundation"

    # ――― Project Settings
    s.requires_arc = true

    # ——— Documentation And API Reference
    s.preserve_paths = 'Documentation/*.*'
    s.prepare_command = 'sh Documentation/docset-installed.sh'

    # ——— Subspecs
    s.subspec 'Core' do |core|
        core.source_files = 'Classes/DataSource/*.{h,m}', 'Classes/Delegate/*.{h,m}', 'Classes/Extend/*.{h,m}', 'Classes/Suspension/*.{h,m}'
        core.dependency 'YJTableViewFactory/CellObject'
    end

    s.subspec 'CellObject' do |co|
        co.source_files = 'Classes/CellObject/*.{h,m}'
        co.dependency 'YJCocoa/Foundation'
        co.dependency 'YJCocoa/System'
        co.prefix_header_file = 'YJTableViewFactory/YJTableViewFactory/PrefixHeader.pch'
    end

end
