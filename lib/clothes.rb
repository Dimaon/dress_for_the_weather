class Clothes
  NO_THING = "Нет вещи"
  HEAD_DRESS = "Головной убор"
  BODY_DRESS = "Верхняя одежда"
  FOOT_DRESS = "Штаны"
  FEET_DRESS = "Обувь"

  def initialize(directory_path, temp)
    default_thing
    get_things_from_directory(directory_path)
    @temp = temp
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

  def things_by_type(thing_type)
    all_things_by_temp.map do |thing|
      thing if thing.dress_type.include?(thing_type)
    end
  end

  def head_things
    things_by_type(HEAD_DRESS)
  end

  def body_things
    things_by_type(BODY_DRESS)
  end

  def foot_things
    things_by_type(FOOT_DRESS)
  end

  def feet_things
    things_by_type(FEET_DRESS)
  end

  def other_things
    # Для остальных категорий
    all_things_by_temp.map do |thing|
      # Необходимо оптимизировать
      unless  thing.dress_type.include?(HEAD_DRESS) ||
              thing.dress_type.include?(BODY_DRESS) ||
              thing.dress_type.include?(FOOT_DRESS) ||
              thing.dress_type.include?(FEET_DRESS) ||
              thing.dress_type.include?(NO_THING)
        thing
      end
    end
  end

  # Одна случайная вещь в категории
  def thing_info(body_part_things)
    sample_thing = body_part_things.compact.sample
    if sample_thing
      sample_thing.dress_complect
    else
      # добавиь тип одежды, который отсувтсвует
      NO_THING
    end
  end
# Вывести в какой категории отсутсвует вещь
  def things_complect
    {
        head_dress: thing_info(head_things),
        body_dress: thing_info(body_things),
        foot_dress: thing_info(foot_things),
        feet_dress: thing_info(feet_things),
        other_dress: thing_info(other_things)
    }
  end
# Создаем предмет одежды по-умолчанию
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
end
