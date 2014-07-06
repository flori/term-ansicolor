require 'test_helper'

if defined? Term::ANSIColor::Refinement
  class RefinementTest < Test::Unit::TestCase
    class SomeClass
      using Term::ANSIColor::Refinement

      def test_red
        'red'.red
      end

      def test_red_block
        red { 'red' }
      end

      def test_red_arg
        red 'red'
      end

      def test_color
        'color'.color(200)
      end

      def test_color_arg
        color(200, 'color')
      end

      def test_color_block
        color(200) { 'color' }
      end

      def test_on_color
        'on_color'.on_color(200)
      end

      def test_on_color_arg
        on_color(200, 'on_color')
      end

      def test_on_color_block
        on_color(200) { 'on_color' }
      end

      def test_decolor
        Term::ANSIColor.red('not red').decolor
      end

      def test_decolor_arg
        decolor Term::ANSIColor.red('not red')
      end

      def test_decolor_block
        decolor { Term::ANSIColor.red('not red') }
      end

      def test_uncolor
        Term::ANSIColor.red('not red').uncolor
      end

      def test_uncolor_arg
        uncolor Term::ANSIColor.red('not red')
      end

      def test_uncolor_block
        uncolor { Term::ANSIColor.red('not red') }
      end

      def test_uncolored
        Term::ANSIColor.red('not red').uncolored
      end

      def test_uncolored_block
        uncolored { Term::ANSIColor.red('not red') }
      end
    end

    def test_clean_string
      assert_equal nil, String < Term::ANSIColor
    end

    def test_attribute
      assert_equal "\e[31mred\e[0m", SomeClass.new.test_red
    end

    def test_attribute_block
      assert_equal "\e[31mred\e[0m", SomeClass.new.test_red_block
    end

    def test_attribute_arg
      assert_equal "\e[31mred\e[0m", SomeClass.new.test_red_arg
    end

    def test_color
      assert_equal "\e[38;5;200mcolor\e[0m", SomeClass.new.test_color
    end

    def test_color_arg
      assert_equal "\e[38;5;200mcolor\e[0m", SomeClass.new.test_color_arg
    end

    def test_color_block
      assert_equal "\e[38;5;200mcolor\e[0m", SomeClass.new.test_color_block
    end

    def test_on_color
      assert_equal "\e[48;5;200mon_color\e[0m", SomeClass.new.test_on_color
    end

    def test_on_color_arg
      assert_equal "\e[48;5;200mon_color\e[0m", SomeClass.new.test_on_color_arg
    end

    def test_on_color_block
      assert_equal "\e[48;5;200mon_color\e[0m", SomeClass.new.test_on_color_block
    end

    def test_decolor
      assert_equal "not red", SomeClass.new.test_decolor
    end

    def test_decolor_arg
      assert_equal "not red", SomeClass.new.test_decolor_arg
    end

    def test_decolor_block
      assert_equal "not red", SomeClass.new.test_decolor_block
    end

    def test_uncolor
      assert_equal "not red", SomeClass.new.test_uncolor
    end

    def test_uncolor_arg
      assert_equal "not red", SomeClass.new.test_uncolor_arg
    end

    def test_uncolor_block
      assert_equal "not red", SomeClass.new.test_uncolor_block
    end

    def test_uncolored
      assert_equal "not red", SomeClass.new.test_uncolored
    end

    def test_uncolored_block
      assert_equal "not red", SomeClass.new.test_uncolored_block
    end
  end
end
