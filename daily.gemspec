lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daily/version'

Gem::Specification.new do |spec|
  spec.name          = "daily"
  spec.version       = Daily::VERSION
  spec.authors       = ["Thomas Cherry"]
  spec.email         = ["thomas.cherry@gmail.com"]
  spec.summary       = %q{A Daily Briefing print out for ESC/POS (thermal) printers.}
  spec.description   = %q{A Daily Briefing print out for ESC/POS (thermal) printers.}
  spec.homepage      = "https://github.com/jceaser/DailyBriefing"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "minitest", "~> 5.4"
end
