Pod::Spec.new do |spec|
    spec.name         = "Reactive"
    spec.version      = "0.0.1"
    spec.summary      = "iOS Reactive programming on fire 🔥"
    spec.description  = "Reactive is a collection of useful classes to provide developers with more reactive power."
    spec.homepage     = "https://github.com/karimsallam/Reactive"
    spec.license      = { :type => "Apache-2.0", :file => "LICENSE" }
    spec.author             = { "Karim Sallam" => "hello@karimsallam.com" }
    spec.social_media_url   = "http://twitter.com/karimsallam"
    spec.ios.deployment_target = '9.0'
    spec.source        = { :git => "https://github.com/karimsallam/Reactive.git" }
    spec.source_files  = "Reactive/Reactive/*"
    spec.dependency "ReactiveSwift", "1.0.0-alpha.4"
    spec.dependency "ReactiveCocoa", "5.0.0-alpha.3"
    spec.framework  = "Foundation"
end
