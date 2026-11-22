# Changes

## 2026-11-19 v1.12.0

### Improvements

- Added `.yardoc` to `.gitignore` and the `Rakefile` ignore list.
- Added changelog generation support to the `Rakefile` using `GemHadar`,
  outputting to `CHANGES.md`.
- Updated `lib/term/ansicolor/version.rb` with auto-generated header
  comments and updated constant documentation.
- Removed stale vim modelines from `Gemfile` and `Rakefile`.

### Build & CI

- Added Ruby **4.0** support to the CI configuration in `.all_images.yml`.
- Added `openssl-dev` to the Docker image dependencies.
- Changed the `bundle update` command in the CI script to `bundle
  update --all`.
- Updated `rubygems_version` in `term-ansicolor.gemspec` to **4.0.24**.
- Updated the minimum `gem_hadar` development dependency to **2.24.1**.

## 2025-09-11 v1.11.3

### Fixes
- Removed the superfluous `require 'mize'` statement to fix issue
  #41.

### Improvements
- Migrated the change log from the plain text `CHANGES` file to Markdown
  in `CHANGES.md`.
- Removed the obsolete `CHANGES` file and updated the gemspec to exclude
  it.
- Renamed the license file from `COPYING` to `LICENSE`.
- Updated the license section in `README.md` to reflect the new file
  name and wording.

### Build & CI
- Modernized the Docker build process in `.all_images.yml` by adding
  `gem update --system`, replacing `bundle` with `bundle update` and
  parallel `bundle install`, and adding `bundler` to the gem
  installation command.
- Added the `fail_fast: true` option to the CI configuration.
- Removed `ruby:2.6-alpine`, `ruby:2.7-alpine`, and `ruby:3.0-alpine`
  from the test image list.
- Removed the glob for `.github/**/*` files from the package ignore
  list in the `Rakefile`.
- Removed the `binary false` configuration from `.utilsrc`.
- Replaced the manual `SimpleCov` setup in `tests/test_helper.rb` with
  `GemHadar::SimpleCov.start`.
- Updated the `tins` dependency constraint from `~> 1.0` to `~> 1`.
- Updated the `gem_hadar` development dependency to `~> 2.4`.
- Added `all_images` with version constraint `~> 0.8` and `debug` as
  development dependencies.

## 2024-08-04 v1.11.2

### Improvements
- Removed the redundant `mize` require statement from the main library
  file.

## 2024-08-01 v1.11.1

### Fixes
- Made the library compatible with Ruby's `--enable-frozen-string-literal`
  by using `.dup` on string literals to prevent `FrozenError` exceptions.
- Removed the dependency on the `mize` gem, which was no longer required.

### Build & CI
- Excluded development and configuration files, such as `.all_images.yml`,
  `.tool-versions`, and the `.github` directory, from the packaged gem.
- Updated the test suite to run with `--enable-frozen-string-literal` to
  verify string literal immutability compatibility.

### Documentation
- Corrected the project homepage URL in `README.md` to point to
  `https://github.com/flori/term-ansicolor`.

## 2024-08-01 v1.11.0

### Features
- Add `term_plasma` executable to draw a plasma effect on the
  console, supporting an optional refresh interval via the `-n`
  flag.

### Fixes
- Mark `on_color7` as a background color in the `color256`
  definition to ensure correct nearest-color matching.

### Improvements
- Add memoized `rgb_foreground_colors` and
  `rgb_background_colors` methods to improve color lookup
  performance.
- Refactor internal array operations to reduce unnecessary
  allocations in `HSLTriple`, `RGBTriple`, `RGBColorMetrics`,
  and `PPMReader`.

### Build & CI
- Bump development dependency `gem_hadar` to version **1.16.1**.

## 2024-07-15 v1.10.4

### Build & CI
- Constrained the `mize` dependency to `~> 0.5`
- Updated the `gem_hadar` development dependency to `~> 1.16.0`

