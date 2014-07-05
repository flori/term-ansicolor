module Term
  module ANSIColor
    class Attribute
      class Text
        Attribute.set :clear,         0 # String#clear is already used to empty string in Ruby 1.9
        Attribute.set :reset,         0 # synonym for :clear
        Attribute.set :bold,          1
        Attribute.set :dark,          2
        Attribute.set :faint,         2
        Attribute.set :italic,        3 # not widely implemented
        Attribute.set :underline,     4
        Attribute.set :underscore,    4 # synonym for :underline
        Attribute.set :blink,         5
        Attribute.set :rapid_blink,   6 # not widely implemented
        Attribute.set :negative,      7 # no reverse because of String#reverse
        Attribute.set :concealed,     8
        Attribute.set :strikethrough, 9 # not widely implemented
      end
    end
  end
end
