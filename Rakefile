# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'term-ansicolor'
  path_name   'term/ansicolor'
  path_module 'Term::ANSIColor'
  author      'Florian Frank'
  email       'flori@ping.de'
  homepage    "http://flori.github.com/#{name}"
  summary     'Ruby library that colors strings using ANSI escape sequences'
  description 'This library uses ANSI escape sequences to control the attributes of terminal output'
  licenses    << 'GPL-2'
  test_dir    'tests'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', '.rvmrc', 'coverage', 'tags', '.bundle'
  readme      'README.rdoc'
  executables.merge Dir['bin/*'].map { |x| File.basename(x) }

  dependency             'tins', '~>1.0'
  development_dependency 'simplecov'
  development_dependency 'minitest_tu_shim'

  required_ruby_version '>= 2.0'

  install_library do
    destdir = "#{ENV['DESTDIR']}"
    libdir = CONFIG["sitelibdir"]
    cd 'lib' do
      for file in Dir['**/*.rb']
        dest = destdir + File.join(libdir, File.dirname(file))
        mkdir_p dest
        install file, dest
      end
    end
  end
end
