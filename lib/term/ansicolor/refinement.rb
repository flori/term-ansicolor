module Term
  module ANSIColor
    module Refinement
      refine Object do
        def self.create_color_method(color_name, color_value)
          module_eval <<-EOT
            def #{color_name}(string = nil, &block)
              !string.respond_to?(:to_str) && respond_to?(:to_str) and string = self
              ::Term::ANSIColor.color(:#{color_name}, string, &block)
            end
          EOT
          self
        end

        for attribute in Attribute.named_attributes
          create_color_method(attribute.name, nil)
        end

        def color(name, string = nil, &block)
          !string.respond_to?(:to_str) && respond_to?(:to_str) and string = self
          ::Term::ANSIColor.color(name, string, &block)
        end

        def on_color(name, string = nil, &block)
          !string.respond_to?(:to_str) && respond_to?(:to_str) and string = self
          ::Term::ANSIColor.on_color(name, string, &block)
        end

        def decolor(string = nil, &block)
          !string.respond_to?(:to_str) && respond_to?(:to_str) and string = self
          ::Term::ANSIColor.decolor(string, &block)
        end

        alias uncolor decolor

        alias uncolored decolor
      end
    end
  end
end
