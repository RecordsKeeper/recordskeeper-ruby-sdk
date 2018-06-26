
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "RecordsKeeperRubyLib/version"

Gem::Specification.new do |spec|
  spec.name          = "RecordsKeeperRubyLib"
  spec.version       = RecordsKeeperRubyLib::VERSION
  spec.authors       = ["Yusra Qureshi"]
  spec.email         = ["yusraq10"]

  spec.summary       = %q{RecordsKeeper-SDK-Ruby}
  spec.description   = %q{This is ruby library for RecordsKeeper.}
  spec.homepage      = "https://github.com/RecordsKeeper"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "httparty", "~> 0.16.2"
  spec.add_dependency "hex_string", "~> 1.0.1"
  spec.add_dependency "binary_parser", "~> 1.3.0"
  spec.add_dependency "json", "~> 2.1.0"
  spec.add_dependency "test-unit", "~>3.2.8"

end
