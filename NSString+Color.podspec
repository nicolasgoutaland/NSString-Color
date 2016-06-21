Pod::Spec.new do |s|
  s.name         = "NSString+Color"
  s.version      = "1.1.4"
  s.summary      = "UIColor creation from NSString"
  s.description  = <<-DESC
	  				NSString category allowing you to create UIColor from it.

					This allows you to create color from hexadecimal representation or color name, such as @"#FF4465", @"red", @"antiquewhite"
					As a bonus, category also embeds a list of predefined web colors, according to http://en.wikipedia.org/wiki/Web_colors
					Category also works with FPBrandColors, UIColor-FlatColors and UIColor-CSSColors, since these are categories for UIColor.

					Main use case is when loading color configuration from configuration file.
					Last version add some method allowing you to register custom colors code, to be used afterward, allowing you to style your application with color codes.

					ARC only
                   DESC

  s.homepage     = "https://github.com/nicolasgoutaland/NSString-Color"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "nicolasgoutaland" => "nicolas.goutaland@gmail.com" }
  s.source       = { :git => "https://github.com/nicolasgoutaland/NSString-Color.git", :tag => "#{s.version}" }
  s.screenshot   = 'https://raw.github.com/nicolasgoutaland/NSString-Color/master/Assets/NSString+Colors.gif'  
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.requires_arc = true
  
  pch_COLOR = <<-EOS
#ifndef TARGET_OS_IOS
  #define TARGET_OS_IOS TARGET_OS_IPHONE
#endif
#ifndef TARGET_OS_WATCH
  #define TARGET_OS_WATCH 0
#endif
EOS

  s.prefix_header_contents = pch_COLOR
  s.ios.deployment_target = '5.0'
  s.watchos.deployment_target = '2.0'
  s.ios.frameworks = 'UIKit'
  s.watchos.frameworks = 'UIKit'
end
