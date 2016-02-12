def update_quality(items)
  items.each do |item|
    unless legendary?(item)
      item.quality += daily_change(item)
      item.sell_in -= 1
      item.quality += expired_change(item)
      quality_boundaries(item)
    end
  end
end

def legendary?(item)
  item.name == 'Sulfuras, Hand of Ragnaros'
end

def backstage_passes?(item)
  item.name == 'Backstage passes to a TAFKAL80ETC concert'
end

def aging_well?(item)
  item.name == "Aged Brie"
end

def conjured?(item)
  item.name.include?("Conjured")
end

def degrading?(item)
  !aging_well?(item) && !backstage_passes?(item)
end

def daily_change(item)
  change = 0
  if degrading?(item)
    change += -1
  else
    change += 1 + backstage_passes_change(item)
  end
  change *= conjured_change(item)
  change
end

def backstage_passes_change(item)
  if backstage_passes?(item)
    if item.sell_in < 6
      return 2
    elsif item.sell_in < 11
      return 1
    end
  end
  0
end

def expired_change(item)
  if item.sell_in < 0
    return -50 if backstage_passes?(item)
    if aging_well?(item)
      change = 1
    else
      change = -1
    end
    return change * conjured_change(item)
  end
  0
end

def quality_boundaries(item)
  if item.quality > 50
    item.quality = 50
  elsif item.quality < 0
    item.quality = 0
  end
end

def conjured_change(item)
  return 2 if conjured?(item)
  1
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