## 2024-07-15 v1.10.3

### Features
- The `term_mandel` executable now doubles the display resolution using
  256-color upper-half-block characters.

### Improvements
- Refactored `HSLTriple` and `RGBTriple` initialization to use the standard
  library `clamp` method for value bounds.
- Updated underline color handling to use the new `ask_and_send` interface
  from `tins/xt`, simplifying RGB conversion logic.

### Testing
- Added tests for `underline` with invalid type and color arguments.
- Corrected usage of `assert_raise` to `assert_raises` in multiple test
  files.

### Documentation
- Documented the `term_snow` executable in the README.
- Updated executable names in the README to include the `term_` prefix for
  `cdiff` and `decolor`.

## 2024-06-22 v1.10.2

### Improvements
- Initialize the `@direct` instance variable to `false` in the `Attribute`
  constructor to ensure compatibility with older Ruby versions.
- Replace anonymous block parameters (`_1`) with explicit block parameters
  (`|c|`) in gradient tests to support older Ruby versions.

### Build & CI
- Update the CI dockerfile to conditionally install `bundler` and `gem_hadar`
  based on the Ruby version, supporting Ruby **2.6** and **2.7**.
- Add `ruby:2.7-alpine` and `ruby:2.6-alpine` images to the test matrix.

## 2024-06-22 v1.10.1

### Fixes
- Correct the HTML color code for the `color2` attribute
  from `#808000` to `#008000` in `Color256`.

### Improvements
- Rename the `color8` option and its associated state to
  `direct` to unify the handling of direct color attributes.
- Assign `direct` color values to all `Color8` and
  `IntenseColor8` attributes to enable consistent
  rendering of direct colors.

## 2024-06-21 v1.10.0

### Features
- Added `underline` and `underscore` methods with support for
  configurable line types and colors.
- Added `overline` attribute support (code 53).
- Added `color8` support to `Attribute` for 8-bit color handling.

### Fixes
- Corrected the `COLORED_REGEXP` to include `4:\d` and `53` for proper
  uncoloring of underlined and overlined text.
- Fixed `on_color7` in `color256.rb` to include the `background: true`
  option.

### Improvements
- Replaced dynamic method creation with `define_method` and included
  the `Underline` module for better organization.
- Removed the `support?` method and the legacy `ATTRIBUTE_NAMES`
  constant.
- Removed the Ruby < 1.9 ordering hack in `Attribute`.
- Added `mize` as a runtime dependency for memoization.
- Updated `.gemspec` and `Rakefile` to include the `mize` dependency
  and new files.

### Testing
- Added tests for `underline` with various types and colors.
- Updated `test_attributes` to use an explicit list of attributes.
- Updated tests to use symbol-based hash syntax.

## 2024-06-18 v1.9.0

### Features
- Added support for true color (24-bit) output, controlled by the
  `Term::ANSIColor.true_coloring` flag or the `COLORTERM` environment
  variable.
- Updated `Attribute[]` and `gradient_to` to generate 24-bit color codes
  when true color mode is enabled.
- Added a `-t` option to the `term_display` executable to enable true
  color rendering.

### Fixes
- Fixed a bug in `term_snow` where the horizontal position of snowflakes
  was not incremented, causing them to remain stationary.

### Improvements
- Updated the `COLORED_REGEXP` pattern to recognize and strip 24-bit
  ANSI color codes during uncoloring.

### Testing
- Added tests for the `true_coloring` flag, true color attribute
  generation, and true color gradients.
- Added a test for rendering PPM files with true color support.
- Fixed `hyperlink_test.rb` to correctly extend strings with the
  `Term::ANSIColor` module.

### Build & CI
- Added `.utilsrc` configuration for build and development tools.
- Added `errors.lst` to `.gitignore` and Rake ignore patterns.

## 2024-04-14 v1.8.0

