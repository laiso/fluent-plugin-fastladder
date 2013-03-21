# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-fastladder"
  gem.version       = '0.0.1'
  gem.authors       = ["laiso"]
  gem.email         = ["laiso@lai.so"]
  gem.description   = %q{Fastladder plugin for Fluent}
  gem.summary       = %q{Fastladder(https://github.com/fastladder/fastladder) plugin for Fluent. http://ssig33.com/text/OpenFastladder%20%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%A9%E3%83%BC%E5%90%91%E3%81%91%20RPC%20%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6}
  gem.homepage      = "https://github.com/laiso/fluent-plugin-fastladder"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "fluentd"
  gem.add_runtime_dependency "fluentd"
end
