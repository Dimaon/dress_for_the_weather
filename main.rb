require_relative "lib/clothes"
require_relative "lib/thing"

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
  puts "Введите температуру от -35 до +40"
  user_input = STDIN.gets.to_i
end until (-35..+40).include?(user_input)

clothes = Clothes.new(directory_path, user_input)


clothes_to_wear = []
clothes_to_wear << clothes.things_complect[:head_dress]
clothes_to_wear << clothes.things_complect[:body_dress]
clothes_to_wear << clothes.things_complect[:foot_dress]
clothes_to_wear << clothes.things_complect[:feet_dress]
clothes_to_wear << clothes.things_complect[:other_dress]

puts "Предлагаем сегодня надеть:"
clothes_to_wear.each do |thing|
  puts thing if thing != "Нет вещи"
end