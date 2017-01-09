Pod::Spec.new do |s|
    s.name         = "Reactive"
    s.version      = "1.0.0"
    s.summary      = "iOS Reactive programming on fire 🔥"
    s.description  = "Reactive is a collection of useful classes to provide developers with more reactive confidence."
    s.homepage     = "https://github.com/karimsallam/Reactive"
    s.license      = { :type => "Apache-2.0", :file => "LICENSE" }
    s.author             = { "Karim Sallam" => "hello@karimsallam.com" }
    s.social_media_url   = "http://twitter.com/karimsallam"
    s.ios.deployment_target = '9.0'
    s.osx.deployment_target = '10.10'
    s.watchos.deployment_target = '2.0'
    s.tvos.deployment_target = '9.0'
    s.source       = { :git => "https://github.com/karimsallam/Reactive.git", :tag => s.version }
    s.default_subspec = "Core"
    
    s.subspec "Core" do |ss|
        ss.source_files  = "Reactive/Reactive/*"
        ss.dependency "ReactiveSwift", "1.0.0-alpha.4"
        ss.dependency "ReactiveCocoa", "5.0.0-alpha.3"
        ss.framework  = "Foundation"
    end
end
