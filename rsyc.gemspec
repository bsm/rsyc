# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 1.9.1'
  s.required_rubygems_version = ">= 1.8.0"

  s.name        = File.basename(__FILE__, '.gemspec')
  s.summary     = "Rsyc"
  s.description = "A simple YAML configuration builder and accessor"
  s.version     = "0.2.0"

  s.authors     = ["Black Square Media"]
  s.email       = "info@blacksquaremedia.com"
  s.homepage    = "https://github.com/bsm/rsyc"
  s.licenses    = ["MIT"]

  s.require_path = 'lib'
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.metadata["yard.run"] = "yri"

  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "yard"
  s.add_development_dependency "coveralls"
end
