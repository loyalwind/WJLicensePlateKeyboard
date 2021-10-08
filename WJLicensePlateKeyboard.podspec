#
#  Be sure to run `pod spec lint WJLicensePlateKeyboard.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "WJLicensePlateKeyboard"
  spec.version      = "1.2.0"
  spec.summary      = "自定义的车牌号码输入键盘，支持横竖屏模式，支持省份简称汉字，英文字母，数字的输入，输入时可以播放音效"
  spec.homepage     = "https://github.com/loyalwind/WJLicensePlateKeyboard"
  # spec.screenshots  = "https://github.com/loyalwind/WJLicensePlateKeyboard/tree/master/demo/gif/landscape.gif", "https://github.com/loyalwind/WJLicensePlateKeyboard/tree/master/demo/gif/portrait.gif"
  spec.license      = "MIT"
  spec.author       = { "PengWeiJian" => "loyalwind@163.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/loyalwind/WJLicensePlateKeyboard.git", :tag => "#{spec.version}" }
  spec.source_files = "WJLicensePlateKeyBoard/**/*.{h,m}"
  spec.resource     = 'WJLicensePlateKeyBoard/WJLicensePlateKeyBoard.bundle'
  # spec.resources = "WJLicensePlateKeyBoard/WJLicensePlateKeyBoard.bundle"
  spec.requires_arc = true
  # spec.framework  = "UIKit"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
