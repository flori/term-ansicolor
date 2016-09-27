# -*- encoding: utf-8 -*-
# stub: term-ansicolor 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "term-ansicolor"
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Florian Frank"]
  s.date = "2016-09-27"
  s.description = "This library uses ANSI escape sequences to control the attributes of terminal output"
  s.email = "flori@ping.de"
  s.executables = ["term_cdiff", "term_colortab", "term_decolor", "term_display", "term_mandel"]
  s.extra_rdoc_files = ["README.rdoc", "lib/term/ansicolor.rb", "lib/term/ansicolor/attribute.rb", "lib/term/ansicolor/attribute/color256.rb", "lib/term/ansicolor/attribute/color8.rb", "lib/term/ansicolor/attribute/intense_color8.rb", "lib/term/ansicolor/attribute/text.rb", "lib/term/ansicolor/ppm_reader.rb", "lib/term/ansicolor/rgb_color_metrics.rb", "lib/term/ansicolor/rgb_triple.rb", "lib/term/ansicolor/version.rb"]
  s.files = [".gitignore", ".travis.yml", "CHANGES", "COPYING", "Gemfile", "README.rdoc", "Rakefile", "VERSION", "bin/term_cdiff", "bin/term_colortab", "bin/term_decolor", "bin/term_display", "bin/term_mandel", "examples/ColorTest.gif", "examples/Mona_Lisa.jpg", "examples/Stilleben.jpg", "examples/example.rb", "examples/lambda-red-plain.ppm", "examples/lambda-red.png", "examples/lambda-red.ppm", "examples/pacman.jpg", "examples/smiley.png", "examples/wool.jpg", "lib/term/ansicolor.rb", "lib/term/ansicolor/.keep", "lib/term/ansicolor/attribute.rb", "lib/term/ansicolor/attribute/color256.rb", "lib/term/ansicolor/attribute/color8.rb", "lib/term/ansicolor/attribute/intense_color8.rb", "lib/term/ansicolor/attribute/text.rb", "lib/term/ansicolor/ppm_reader.rb", "lib/term/ansicolor/rgb_color_metrics.rb", "lib/term/ansicolor/rgb_triple.rb", "lib/term/ansicolor/version.rb", "term-ansicolor.gemspec", "tests/ansicolor_test.rb", "tests/attribute_test.rb", "tests/ppm_reader_test.rb", "tests/rgb_color_metrics_test.rb", "tests/rgb_triple_test.rb", "tests/test_helper.rb"]
  s.homepage = "http://flori.github.com/term-ansicolor"
  s.licenses = ["GPL-2"]
  s.rdoc_options = ["--title", "Term-ansicolor - Ruby library that colors strings using ANSI escape sequences", "--main", "README.rdoc"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Ruby library that colors strings using ANSI escape sequences"
  s.test_files = ["tests/ansicolor_test.rb", "tests/attribute_test.rb", "tests/ppm_reader_test.rb", "tests/rgb_color_metrics_test.rb", "tests/rgb_triple_test.rb", "tests/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 1.8.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<minitest_tu_shim>, [">= 0"])
      s.add_runtime_dependency(%q<tins>, ["~> 1.0"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 1.8.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<minitest_tu_shim>, [">= 0"])
      s.add_dependency(%q<tins>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 1.8.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<minitest_tu_shim>, [">= 0"])
    s.add_dependency(%q<tins>, ["~> 1.0"])
  end
end