### Features
- Added support for OSC 8 hyperlinks via the `hyperlink` method,
  allowing the creation of clickable links in the terminal using
  parameters for the link URL, display string, optional ID, and a
  flag to treat the URL as the display text.

### Build & CI
- Updated CI configuration to include testing on the **Ruby 3.3**
  Alpine image.
- Updated the local tool version to **Ruby 3.3.0**.

### Testing
- Added a new test suite for the `hyperlink` method to verify
  switch on/off behavior, argument handling, and block usage.

## 2024-03-15 v1.7.2

### Improvements
- Update homepage URL to use GitHub.

### Build & CI
- Migrate CI from Travis CI to GitHub Actions using `.all_images.yml`.
- Drop test coverage for Ruby **2.6** and earlier versions.
- Update local Ruby tool version to **3.2.3**.
- Remove `required_ruby_version` constraint from gemspec.
- Add `utils` as a development dependency.
- Bump development dependency `gem_hadar` to version **1.14**.

### Documentation
- Update project homepage metadata in the Rakefile and gemspec.

## 2019-01-18 v1.7.1

### Fixes
- Correct the `usage` method in `term_display` to use a
  proper heredoc, fixing broken output.

### Build & CI
- Add Ruby **2.6** to the Travis CI test matrix.

## 2018-11-02 v1.7.0

### Features
- Add `Term::ANSIColor::Movement` module to provide cursor
  positioning and screen manipulation capabilities, including
  methods such as `move_to`, `clear_screen`, and
  `return_to_position`.
- Add a new executable, `term_snow`, which uses the movement
  commands to render an animated snowfall effect in the terminal.

### Fixes
- Rename the `:negative` text attribute to `:reverse` and add
  `:conceal` as a synonym for `:concealed`.
- Update the test suite to skip `:reverse` during attribute
  verification, as `String#reverse` is already defined in Ruby
  core, and update `term_colortab` to separate color cubes with
  additional newlines for improved readability.

### Build & CI
- Update the Travis CI configuration to include Ruby **2.5** and
  update the Ruby version entries to use generic minor version
  references for **2.3** and **2.4**.

### Improvements
- Minor stylistic adjustments to test assertions for consistent
  formatting.

## 2017-04-13 v1.6.0

### Breaking
- Replaced the license from GPL-2 to Apache-2.0, starting from
  version **1.6.0**.

### Documentation
- Replaced `README.rdoc` with `README.md` and updated the license
  reference to Apache License, Version 2.0.

### Build & CI
- Updated the license and readme file references in the `Rakefile`
  and gemspec.
- Removed unused example image files from the gem distribution.

## 2017-03-28 v1.5.0

### Features
- Added support for HSL colors via the new `HSLTriple` class.
- Added methods to `RGBTriple` for inverting colors and generating CSS
  `rgb` strings.
- Added `from_css` methods to `RGBTriple` and `HSLTriple` for parsing CSS
  color definitions.
- Added `lighten`, `darken`, `saturate`, `desaturate`, `adjust_hue`,
  `grayscale`, and `complement` methods to `HSLTriple`.
- Implemented `to_hsl_triple` and `to_rgb_triple` conversion methods for
  both `RGBTriple` and `HSLTriple`.
- Added a `color` method to `RGBTriple` for direct ANSI escape sequence
  generation.

### Fixes
- Corrected `RGBTriple` value handling to clamp integers between 0 and 255
  during initialization.

### Improvements
- Extended `RGBTriple` to support percentage-based color values via new
  `percentages` and `red_p` methods.
- Updated `ANSIColor` attribute resolution to handle objects responding to
  `to_rgb_triple`.

### Testing
- Added test suite for `HSLTriple` covering conversions and manipulation
  methods.
- Added tests for `RGBTriple` CSS parsing, color inversion, and percentage
  calculations.

### Build & CI
- Replaced the `minitest_tu_shim` development dependency with `test-unit`.
- Removed the `install_library` task from the Rakefile.

