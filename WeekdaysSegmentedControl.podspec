Pod::Spec.new do |s|
   s.name = 'WeekdaysSegmentedControl'
   s.version = '1.1.0'
   s.license = { :type => 'MIT', :file => 'LICENSE' }

   s.summary = 'Custom segmented control to select weekdays for iOS.'
   s.homepage = 'https://github.com/omaralbeik/WeekdaysSegmentedControl'
   s.social_media_url = 'https://twitter.com/omaralbeik'
   s.author = { 'Omar Albeik' => 'omaralbeik@gmail.com' }

   s.source = { :git => 'https://github.com/omaralbeik/WeekdaysSegmentedControl.git', :tag => s.version }
   s.source_files = 'WeekdaysSegmentedControl/*.swift'

   s.pod_target_xcconfig = {
      'SWIFT_VERSION' => '4.0',
   }

   s.ios.deployment_target = '9.0'
   s.requires_arc = true
end
