Pod::Spec.new do |spec|
  spec.name         = 'LHelper'
  spec.version      = '1.0'
  spec.license      = 'MIT'
  spec.summary      = 'iOS Helper methods and categories'
  spec.homepage     = 'https://github.com/lukagabric/LHelper.git'
  spec.author       = 'Luka Gabric'
  spec.source       = { :git => 'git://github.com/lukagabric/LHelper.git' }
  spec.source_files = 'LHelper/Classes/*.{m,h,mm,hpp,cpp,c}'
  spec.requires_arc = true
end