## 2017-03-24 v1.4.1

### Fixes
- Fixed the conversion of short hexadecimal color codes in
  `RGBTriple[]` to ensure accurate RGB values are returned.
- Ensured the block yield result is always converted to a string
  in the `Term::ANSIColor` attribute wrapper methods.

### Build & CI
- Added Ruby **2.4.1** to the Travis CI test matrix.
- Removed the `codeclimate-test-reporter` integration from the
  test suite and `Gemfile`.
- Updated the development dependency on `gem_hadar` to require
  version **~> 1.9.1**.

### Testing
- Updated expected values for `#aaa` in attribute nearest color
  tests to reflect the corrected RGB calculation.
- Added a regression test for short hex color conversion in
  `RGBTriple` tests.

## 2016-09-27 v1.4.0

### Features
- Extended strings returned by `uncolor` and `Color` to support
  `Term::ANSIColor` methods.

### Improvements
- Refactored `Attribute` definitions into separate files.
- Refactored `Attribute.rgb_colors` to handle gray color rejection.
- Updated examples to use a simpler `Color` object definition.

### Build & CI
- Added Ruby **2.3.1** to the CI test matrix.
- Updated the `gem_hadar` development dependency to **1.8.0**.
- Updated CI configuration to use `jruby` and `sudo: false`.
- Updated `codeclimate-test-reporter` to require Ruby **1.9**+.
- Renamed executable scripts to include the `term_` prefix.

### Testing
- Added a test for the new string extension behavior.

## 2015-06-23 v1.3.2

### Build & CI
- Updated `.travis.yml` to test Ruby **2.0**, **2.1**, **2.2**, and `jruby-head`,
  while marking `ruby-head`, `jruby-head`, and `rbx-20mode` as allowed
  failures.
- Added `minitest_tu_shim` as a development dependency in the `Rakefile` and
  `term-ansicolor.gemspec`.
- Updated the `gem_hadar` development dependency to **~> 1.3.1**.

### Testing
- Replaced deprecated `assert_not_equal` assertions with `refute_equal` in
  `tests/ansicolor_test.rb`.
- Replaced deprecated `assert_raise` assertions with `assert_raises` in
  `tests/rgb_color_metrics_test.rb` and `tests/rgb_triple_test.rb`.

## 2015-06-17 v1.3.1

### Breaking
- Renamed executable files to prefix them with `term_`: `cdiff`,
  `colortab`, and `decolor` are now `term_cdiff`, `term_colortab`,
  and `term_decolor`.

### Features
- Refactored attribute definitions into separate files:
  `lib/term/ansicolor/attribute/text.rb`,
  `lib/term/ansicolor/attribute/color8.rb`,
  `lib/term/ansicolor/attribute/intense_color8.rb`, and
  `lib/term/ansicolor/attribute/color256.rb`.
- Updated `Attribute.rgb_colors` to accept options for filtering
  gray colors.

### Fixes
- Guarded the loading of `codeclimate-test-reporter` to ensure it only
  runs on Ruby 1.9 or higher.
- Changed deprecated `assert_raise` calls to `assert_raises` in tests.

### Improvements
- Updated the example script to use an object instance instead of a
  class for extending `Term::ANSIColor`.
- Simplified executable file discovery in the `Rakefile` using
  `Dir['bin/*']`.
- Added a shebang line to `examples/example.rb`.

### Build & CI
- Specified the minimum supported Ruby version as `1.9` in the
  `Rakefile` and `term-ansicolor.gemspec`.
- Added `codeclimate-test-reporter` to the test group for code
  coverage reporting.
- Removed `rbx` from the RVM configurations in `.travis.yml`.
- Added Ruby `2.1` to the RVM configurations in `.travis.yml`.

### Testing
- Added `minitest_tu_shim` as a development dependency and required
  `minitest/unit` in `tests/test_helper.rb` to support Minitest.

