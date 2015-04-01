Pod::Spec.new do |s|

  s.name         = "syncano-ios"
  s.version      = "4.0.0"
  s.summary      = "Library for http://syncano.com API"

  s.homepage     = "http://www.syncano.com"
  s.license      = 'MIT'
  s.author       = 'Syncano Inc.'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source = { :git => 'https://github.com/Syncano/syncano4-ios.git'}
  s.prefix_header_contents = "#import \"SCPrefixHeader.pch\""
  s.header_dir   =  'syncano4-ios'
  s.source_files = 'syncano4-ios/**/*.{h,m,pch}'
  s.public_header_files = 'syncano4-ios/**/*.h'

  s.dependency 'AFNetworking', '~> 2.2.1'
  s.dependency 'Mantle', '~> 1.5'

end