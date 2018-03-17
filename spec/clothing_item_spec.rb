require 'rspec'
require_relative '../lib/clothing_item.rb'

describe ClothingItem do
  before(:all) do
    file_path = __dir__ + "/fixtures/item1.txt"
    @clothing_item = ClothingItem.from_file(file_path)
  end

  it 'return result of to_s method' do
    expect(@clothing_item.to_s).to eq "Шуба (Верхняя одежда) -40..-16"
  end

  it 'return false if temperature out of range' do
    expect(@clothing_item.suitable_by_temperature?(-50)).to be_falsey
  end

  it 'return true if temperature in range' do
    expect(@clothing_item.suitable_by_temperature?(-40)).to be_truthy
  end
end