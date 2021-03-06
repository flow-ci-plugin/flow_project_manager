# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "flow_project_manager/version"

Gem::Specification.new do |spec|
  spec.name          = "flow_project_manager"
  spec.version       = FlowProjectManager::VERSION
  spec.authors       = ["atpking"]
  spec.email         = ["atpking@gmail.com"]

  spec.summary       = "用来处理project 在实际机器中运行中flowci中与api的通信"
  spec.description   = "用来处理project 在实际机器中运行中flowci中与api的通信"
  spec.homepage      = "http://www.flow.ci"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "webmock"

  spec.add_dependency "api_tools"
  spec.add_dependency "nokogiri"
end
