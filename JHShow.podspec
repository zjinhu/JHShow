 
Pod::Spec.new do |s|
  s.name             = 'JHShow'
  s.version          = '1.1.5'
  s.summary          = '轻松展示Toast以及loading.'
 
  s.description      = <<-DESC
							图文Toast、Loading.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHShow.git', :tag => s.version.to_s }
 
  s.platform         = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.public_header_files = "JHShow/JHShow/Class/JHShow.h"
  s.source_files = 'JHShow/JHShow/Class/**/*.{h,m}'
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.requires_arc        = true
  s.dependency 'Masonry'
  s.dependency 'JHButton'
end
