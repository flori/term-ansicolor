module Term
  module ANSIColor
    class Attribute
      module Underline
        Attribute.set :underline,  4, skip_definition: true
        Attribute.set :underscore, 4, skip_definition: true # synonym for :underline

        def underline(string = nil, color: nil, type: nil, &block)
          code = {
            nil =>   4,
            default: '4:1',
            double:  '4:2',
            curly:   '4:3',
            dotted:  '4:4',
            dashed:  '4:5',
          }.fetch(type) { raise ArgumentError, "invalid line type" }
          if color
            a          = Term::ANSIColor::Attribute[color]
            color_code =
              if a.true_color? || a.rgb_color? || a.color8?
                color_code = "\e[58;2;#{a.rgb.to_a * ?;}"
              else
                raise ArgumentError, "invalid color #{a.name.inspect}"
              end
            code = "#{code}m#{color_code}"
          end
          apply_code(code, string, &block)
        end

        alias underscore underline
      end
    end
  end
end