### Documentation
- Updated the `COPYING` file with the current GNU General Public
  License version 2 text and updated FSF address.

## 2014-02-06 v1.3.0

### Features
- Added `faint` attribute as a synonym for `dark`.
- Added `bright_*` and `on_bright_*` attribute aliases for high
  intensity color codes.

### Build & CI
- Updated `tins` dependency to `~>1.0`.
- Updated `gem_hadar` development dependency to `~>1.0.0`.

## 2013-05-30 v1.2.2

### Features
- `term_display` now supports image URLs directly via `open-uri`.

### Improvements
- Removed the post-install smiley message and `examples/smiley.txt` file.

## 2013-05-24 v1.2.1

### Fixes
- Prevent warnings when running in `-w` mode by explicitly
  initializing `@rgb` to `nil`.

### Improvements
- Skip assignment in `normalize_rgb_triple` to optimize code.

## 2013-05-16 v1.2.0

### Features
- Add `term_display` and `term_mandel` executables for rendering images
  and the Mandelbrot set in the terminal.
- Implement configurable color metrics (`Euclidean`, `NTSC`, `CompuPhase`,
  `YUV`, `CIEXYZ`, `CIELab`) for calculating color distances.
- Add `PPMReader` class to parse and render PPM image files.
- Implement `gradient_to` method for `RGBTriple` and `Attribute` to
  generate color gradients.
- Add support for RGB arrays (e.g., `[0x87, 0xff, 0xff]`) in `Attribute[]`.
- Add `gray?` check to `RGBTriple` and `Attribute`, and allow filtering
  out gray colors in nearest color lookups.
- Add `apply` method to `Attribute` for direct application to strings.
- Add post-install message displaying an ASCII smiley.

### Build & CI
- Add `tins` as a runtime dependency (`~> 0.8`).
- Add `post_install_message` to the Rakefile and gemspec.
- Update `gem_hadar` development dependency to `~> 0.3.1`.

### Testing
- Add tests for `PPMReader`, `RGBColorMetrics`, and gradient functionality.
- Update existing tests to reflect new default `CIELab` metric behavior.
- Fix test helper requires to use standard `require 'test_helper'`.

### Documentation
- Update `README.rdoc` to document new executables and examples.
- Update `CHANGES` log with new features.

## 2013-04-18 v1.1.5

### Features
- Added `colortab` executable to the gem's binary configuration.

## 2013-03-26 v1.1.4

### Features
- Allow numerical arguments to `color` and `on_color` methods.

### Improvements
- Simplified attribute lookup logic in the `color` method.

### Testing
- Added tests for numerical color arguments.

## 2013-03-26 v1.1.3

### Features
- Added support for direct access to color attributes using integer IDs or
  hexadecimal HTML color codes via `Attribute[]`, `color()`, and `on_color()`.

### Fixes
- Resolved a stack overflow issue in `respond_to?` by removing the custom
  `RespondTo` module.
- Updated `RGBTriple.from_html` to correctly handle background color prefixes
  (e.g. `on_#...`).
- Corrected `Attribute.distance_to` to return infinity when comparing against
  non-attribute objects.

### Build & CI
- Added `tests/attribute_test.rb` to the `s.files` and `s.test_files` lists
  in the gemspec.

### Testing
- Introduced a new test suite, `AttributeTest`, to verify attribute casting,
  distance calculations, and nearest RGB color lookups.
- Moved `nearest_rgb_color` and `nearest_rgb_on_color` tests from
  `ANSIColorTest` to `AttributeTest`.

## 2013-03-26 v1.1.2

### Breaking
- Change the `color` API: `color(:color0)` to `color(:color255)` and `on_color(:color0)` to `on_color(:color255)`; the previous numeric style was removed.

### Features
- Add support for `color` and `on_color` methods that accept HTML color strings (e.g., `color('#4a6ab4')`) to map to the nearest terminal color.
- Add `colortab` executable to display the 256 terminal colors and their related HTML colors.

