platform:ios,'8.0'
use_frameworks!


target ‘360du’ do
pod'Reachability','~>3.0.0'
platform:ios,'8.1'
pod'AFNetworking','~>3.1.0'
platform:ios,'8.1'
pod'MJRefresh','~>0.0.1'
platform:ios,'8.1'
pod'SDWebImage','~>3.7.1'
platform:ios,'8.1'
pod'IQKeyboardManager','~>3.2.1.1'
pod 'UMengSocial', '~> 4.3'
pod 'ReactiveCocoa'


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end

end

end
