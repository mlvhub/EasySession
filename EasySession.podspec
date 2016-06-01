Pod::Spec.new do |spec|
  spec.name = "EasySession"
  spec.version = "0.1.0"
  spec.summary = "iOS Sessions made easy."
  spec.homepage = "https://github.com/mlvhub/EasySession"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Miguel López Valenciano" => 'miguellova@gmail.com' }

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/mlvhub/EasySession.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "EasySession/**/*.{h,swift}"

  spec.dependency "RxSwift"
  spec.dependency "RxCocoa"
  spec.dependency "SwiftKeychainWrapper"
end
