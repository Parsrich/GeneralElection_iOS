# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GeneralElection' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GeneralElection
  
  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxWebKit'
  pod 'RxAlamofire'
  pod 'NSObject+Rx'
  pod 'Action'
  pod 'RxKeyboard'
  
  # Firebase
  pod 'Firebase/Core'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Database'
  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
#  pod 'Firebase/AdMob'
  # Optionally, include the Swift extensions if you're using Swift.
  pod 'FirebaseFirestoreSwift'
  
  # Others
#  pod 'Alamofire'
  pod 'Carte'
  pod 'Kingfisher'
  pod 'ImageSlideshow', '~> 1.8.3'
  pod 'youtube-ios-player-helper', '~> 0.1.4'  
  pod 'SwiftyJSON'
end

post_install do |installer|
  pods_dir = File.dirname(installer.pods_project.path)
  at_exit { `ruby #{pods_dir}/Carte/Sources/Carte/carte.rb configure` }
end
