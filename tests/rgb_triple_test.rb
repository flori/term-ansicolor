require File.expand_path('test_helper', File.dirname(__FILE__))

class RgbTripleTest < Test::Unit::TestCase
  include Term::ANSIColor

  def test_rgb_cast
    rgb = RGBTriple.new(128, 0, 255)
    assert_equal '#8000ff', RGBTriple[ rgb ].html
    assert_equal '#8000ff', RGBTriple[ [ 128, 0, 255 ] ].html
    assert_equal '#8000ff', RGBTriple[ :red => 128, :green => 0, :blue => 255 ].html
    assert_raise ArgumentError do
      RGBTriple[ nil ]
    end
  end

  def test_rgb_to_a
    rgb = RGBTriple.new(128, 0, 255)
    assert_equal [ 128, 0, 255 ], rgb.to_a
  end

  def test_rgb_distace
    rgb1 = RGBTriple.new(128, 0, 255)
    rgb2 = RGBTriple.new(128, 200, 64)
    assert_in_delta 0.0, rgb1.distance_to(rgb1), 1e-3
    assert_in_delta 170.481, RGBTriple.new(0, 0, 0).distance_to(RGBTriple.new(255, 255, 255)), 1e-3
    assert_in_delta 119.402, rgb1.distance_to(rgb2), 1e-3
  end
end

