Pod::Spec.new do |s|
  s.name         = "JKPopupController"
  s.version      = "0.3.5"
  s.summary      = "A versatile popup for iOS"

  s.description  = <<-DESC
                   CNPPopupController is a simple and versatile class for presenting a custom popup in a variety of fashions.
                   It includes a many options for controlling how your popup appears and behaves.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/xindizhiyin2014/CNPPopupController"
  s.screenshots  = "https://raw.githubusercontent.com/carsonperrotti/CNPPopupController/master/CNPPopupControllerExample/CNPPopupController.gif"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author    = "Carson Perrotti"
  s.social_media_url   = ""
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/xindizhiyin2014/CNPPopupController.git", :tag => s.version.to_s }
  s.source_files  = "CNPPopupController", "CNPPopupController/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
end
