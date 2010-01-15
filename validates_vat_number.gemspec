Gem::Specification.new do |s|
  s.name = "validates_vat_number"
  s.summary = "Validations for european countries VAT numbers"
  s.description = "Validations for european countries VAT numbers"
  s.homepage = "http://github.com/aurels/validates_vat_number"
  
  s.version = "0.1"
  s.date = "2010-01-11"
  
  s.authors = ["Aurélien Malisart"]
  s.email = "aurelien.malisart@gmail.com"
  
  s.require_paths = ["lib"]
  s.files = Dir["lib/**/*"] + Dir["spec/**/*"] + ["LICENSE", "README.rdoc", "Rakefile", "install.rb", "init.rb", "uninstall.rb"]
  s.extra_rdoc_files = ["README.rdoc"]
  
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "CanCan", "--main", "README.rdoc"]
  
  s.rubygems_version = "1.3.4"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")
end