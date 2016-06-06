#
#  Be sure to run `pod spec lint XLProgressHUD.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "XLProgressHUD"
  s.version      = "1.0.5"
  s.summary      = "XLProgressHUD A short description of"
  s.license      = "MIT"

  s.description  = "work is"
  s.social_media_url   = "http://weibo.com/5554844084/profile?topnav=1&wvr=6&is_all=1"
  s.homepage     = "https://github.com/williamxiaolong/XLProgressHUD"

  s.authors             = { "williamxiaolong" => "williamxiaolong@1198402764@qq.com" }

  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.9"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => "https://github.com/williamxiaolong/XLProgressHUD.git", :tag => s.version}


  s.source_files  = 'Source/*.swift'


end
