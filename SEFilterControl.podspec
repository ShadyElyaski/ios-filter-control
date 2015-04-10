Pod::Spec.new do |s|
    s.name         = 'SEFilterControl'
    s.version      = '0.0.1'
    s.license      = 'MIT'
    s.authors      = { 'Shady Elyaski' => 'shady@elyaski.com' }
    s.homepage     = 'https://github.com/ShadyElyaski/ios-filter-control'
    s.summary      = 'An iOS Filter UIControl Subclass. Zero Graphics. Highly Customizable.'
    s.source       = { :git => 'https://github.com/nicolasgoutaland/ios-filter-control.git' :commit => '803388fa3276'}
    s.source_files = '*.{h,m}' 
    s.requires_arc = true

    s.platform = :ios
end