### Improvements
- Refactor attribute handling into `Term::ANSIColor::Attribute` and `Term::ANSIColor::RGBTriple` classes.
- Remove `method_missing` implementation in favor of explicit color method generation.
- Update gem description and add license metadata to the gemspec.

### Build & CI
- Add `simplecov` as a development dependency for code coverage.
- Update `gem_hadar` development dependency to **0.3.0**.

### Testing
- Add tests for the new `color` and `on_color` methods.
- Add tests for `Term::ANSIColor::RGBTriple` including casting, array conversion, and distance calculations.
- Create `tests/test_helper.rb` to configure `simplecov` and load test dependencies.
- Refactor existing tests to use the new `color` and `on_color` APIs.

## 2013-03-08 v1.1.1

### Fixes
- Avoid possible conflicts with other `attributes` methods by
  renaming the internal lookup to `term_ansicolor_attributes`.
- Cache the list of attribute names globally in the module to
  improve performance and support frozen strings.

### Testing
- Add a test case to ensure methods work correctly on frozen
  strings.

## 2013-03-07 v1.1.0

### Features
- Implement `color0` through `color255` and `on_color0` through
  `on_color255` methods to support 256-color xterm modes.

### Fixes
- Rename the `uncolored` method to `uncolor` and add an alias to
  maintain backward compatibility.
- Extend the regular expression to properly identify and strip
  ANSI color sequences for 256-color mode.

### Improvements
- Dynamically define color methods using a refactored internal
  helper, reducing code duplication.
- Update the `Gemfile` to use the `https://` protocol for the
  `rubygems` source.
- Remove outdated `doc-main.txt` and `install.rb` files.

### Build & CI
- Add `2.0.0` to the list of Ruby versions tested by Travis CI.
- Configure `rbx` and `jruby` to run in specific 18 and 19 modes
  during continuous integration builds.

### Testing
- Update tests to verify the new `uncolor` method and validate
  256-color stripping capabilities.

### Documentation
- Update `CHANGES` to reflect the new release and feature set.

## 2011-10-19 v1.0.8

### Documentation
- Updated `CHANGES` log with details for **1.0.8** and **1.0.7**.
- Removed detailed usage examples from `README.rdoc`,
  referencing the `examples/example.rb` file instead.
- Cleaned up trailing whitespace in `doc-main.txt` and
  `lib/term/ansicolor.rb`.

## 2011-10-13 v1.0.7

### Breaking
- Fixed a Ruby 1.9 compatibility issue where the `:clear` color
  attribute conflicted with `String#clear`; use `:reset` instead and
  check `support?(:clear)` before relying on the `:clear` attribute.

### Features
- Added high-intensity color attributes, including `intense_black`,
  `intense_red`, `intense_green`, `intense_yellow`, `intense_blue`,
  `intense_magenta`, `intense_cyan`, and `intense_white`.
- Added high-intensity background attributes, including
  `on_intense_black`, `on_intense_red`, `on_intense_green`,
  `on_intense_yellow`, `on_intense_blue`, `on_intense_magenta`,
  `on_intense_cyan`, and `on_intense_white`.
- Added `support?` method to check if `Term::ANSIColor` supports a
  specific feature, such as the `:clear` attribute.

### Fixes
- Updated color methods to accept any object implementing `to_str`,
  improving support for string-like objects.
- Updated `COLORED_REGEXP` to match high-intensity color codes
  (e.g., `90`-`97` and `100`-`107`) in `uncolored`.
- Fixed `Array#to_s` output in examples to ensure ANSI codes are
  treated as raw strings rather than formatted arrays on Ruby 1.9.

### Improvements
- Moved the `require 'term/ansicolor/version'` call inside the
  `Term::ANSIColor` module namespace for cleaner encapsulation.
- Added `coverage` directory to `.gitignore` and Rakefile ignore
  patterns.

