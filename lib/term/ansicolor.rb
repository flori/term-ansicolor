module Term

  # The ANSIColor module can be used for namespacing and mixed into your own
  # classes.
  module ANSIColor
    require 'term/ansicolor/version'
    require 'term/ansicolor/attribute'
    require 'term/ansicolor/rgb_triple'
    require 'term/ansicolor/ppm_reader'
    require 'term/ansicolor/attribute/text'
    require 'term/ansicolor/attribute/color8'
    require 'term/ansicolor/attribute/intense_color8'
    require 'term/ansicolor/attribute/color256'

    # :stopdoc:
    ATTRIBUTE_NAMES = Attribute.named_attributes.map(&:name)
    # :startdoc:

    # Returns true if Term::ANSIColor supports the +feature+.
    #
    # The feature :clear, that is mixing the clear color attribute into String,
    # is only supported on ruby implementations, that do *not* already
    # implement the String#clear method. It's better to use the reset color
    # attribute instead.
    def support?(feature)
      case feature
      when :clear
        !String.method_defined?(:clear)
      end
    end
    # Returns true, if the coloring function of this module
    # is switched on, false otherwise.
    def self.coloring?
      @coloring
    end

    # Turns the coloring on or off globally, so you can easily do
    # this for example:
    #  Term::ANSIColor::coloring = STDOUT.isatty
    def self.coloring=(val)
      @coloring = val
    end
    self.coloring = true

    def self.create_color_method(color_name, color_value)
      module_eval <<-EOT
        def #{color_name}(string = nil, &block)
          color(:#{color_name}, string, &block)
        end
      EOT
      self
    end

    for attribute in Attribute.named_attributes
       create_color_method(attribute.name, attribute.code)
    end

    # Regular expression that is used to scan for ANSI-Attributes while
    # decoloring strings.
    COLORED_REGEXP = /\e\[(?:(?:[349]|10)[0-7]|[0-9]|[34]8;5;\d{1,3})?m/

    def check_function_arguments(string, &block)
      if block_given? || string
        unless block_given? ^ string
          exception = ArgumentError.new(
            'passing of either a block or an argument is required'
          )
          exception.set_backtrace caller
          raise exception
        end
      end
    end

    def decolor_function(string, &block)
      check_function_arguments(string, &block)
      new_string_like(string,
        if block_given?
          yield.to_str.gsub(COLORED_REGEXP, '')
        elsif string.respond_to?(:to_str)
          string.to_str.gsub(COLORED_REGEXP, '')
        else
          string.to_s.gsub(COLORED_REGEXP, '')
        end
      )
    end

    def decolor_method()
      new_string_like(self,
        if respond_to?(:to_str)
          to_str.gsub(COLORED_REGEXP, '')
        else
          to_s.gsub(COLORED_REGEXP, '')
        end
      )
    end

    # Returns an uncolored version of the string, that is all
    # ANSI-Attributes are stripped from the string.
    def decolor(string = nil, &block)
      if string || block_given?
        decolor_function(string, &block)
      else
        decolor_method
      end
    end

    alias uncolor decolor

    alias uncolored decolor

    def new_string_like(other_string, string = '')
      if other_string.respond_to?(:to_str) &&
        [ 1, -1, -2 ].include?(other_string.class.instance_method(:initialize).arity)
      then
        other_string.class.new(string)
      else
        string.dup
      end
    end
    private :new_string_like

    def color_method(name)
      attribute = Attribute[name] or raise ArgumentError, "unknown attribute #{name.inspect}"
      result = new_string_like(self)
      result << "\e[#{attribute.code}m" if Term::ANSIColor.coloring?
      if respond_to?(:to_str)
        result << to_str
      end
      result << "\e[0m" if ::Term::ANSIColor.coloring?
      result
    end
    private :color_method

    def color_function(name, string = nil, &block)
      attribute = Attribute[name] or raise ArgumentError, "unknown attribute #{name.inspect}"
      check_function_arguments(string, &block)
      result = new_string_like(string)
      result << "\e[#{attribute.code}m" if Term::ANSIColor.coloring?
      if block_given?
        result << yield
      elsif string.respond_to?(:to_str)
        result << string.to_str
      elsif string
        result << string.to_s
      else
        return result # only switch on
      end
      result << "\e[0m" if ::Term::ANSIColor.coloring?
      result
    end
    private :color_function

    # Return +string+ or the result string of the given +block+ colored with
    # color +name+. If string isn't a string only the escape sequence to switch
    # on the color +name+ is returned.
    def color(name, string = nil, &block)
      if string || block_given? || !respond_to?(:to_str)
        color_function(name, string, &block)
      else
        color_method(name)
      end
    end

    def on_color(name, string = nil, &block)
      attribute = Attribute[name] or raise ArgumentError, "unknown attribute #{name.inspect}"
      color("on_#{attribute.name}", string, &block)
    end

    class << self
      # Returns an array of all Term::ANSIColor attributes as symbols.
      def term_ansicolor_attributes
        ::Term::ANSIColor::ATTRIBUTE_NAMES
      end

      alias attributes term_ansicolor_attributes
    end

    # Returns an array of all Term::ANSIColor attributes as symbols.
    def  term_ansicolor_attributes
      ::Term::ANSIColor.term_ansicolor_attributes
    end

    alias attributes term_ansicolor_attributes

    extend self
  end
end

if Module.private_method_defined?(:refine) && Module.private_method_defined?(:using)
  require 'term/ansicolor/refinement'
end
