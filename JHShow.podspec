 
Pod::Spec.new do |s|
  s.name             = 'JHShow'
  s.version          = '1.5.0'
  s.summary          = '轻松展示Toast以及loading，添加普通弹窗以及模态方式弹窗.'
 
  s.description      = <<-DESC
							图文Toast、Loading.添加普通弹窗以及模态方式弹窗.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHShow.git', :tag => s.version.to_s }
 
  s.platform         = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  # s.public_header_files = "JHShow/JHShow/Class/*.h"
  # s.source_files = 'JHShow/JHShow/Class/**/*.{h,m}'
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.requires_arc        = true
  s.dependency 'Masonry'
  s.dependency 'JHButton'
  s.dependency 'JHMediator'

   s.public_header_files = 'JHShow/JHShow/Class/*.h'
   s.source_files =        'JHShow/JHShow/Class/*.{h,m}'
   
    s.subspec 'View' do |ss| 
          ss.dependency 'JHShow/Config'
          ss.source_files          = 'JHShow/JHShow/Class/View/**/*' 
          ss.public_header_files   = 'JHShow/JHShow/Class/View/*.{h}'
    end
    s.subspec 'Config' do |ss| 
          ss.source_files          = 'JHShow/JHShow/Class/Config/**/*' 
          ss.public_header_files   = 'JHShow/JHShow/Class/Config/*.{h}'
    end
    s.subspec 'VC' do |ss| 
          ss.source_files          = 'JHShow/JHShow/Class/VC/**/*' 
          ss.public_header_files   = 'JHShow/JHShow/Class/VC/*.{h}'
    end
end
