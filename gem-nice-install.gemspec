# encoding: utf-8

gemspec = Gem::Specification.new do |s|
  s.name     = "gem-nice-install"
  s.version  = "0.3.0"

  s.summary     = "A RubyGems plugin that improves gem installation user experience."
  s.description = <<-EOF
A RubyGems plugin that improves gem installation user experience. If binary extension build fails,
it tries to install its development dependencies.
EOF

  s.homepage = "https://github.com/voxik/gem-nice-install"
  s.licenses = ["MIT"]
  s.author   = ["Vít Ondruch", "Bohuslav Kabrda", "Ivan Nečas", "Michal Fojtik"]
  s.email    = "vondruch@gmail.com"

  s.files = Dir["README.md", "MIT", "data/**/*.yml", "lib/**/*.rb"]

  s.signing_key = File.expand_path("~/.ssh/voxik-private_key.pem")
  s.cert_chain = ["voxik-public_cert.pem"]
end

