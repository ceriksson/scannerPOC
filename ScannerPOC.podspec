Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '13.0'
s.name = "ScannerPOC"
s.summary = "ScannerPOC tests card scanning on iOS."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Carl Eriksson" => "carleriksson92@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/ceriksson/ScannerPOC"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "git@github.com:ceriksson/scannerPOC.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'CardScan'

# 8
s.source_files = "ScannerPOC/**/*.{swift}"

# 9
s.resources = "ScannerPOC/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.3"

end
