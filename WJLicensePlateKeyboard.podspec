#
#  Be sure to run `pod spec lint WJLicensePlateKeyboard.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "WJLicensePlateKeyboard"
  spec.version      = "1.0.0"
  spec.summary      = "自定义的车牌号码输入键盘，支持横竖屏模式，支持省份简称汉字，英文字母，数字的输入，输入时可以播放音效"
  spec.homepage     = "https://github.com/loyalwind/WJLicensePlateKeyboard"
  # spec.screenshots  = "https://github.com/loyalwind/WJLicensePlateKeyboard/tree/master/demo/gif/landscape.gif", "https://github.com/loyalwind/WJLicensePlateKeyboard/tree/master/demo/gif/portrait.gif"
  spec.license      = "MIT"
  spec.author       = { "PengWeiJian" => "loyalwind@163.com" }
  spec.platform     = :ios, "7.0"
  spec.source       = { :git => "https://github.com/loyalwind/WJLicensePlateKeyboard.git", :tag => "#{spec.version}" }
  spec.source_files = "WJLicensePlateKeyBoard/**/*.{h,m}"
  # spec.resource     = 'WJLicensePlateKeyBoard/WJLicensePlateKeyBoard.bundle'
  spec.resources = "WJLicensePlateKeyBoard/WJLicensePlateKeyBoard.bundle", "WJLicensePlateKeyBoard/UIDeviceModel.plist"
  spec.requires_arc = true


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
