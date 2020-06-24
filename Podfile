# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'

target 'SmartPortfolio' do
  # Comment the next line if you don't want to use dynamic frameworks

  pod 'SDVersion'
#  pod 'Google-Mobile-Ads-SDK'
  pod 'SAMKeychain'
  pod 'LMSideBarController'
  pod 'Toast'
  pod 'YLProgressBar', '~> 3.10.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = 'NO'
      v = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      if v.to_f < 10.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
      # Workaround for Cocoapods issue #7606
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
   end
  end
end
