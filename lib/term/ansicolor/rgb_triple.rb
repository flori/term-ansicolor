module Term
  module ANSIColor
    class RGBTriple
      def self.convert_value(color)
        color.nil? and raise ArgumentError, "missing color value"
        color = Integer(color)
        (0..0xff) === color or raise ArgumentError,
          "color value #{color.inspect} not between 0 and 255"
        color
      end

      private_class_method :convert_value

      def self.from_html(html)
        case html
        when /\A#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})\z/i
          new(*$~.captures.map { |c| convert_value(c.to_i(16)) })
        when /\A#([0-9a-f])([0-9a-f])([0-9a-f])\z/i
          new(*$~.captures.map { |c| convert_value(c.to_i(16) << 4) })
        end
      end

      def self.from_hash(options)
        new(
          convert_value(options[:red]),
          convert_value(options[:green]),
          convert_value(options[:blue])
        )
      end

      def self.from_array(array)
        new(*array)
      end

      def self.[](thing)
        case
        when thing.respond_to?(:to_rgb_triple) then thing
        when thing.respond_to?(:to_ary)        then RGBTriple.from_array(thing.to_ary)
        when thing.respond_to?(:to_str)        then RGBTriple.from_html(thing.to_str)
        when thing.respond_to?(:to_hash)       then RGBTriple.from_hash(thing.to_hash)
        else raise ArgumentError, "cannot convert #{thing.inspect} into #{self}"
        end
      end

      def initialize(red, green, blue)
        @values = [ red, green, blue ]
      end

      def red
        @values[0]
      end

      def green
        @values[1]
      end

      def blue
        @values[2]
      end

      def html
        s = '#'
        @values.each { |c| s << '%02x' % c }
        s
      end

      def to_rgb_triple
        self
      end

      attr_reader :values
      protected :values

      def to_a
        @values.dup
      end

      def ==(other)
        @values == other.values
      end

      def distance_to(other)
        Math.sqrt(
          ((red - other.red) * 0.299) ** 2 +
          ((green - other.green) * 0.587) ** 2 +
          ((blue - other.blue) * 0.114) ** 2
        )
      end
    end
  end
end
