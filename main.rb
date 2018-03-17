require_relative "lib/wardrobe"
require_relative "lib/clothing_item"

dir_path = __dir__ + "/data/*.txt"

clothing_items = Dir[dir_path].map do |file_path|
  ClothingItem.from_file(file_path)
end

puts "Какая температура за окном?"
user_input = STDIN.gets.to_i

suitable_clothes =
    clothing_items.select do |clothing_item|
      clothing_item.suitable_by_temperature?(user_input)
    end

# Получаем хэш сгруппированный по типу шмотки
suitable_clothes_by_type = suitable_clothes.group_by(&:type)

suitable_clothes_by_type.values.each do |clothing|
  puts clothing.sample
end