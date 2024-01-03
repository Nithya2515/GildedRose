require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe 'with regular items' do
    it 'updates quality and sell_in for a regular item' do
      items = [Item.new('Regular Item', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(9)
    end

    it 'ensures quality is never negative for a regular item' do
      items = [Item.new('Regular Item', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end
  end

  describe 'with Aged Brie' do
    it 'increases quality for Aged Brie' do
      items = [Item.new('Aged Brie', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(11)
    end

    it 'ensures quality is never more than 50 for Aged Brie' do
      items = [Item.new('Aged Brie', 5, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
    end
  end

  describe 'with Sulfuras' do
    it 'does not alter quality or sell_in for Sulfuras' do
      items = [Item.new('Sulfuras', 5, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(5)
      expect(items[0].quality).to eq(80)
    end
  end

  describe 'with Backstage passes' do
    it 'increases quality for Backstage passes with more than 10 days' do
      items = [Item.new('Backstage passes', 15, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(14)
      expect(items[0].quality).to eq(11)
    end

    it 'increases quality by 2 for Backstage passes with 10 days or less' do
      items = [Item.new('Backstage passes', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(12)
    end

    it 'increases quality by 3 for Backstage passes with 5 days or less' do
      items = [Item.new('Backstage passes', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(13)
    end

    it 'drops quality to 0 for Backstage passes after the concert' do
      items = [Item.new('Backstage passes', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq(0)
    end
  end

  describe 'with Conjured items' do
    it 'degrades quality twice as fast for Conjured items' do
      items = [Item.new('Conjured', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(8)
    end

    it 'ensures quality is never negative for Conjured items' do
      items = [Item.new('Conjured', 0, 1)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end
  end

end
