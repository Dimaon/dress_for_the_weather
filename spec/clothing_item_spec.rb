require 'rspec'
require_relative '../lib/clothing_item.rb'

describe ClothingItem do
  before(:all) do
    file_path = __dir__ + "/fixtures/item1.txt"
    @clothing_item = ClothingItem.from_file(file_path)
  end

  describe '.from_file' do
    it 'creates clothing_item from file' do
      expect(@clothing_item.title).to eq "Шуба"
      expect(@clothing_item.min_temp).to eq -40
      expect(@clothing_item.max_temp).to eq -16
    end
  end

  describe '#to_s' do
    it 'return result of to_s method' do
      expect(@clothing_item.to_s).to eq "Шуба (Верхняя одежда) -40..-16"
    end
  end

  describe '#suitable_by_temperature?' do
    it 'return false if temperature out of range' do
      expect(@clothing_item.suitable_by_temperature?(-50)).to be_falsey
    end

    it 'return true if temperature in range' do
      expect(@clothing_item.suitable_by_temperature?(-40)).to be_truthy
    end
  end
end
