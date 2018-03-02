require_relative "./lib/clothes.rb"
require_relative "./lib/thing.rb"

directory_path = "./data/*.txt"

puts "Что вы хотите сделать?"

begin
  puts "Введите '1', если хотите одеться или '2' если хотите добавить вещь в гардероб"
  user_choice = STDIN.gets.to_i
end until user_choice == 1 || user_choice == 2

if user_choice == 2
  puts "Добавляем вещь в гардероб"
  puts "Введите название вещи"
  dress_name = STDIN.gets.chomp
  puts "Введите категорию вещи(напирмер, Верхняя одежда, Обувь и т.д.)"
  dress_type = STDIN.gets.chomp.downcase
  puts "Введите мин. температуру, при которой можно носить вещь"
  dress_min = STDIN.gets.chomp.to_i
  puts "Введите макс. температуру, при которой можно носить вещь"
  dress_max = STDIN.gets.chomp.to_i
  if (dress_min.abs < dress_max.abs)
    dress_min, dress_max = dress_max, dress_min
  end
  dress_temp = (dress_min..dress_max)
  # Доделать. Возможно вынести в отдельный класс для добавления вещи
  # Создаем файл и добавляем вещь
  def add_thing_to_clothes(dress_name, dress_type, dress_min, dress_max)
    file_name = "./data/" + "thing_" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + ".txt"

    file = File.new(file_name, "a")
    file.puts(dress_name)
    file.puts(dress_type)
    file.print("(#{dress_min}, #{dress_max})")
    file.close
  end
  add_thing_to_clothes(dress_name, dress_type, dress_min, dress_max)
  exit
end

puts "Сколько градусов за окном? (можно с минусом)"
begin
  user_input = STDIN.gets.to_i
end until (-35..+40).include?(user_input)

clothes = Clothes.new(directory_path, user_input)

puts "Предлагаем сегодня надеть:"

puts clothes.things_complect[:head_dress]
puts clothes.things_complect[:body_dress]
puts clothes.things_complect[:foot_dress]
puts clothes.things_complect[:feet_dress]
other_dress = clothes.things_complect[:other_dress]
# Доделать. Тут тоже надо оптимизировать, но голова уже не варит
puts "Возможно вам также пригодиться: #{other_dress}" if other_dress != "Нет вещи"
