module Term
  module ANSIColor
    class Attribute
      @__store__ = {}

      def self.set(name, code, options = {})
        name = name.to_sym
        result = @__store__[name] = new(name, code, options)
        @rgb_colors = nil
        result
      end

      def self.[](name)
        case
        when self === name                              then name
        when name.to_s =~ /\A(on_)?(\d+)\z/             then get "#$1color#$2"
        when name.to_s =~ /\A#([0-9a-f]{3}){1,2}\z/i    then nearest_rgb_color name
        when name.to_s =~ /\Aon_#([0-9a-f]{3}){1,2}\z/i then nearest_rgb_on_color name
        else                                            get name
        end
      end

      def self.get(name)
        @__store__[name.to_sym]
      end

      def self.attributes(&block)
        @__store__.each_value(&block)
      end

      def self.rgb_colors(&block)
        @rgb_colors ||= attributes.select(&:rgb_color?).each(&block)
      end

      def self.named_attributes(&block)
        @named_attributes ||= attributes.reject(&:rgb_color?).each(&block)
      end

      def self.nearest_rgb_color(color)
        rgb = RGBTriple[color]
        rgb_colors.reject(&:background?).min_by { |c| c.distance_to(rgb) }
      end

      def self.nearest_rgb_on_color(color)
        rgb = RGBTriple[color]
        rgb_colors.select(&:background?).min_by { |c| c.distance_to(rgb) }
      end

      def initialize(name, code, options = {})
        @name = name.to_sym
        @code = code.to_s
        if html = options[:html]
          @rgb = RGBTriple.from_html(html)
        elsif !options.empty?
          @rgb = RGBTriple.from_hash(options)
        end
      end

      attr_reader :name

      def code
        if rgb_color?
          background? ? "48;5;#{@code}" : "38;5;#{@code}"
        else
          @code
        end
      end

      def background?
        @name.to_s.start_with?('on_')
      end

      attr_reader :rgb

      def rgb_color?
        !!@rgb
      end

      def to_rgb_triple
        @rgb
      end

      def distance_to(other)
        if our_rgb = to_rgb_triple and
          other.respond_to?(:to_rgb_triple) and
          other_rgb = other.to_rgb_triple
        then
          our_rgb.distance_to other_rgb
        else
          1 / 0.0
        end
      end
    end
  end
end
