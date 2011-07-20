
module Term
  module ANSIColor
    # HTML convert module
    module HTML
      ATTRIBUTE_VALUES = ATTRIBUTES.transpose.last

      # html escape chars/values
      ESC = {
        '&' => '&amp;',
        '"' => '&quot;',
        '<' => '&lt;',
        '>' => '&gt;'
      }
      ESC_KEYS = ESC.keys.join('')

      # escape sequences convert to html
      def self.convert(string, options = {})
        render_style_attributes = !options[:no_style]

        escape_html(string).gsub(COLORED_REGEXP) {|m|
          span_tag($1.to_i, render_style_attributes)
        }
      end

      # generate span tag from escape sequences number
      def self.span_tag(num, render_style_attributes)
        if num == 0
          "</span>"
        else
          "<span #{klass(num)}#{render_style_attributes ? style(num) : ''}>"
        end
      end
      
      # generate class attribute from escape sequences number
      def self.klass(num)
        name = ATTRIBUTE_NAMES[ATTRIBUTE_VALUES.index(num)].to_s.gsub('_', '-')
        %Q|class="ansi-color ansi-#{name}"|
      end

      # generate style attribute from escape sequences number
      def self.style(num)
        name = ATTRIBUTE_NAMES[ATTRIBUTE_VALUES.index(num)].to_s
        val = nil
        case name
        when "bold"
          val = "font-weight: bold"
        when "underline"
          val = "text-decoration: underline"
        when "blink"
          val = "text-decoration: blink"
        else
          if num >= 10
            if m = name.match(/^on_(.*)$/)
              val = "background-color: #{m[1]}"
            else
              val = "color: #{name}"
            end
          end
        end
        val ? %Q| style="#{val}"| : ""
      end

      # escape html chars
      def self.escape_html(string)
        string.gsub(/[#{ESC_KEYS}]/n) {|c| ESC[c] }
      end

      extend self
    end
  end
end
