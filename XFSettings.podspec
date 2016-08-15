Pod::Spec.new do |s|
s.name = 'XFSettings'
s.version = '2.3.0'
s.license = 'Apache'
s.summary = 'Build setting interface on iOS using Objective-C JSON.'
s.homepage = 'https://github.com/yizzuide/XFSettings'
s.authors = { 'yizzuide' => 'fu837014586@163.com' }
s.source = { :git => 'https://github.com/yizzuide/XFSettings.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '6.0'
s.source_files = 'XFSettings/*.{h,m}'
end