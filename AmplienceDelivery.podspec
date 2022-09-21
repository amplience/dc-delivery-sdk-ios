Pod::Spec.new do |spec|
  spec.name          = 'AmplienceDelivery'
  spec.version       = '1.0.0'
  spec.license       = { :type => 'Amplience' }
  spec.homepage      = 'https://github.com/amplience/dc-delivery-sdk-ios'
  spec.authors       = { 'Andrew Hatch' => 'ahatch@amplience.com' }
  spec.summary       = 'Official iOS SDK for the Amplience Dynamic Content Delivery API, written in Swift.'
  spec.source        = { :git => 'https://github.com/amplience/dc-delivery-sdk-ios.git', :tag => 'v1.0.0' }
  spec.source_files  = 'amplience-sdk-ios/amplience-sdk-ios/*.swift', 'amplience-sdk-ios/amplience-sdk-ios/Helpers/*.swift', 'amplience-sdk-ios/amplience-sdk-ios/Media/*.swift', 'amplience-sdk-ios/amplience-sdk-ios/Models/*.swift', 'amplience-sdk-ios/amplience-sdk-ios/Network/*.swift', 'amplience-sdk-ios/amplience-sdk-ios/Media/*.swift'
end
