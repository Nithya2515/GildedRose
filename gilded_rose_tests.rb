require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_foo
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
  end

  def setup
    # Create instances of items for testing
    @normal_item = Item.new('Normal Item', 5, 10)
    @aged_brie = Item.new('Aged Brie', 5, 10)
    @backstage_passes = Item.new('Backstage passes', 15, 10)
    @sulfuras = Item.new('Sulfuras', 0, 80)
    @conjured_item = Item.new('Conjured', 5, 10)

    @gilded_rose = GildedRose.new([@normal_item, @aged_brie, @backstage_passes, @sulfuras, @conjured_item])
  end

  def test_update_quality_for_normal_item
    @gilded_rose.update_quality
    assert_equal(9, @normal_item.quality)
    assert_equal(4, @normal_item.sell_in)
  end

  def test_update_quality_for_aged_brie
    @gilded_rose.update_quality
    assert_equal(11, @aged_brie.quality)
    assert_equal(4, @aged_brie.sell_in)
  end

  def test_update_quality_for_backstage_passes
    @gilded_rose.update_quality
    assert_equal(11, @backstage_passes.quality)
    assert_equal(14, @backstage_passes.sell_in)
  end

  def test_update_quality_for_sulfuras
    @gilded_rose.update_quality
    assert_equal(80, @sulfuras.quality)
    assert_equal(0, @sulfuras.sell_in)
  end

  def test_update_quality_for_conjured_item
    @gilded_rose.update_quality
    assert_equal(8, @conjured_item.quality)
    assert_equal(4, @conjured_item.sell_in)
  end

end