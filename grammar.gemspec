Gem::Specification.new do |spec|
  spec.name          = "grammar"
  spec.version       = "3.1.4"
  spec.authors       = ["eQ19"]
  spec.email         = ["admin@eq19.com"]

  spec.summary       = "Just another documentation theme compatible with GitHub Pages"
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/eq19/grammar"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "github-pages", "~> 227"
end
