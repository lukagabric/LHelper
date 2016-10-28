Pod::Spec.new do |s|
  s.name         = "LHelper"
  s.version      = "1.0"
  s.summary      = "iOS Helper methods and categories"
  s.platform     = :ios, '6.0'
  s.homepage     = "https://github.com/lukagabric/LHelper.git"
  s.source       = { :git => 'git://github.com/lukagabric/LHelper.git'}
  s.source_files = 'LHelper/Classes/*.{m,h,mm,hpp,cpp,c}'
  s.resources    = 'LHelper/LHelper'
  s.requires_arc = true
end
