class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    # @items.each do |item|
    #   if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
    #     if item.quality > 0
    #       if item.name != "Sulfuras, Hand of Ragnaros"
    #         item.quality = item.quality - 1
    #       end
    #     end
    #   else
    #     if item.quality < 50
    #       item.quality = item.quality + 1
    #       if item.name == "Backstage passes to a TAFKAL80ETC concert"
    #         if item.sell_in < 11
    #           if item.quality < 50
    #             item.quality = item.quality + 1
    #           end
    #         end
    #         if item.sell_in < 6
    #           if item.quality < 50
    #             item.quality = item.quality + 1
    #           end
    #         end
    #       end
    #     end
    #   end
    #   if item.name != "Sulfuras, Hand of Ragnaros"
    #     item.sell_in = item.sell_in - 1
    #   end
    #   if item.sell_in < 0
    #     if item.name != "Aged Brie"
    #       if item.name != "Backstage passes to a TAFKAL80ETC concert"
    #         if item.quality > 0
    #           if item.name != "Sulfuras, Hand of Ragnaros"
    #             item.quality = item.quality - 1
    #           end
    #         end
    #       else
    #         item.quality = item.quality - item.quality
    #       end
    #     else
    #       if item.quality < 50
    #         item.quality = item.quality + 1
    #       end
    #     end
    #   end
    # end
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        handle_aged_brie(item)
      when 'Backstage passes'
        handle_backstage_passes(item)
      when 'Sulfuras'
        handle_sulfuras(item)
      when 'Conjured'
        handle_conjured(item)
      else
        handle_normal_item(item)
      end
    end

  end

  # "Aged Brie" actually increases in Quality the older it gets
  def handle_aged_brie(item)
    item.sell_in -= 1
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in < 0 && item.quality < 50
  end

  # "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
  # Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
  # Quality drops to 0 after the concert
  def handle_backstage_passes(item)
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality += 3
    elsif item.sell_in <= 10
      item.quality += 2
    else
      item.quality += 1
    end
    item.quality = 50 if item.quality > 50
  end

  def handle_sulfuras(_item)
    # "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
  end

  # "Conjured" items degrade in Quality twice as fast as normal items
  def handle_conjured(item)
    item.sell_in -= 1
    if item.quality >= 2
      item.quality -= 2
      item.quality -= 2 if item.sell_in < 0
    else
      item.quality = 0
    end
  end

  # Once the sell by date has passed, Quality degrades twice as fast
  def handle_normal_item(item)
    item.sell_in -= 1
    item.quality -= 1 if item.quality > 0
    item.quality -= 1 if item.sell_in < 0 && item.quality > 0
  end
  
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
