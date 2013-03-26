require File.expand_path('test_helper', File.dirname(__FILE__))

class AttributeTest < Test::Unit::TestCase
  include Term::ANSIColor

  def test_cast
    color = Attribute.get(:color123)
    on_color = Attribute.get(:on_color123)
    assert_equal color, Attribute[color]
    assert_equal color, Attribute[:color123]
    assert_equal color, Attribute[123]
    assert_equal color, Attribute['123']
    assert_equal color, Attribute['#87ffff']
    assert_equal on_color, Attribute['on_123']
    assert_equal on_color, Attribute['on_#87ffff']
  end

  def test_distance_to
    assert_in_delta 149.685, Attribute.get(:color0).distance_to(Attribute.nearest_rgb_color('#0f0')), 1e-3
    assert_equal 1 / 0.0, Attribute.get(:color0).distance_to(nil)
  end

  def test_nearest_rgb_color
    assert_equal Attribute.get(:color0).rgb, Attribute.nearest_rgb_color('#000').rgb
    assert_equal Attribute.get(:color15).rgb, Attribute.nearest_rgb_color('#ffffff').rgb
  end

  def test_nearest_rgb_on_color
    assert_equal Attribute.get(:on_color0).rgb, Attribute.nearest_rgb_on_color('#000').rgb
    assert_equal Attribute.get(:on_color15).rgb, Attribute.nearest_rgb_on_color('#ffffff').rgb
  end
end

