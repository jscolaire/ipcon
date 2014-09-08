# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ruby-ip"
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Candler"]
  s.date = "2011-12-13"
  s.description = "IP address manipulation library"
  s.email = "b.candler@pobox.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/deploy2/ruby-ip"
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "ruby-ip"
  s.rubygems_version = "1.8.23"
  s.summary = "IP address manipulation library"

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
