
Pod::Spec.new do |s|
  s.name             = 'DTRipper'
  s.version          = '0.0.3'
  s.summary          = 'Modular support framework'
  s.description      = <<-DESC
                    Modular support framework just like BeeHive.
                       DESC
  s.homepage         = 'https://github.com/NicolasKim/DTRipper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DreamTracer' => 'jinqiucheng@live.cn' }
  s.source           = { :git => 'https://github.com/NicolasKim/DTRipper.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.jianshu.com/u/62fd4a3ecff1'
  s.ios.deployment_target = '8.0'
  s.source_files = 'DTRipper/Classes/**/*'
  s.dependency 'DTRouter'
  s.prefix_header_contents = '#import <DTRipper/DTRipperConstants.h>'
end
