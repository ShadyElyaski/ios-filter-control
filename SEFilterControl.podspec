Pod::Spec.new do |s|
    s.name         = 'SEFilterControl'
    s.version      = '2.0.0'
    s.license      = 'MIT'
    s.authors      = { 'Shady Elyaski' => 'shady@elyaski.com', 'Nicolas Goutaland' => 'nicolas.goutaland@gmail.com' }
    s.homepage     = 'https://github.com/ShadyElyaski/ios-filter-control'
    s.summary      = 'An iOS Filter UIControl Subclass. Zero Graphics. Highly Customizable.'
    s.source       = { :git => 'https://github.com/ShadyElyaski/ios-filter-control.git', :tag => "#{s.version}"}
    s.source_files = '*.{h,m}' 
    s.requires_arc = true

    s.platform = :ios
end
