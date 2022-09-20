# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "grammar"
  spec.version       = "0.1.7"
  spec.license       = "MIT"

  spec.authors       = ["eQ19"]
  spec.email         = ["admin@eq19.com"]
  spec.homepage      = "https://github.com/eq19/grammar"
  spec.summary       = "A unique mapping system based on prime objects"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_sass|_includes|_layouts|_plugins|LICENSE|README)!i) }

  spec.add_runtime_dependency "github-pages", "~> 227"
  spec.add_runtime_dependency "jekyll", ">= 3.0", "< 5.0"
  spec.add_development_dependency "jekyll-tagging", "~> 1.1.0"
end
