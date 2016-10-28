Pod::Spec.new do |spec|
  spec.name         = "LHelper"
  spec.version      = "1.0"
  spec.license      = 'MIT'
  spec.summary      = "iOS Helper methods and categories"
  spec.homepage     = "https://github.com/lukagabric/LHelper.git"
  spec.source       = { :git => 'git://github.com/lukagabric/LHelper.git'}
  spec.source_files = 'LHelper/Classes/*.{m,h,mm,hpp,cpp,c}'
  spec.resources    = 'LHelper/LHelper'
  spec.requires_arc = true
end
