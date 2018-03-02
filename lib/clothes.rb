class Clothes
  NO_THING = "Нет подходящей вещи в вашем гардеробе"
  attr_reader :all_things
  def initialize(directory_path, temp)
    default_thing
    get_things_from_directory(directory_path)
    @temp = temp
  end

  def default_thing
    default_file = "./data/default.txt"
    unless File.exist?(default_file)
      file = File.new(default_file, "a")
      file.puts(NO_THING)
      file.puts(NO_THING)
      file.print("(-100, 100)")
      file.close
    end
    Thing.new(default_file)
  end

  def get_things_from_directory(directory_path)
    files = Dir.glob(directory_path)
    if files.empty?
      abort "Файлов не найдено"
    end
    @all_things = files.map{ |file_path| Thing.new(file_path) }
  end

  # получаем все обьекты вещей в зависимости от температуры
  def all_things_by_temp
    all_things_by_temp = @all_things.map do |thing|
      thing if thing.dress_temp.include?(@temp)
    end
    all_things_by_temp.compact
  end

  def head_things
    all_things_by_temp.map do |thing|
      thing if thing.dress_type.include?("Головной убор")
    end
  end

  def body_things
    all_things_by_temp.map do |thing|
      thing if thing.dress_type.include?("Верхняя одежда")
    end
  end

  def foot_things
    all_things_by_temp.map do |thing|
      thing if thing.dress_type.include?("Штаны")
    end
  end

  # Массив, обьектов содержащий обувь
  def feet_things
    all_things_by_temp.map do |thing|
      thing if thing.dress_type.include?("Обувь")
    end
  end

  def other_things
    # Для остальных категорий
    all_things_by_temp.map do |thing|
      unless  thing.dress_type.include?("Головной убор") ||
              thing.dress_type.include?("Верхняя одежда") ||
              thing.dress_type.include?("Штаны") ||
              thing.dress_type.include?("Обувь")
        thing
      end
    end
  end

  # Одна случайная вещь в категории
  def name_of_one_thing(body_part_things)
    sample_thing = body_part_things.compact.sample
    if sample_thing
      sample_thing.dress_complect
    else
      NO_THING
    end
  end

  def things_complect
    {
        head_dress: name_of_one_thing(head_things),
        body_dress: name_of_one_thing(body_things),
        foot_dress: name_of_one_thing(foot_things),
        feet_dress: name_of_one_thing(feet_things),
        other_dress: name_of_one_thing(other_things)
    }
  end
end