### Build & CI
- Added Travis CI configuration to test against Ruby 1.8.7, 1.9.2,
  1.9.3, ruby-head, REE, Rbx, and JRuby.
- Updated `gem_hadar` development dependency to **0.1.1**.

### Testing
- Added test cases for string-like objects supporting `to_str`.
- Updated attribute tests to skip the `:clear` attribute on Ruby 1.9
  implementations where `String#clear` is already defined.

## 2011-07-21 v1.0.6

### Breaking
- The `cdiff` executable now colors output unconditionally, removing the previous check that disabled coloring unless `STDOUT` was a terminal.

### Features
- Added `decolor` executable for stripping ANSI escape sequences from input streams.

### Fixes
- Updated `COLORED_REGEXP` to match ANSI reset sequences (`\e[0m`) and bare escape codes (`\e[m`) correctly.
- Fixed a bug in the `uncolored` method where `gsub` was called on the receiver instead of the converted string in the `to_str` case.
- Fixed a bug in the color attribute generation where `self` was appended instead of `to_str` in the `to_str` case.

### Improvements
- Refactored the build system to use the `gem_hadar` gem for package generation and dependency management.
- Renamed the `uncolor` executable to `decolor`.
- Simplified the namespace handling in examples by using `extend` instead of a class-level singleton.

### Build & CI
- Added a `Gemfile` and updated `.gitignore` to ignore `Gemfile.lock` and hidden swap files.
- Removed the `make_doc.rb` script as documentation generation is now handled by the build tools.
- Added `gem_hadar` as a development dependency in the gemspec.

### Testing
- Added a comprehensive test suite in `tests/ansicolor_test.rb` covering various usage patterns of the `Term::ANSIColor` module.

### Documentation
- Renamed `README` to `README.rdoc` and formatted it with RDoc-compatible markup.
- Expanded the README with detailed installation instructions, download links, and extensive usage examples.
- Updated the homepage references in the gemspec and README to point to the GitHub page.

## 2010-03-12 v1.0.5

### Documentation

- Fixed the capitalization of "RubyForge" in the project
  homepage link.
- Regenerated the RDoc HTML documentation for `Term::ANSIColor`,
  replacing the previous version.
- Replaced the generic `doc-main.txt` file with a `README` page
  in the generated documentation.
- Updated the documentation examples to use `extend` instead of
  `include` for the `Color` class to avoid namespace cluttering.
- Added a new "Installation" section to the generated documentation,
  detailing options for `ruby install.rb`, `rake install`, and
  `gem install`.
- Updated the documentation homepage and download links to point to
  `flori.github.com` and `www.ping.de` instead of RubyForge.
- Initial commit establishing the project homepage, including
  `index.html`, `Rakefile`, and associated template files.

## 2009-07-23 v1.0.4

* Some cleanup.
* Build a gemspec file.

## 2007-10-05 v1.0.3

* Better documentation + some code clean up.
* Deleted autorequire from Rakefile.

## 2005-11-12 v1.0.2

* Added DESTDIR in front of install path to make repackaging easier. Thanks to
  Tilman Sauerbeck <tilman@code-monkey.de> for giving the hint.

## 2005-09-05 v1.0.1

* Fixed install bug in Rakefile, reported by Martin DeMello
  <martindemello@gmail.com>

## 2004-12-23 v1.0.0

* Added Term::ANSIColor.coloring[?=]? methods. Thanks, Thomas Husterer for the
  contribution.
* Minor cleanup of code.
* Documented visible methods in the module.

## 2004-09-28 v0.0.4

* First release on Rubyforge
* Supports Rubygems now

## 2003-10-09 v0.0.3

* Added uncolored method as suggested by Thomas Husterer <Thomas.Husterer@heidelberg.com>
* Added attribute methods with string arguments
* Deleted now unused files

## 2002-07-27 v0.0.2

* Minor Code Cleanup
* Added cdiff.rb

## 2002-06-12 v0.0.1

* Start
