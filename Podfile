# Uncomment the next line to define a global platform for your project
platform :ios, '13.5'

target 'WeatherFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeatherFinder
pod 'SwiftLint'

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.5'
      end
    end
end

end
