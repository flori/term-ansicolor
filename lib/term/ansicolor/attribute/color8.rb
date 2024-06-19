module Term
  module ANSIColor
    class Attribute
      class Color8
        Attribute.set :black,   30, color8: '#000000'
        Attribute.set :red,     31, color8: '#800000'
        Attribute.set :green,   32, color8: '#008000'
        Attribute.set :yellow,  33, color8: '#808000'
        Attribute.set :blue,    34, color8: '#000080'
        Attribute.set :magenta, 35, color8: '#800080'
        Attribute.set :cyan,    36, color8: '#008080'
        Attribute.set :white,   37, color8: '#c0c0c0'

        Attribute.set :on_black,   40, color8: '#000000'
        Attribute.set :on_red,     41, color8: '#800000'
        Attribute.set :on_green,   42, color8: '#008000'
        Attribute.set :on_yellow,  43, color8: '#808000'
        Attribute.set :on_blue,    44, color8: '#000080'
        Attribute.set :on_magenta, 45, color8: '#800080'
        Attribute.set :on_cyan,    46, color8: '#008080'
        Attribute.set :on_white,   47, color8: '#808080'
      end
    end
  end
end
