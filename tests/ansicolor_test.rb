require 'test_helper'

class Color
  extend Term::ANSIColor
end

class StringLike
  def initialize(string)
    @string = string
  end

  def to_str
    @string
  end
end

class MyString < String
  include Term::ANSIColor
end

class ANSIColorTest < Test::Unit::TestCase
  include Term::ANSIColor

  def setup
    @foo                 = MyString.new 'foo'
    @string              = MyString.new "red"
    @string_red          = MyString.new "\e[31mred\e[0m"
    @string_red_on_green = MyString.new "\e[42m\e[31mred\e[0m\e[0m"
    @string_like         = StringLike.new(@string)
    @string_like_red     = StringLike.new(@string_red)
  end

  attr_reader :string, :string_red, :string_red_on_green, :string_like, :string_like_red

  def test_clean_string
    assert_equal nil, String < Term::ANSIColor
  end

  def test_red
    assert_equal string_red, string.red
    assert_equal string_red, Color.red(string)
    assert_equal string_red, Color.red { string }
    assert_equal string_red, Term::ANSIColor.red { string }
    assert_equal string_red, red { string }
  end

  def test_red_on_green
    assert_equal string_red_on_green, string.red.on_green
    assert_equal string_red_on_green, Color.on_green(Color.red(string))
    assert_equal string_red_on_green, Color.on_green { Color.red { string } }
    assert_equal string_red_on_green,
      Term::ANSIColor.on_green { Term::ANSIColor.red { string } }
    assert_equal string_red_on_green, on_green { red { string } }
  end

  def test_color
    assert_equal "\e[38;5;128mfoo\e[0m", Color.color(:color128, @foo)
    assert_equal "\e[38;5;128mfoo\e[0m", @foo.color(:color128)
    assert_equal "\e[38;5;128mfoo\e[0m", color(:color128, @foo)
    assert_equal "\e[38;5;128mfoo\e[0m", Color.color(:color128) { @foo }
    assert_equal "\e[38;5;128mfoo\e[0m", @foo.color(:color128) { @foo }
    assert_equal "\e[38;5;128mfoo\e[0m", color(:color128) { @foo }
    assert_equal "\e[38;5;128mfoo\e[0m", color(:color128) + @foo + color(:reset)
    assert_equal "\e[38;5;128mfoo\e[0m", Color.color(128, @foo)
    assert_equal "\e[38;5;128mfoo\e[0m", @foo.color(128)
    assert_equal "\e[38;5;128mfoo\e[0m", color(128, @foo)
    assert_equal "\e[38;5;128mfoo\e[0m", Color.color(128) { @foo }
    assert_equal "\e[38;5;128mfoo\e[0m", @foo.color(128) { @foo }
    assert_equal "\e[38;5;128mfoo\e[0m", color(128) { @foo }
    assert_equal "\e[38;5;128mfoo\e[0m", color(128) + @foo + color(:reset)
  end

  def test_on_color
    assert_equal "\e[48;5;128mfoo\e[0m", Color.on_color(:color128, @foo)
    assert_equal "\e[48;5;128mfoo\e[0m", @foo.on_color(:color128)
    assert_equal "\e[48;5;128mfoo\e[0m", on_color(:color128, @foo)
    assert_equal "\e[48;5;128mfoo\e[0m", Color.on_color(:color128) { @foo }
    assert_equal "\e[48;5;128mfoo\e[0m", @foo.on_color(:color128) { @foo }
    assert_equal "\e[48;5;128mfoo\e[0m", on_color(:color128) { @foo }
    assert_equal "\e[48;5;128mfoo\e[0m", on_color(:color128) + @foo + color(:reset)
    assert_equal "\e[48;5;128mfoo\e[0m", Color.on_color(128, @foo)
    assert_equal "\e[48;5;128mfoo\e[0m", @foo.on_color(128)
    assert_equal "\e[48;5;128mfoo\e[0m", on_color(128, @foo)
    assert_equal "\e[48;5;128mfoo\e[0m", Color.on_color(128) { @foo }
    assert_equal "\e[48;5;128mfoo\e[0m", @foo.on_color(128) { @foo }
    assert_equal "\e[48;5;128mfoo\e[0m", on_color(128) { @foo }
    assert_equal "\e[48;5;128mfoo\e[0m", on_color(128) + @foo + color(:reset)
  end

  def test_decolor
    assert_equal string, string_red.decolor
    assert_equal string, Color.decolor(string_red)
    assert_equal string, Color.decolor(string_like_red)
    assert_equal string, Color.decolor { string_red }
    assert_equal string, Color.decolor { string_like_red }
    assert_equal string, Term::ANSIColor.decolor { string_red }
    assert_equal string, Term::ANSIColor.decolor { string_like_red }
    assert_equal string, decolor { string }
    assert_equal string, decolor { string_like_red }
    assert_equal "", decolor(Object.new)
    for index in 0..255
      assert_equal @foo, Color.decolor(Color.color("color#{index}", @foo))
      assert_equal @foo, Color.decolor(Color.on_color("color#{index}", @foo))
    end
  end

  def test_attributes
    foo = @foo
    for a in Term::ANSIColor.attributes
      # skip clear for Ruby 1.9 which implements String#clear to empty the string
      if a != :clear || Term::ANSIColor.support?(:clear)
        refute_equal foo, foo_colored = foo.__send__(a)
        assert_equal foo, foo_colored.uncolor
      end
      refute_equal foo, foo_colored = Color.__send__(a, foo)
      assert_equal foo, Color.uncolor(foo_colored)
      refute_equal foo, foo_colored = Color.__send__(a) { foo }
      assert_equal foo, Color.uncolor { foo_colored }
      refute_equal foo, foo_colored = Term::ANSIColor.__send__(a) { foo }
      assert_equal foo, Term::ANSIColor.uncolor { foo_colored }
      refute_equal foo, foo_colored = __send__(a) { foo }
      assert_equal foo, uncolor { foo_colored }
    end
    assert_equal Term::ANSIColor.attributes, @foo.attributes
  end

  def test_coloring_string_like
    assert_equal "\e[31mred\e[0m", red(string_like)
  end

  def test_frozen
    string = @foo
    red = string.red
    string.extend(Term::ANSIColor).freeze
    assert string.frozen?
    assert_equal red, string.red
  end
end
