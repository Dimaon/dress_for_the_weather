class Thing
  attr_accessor :dress_name, :dress_type, :dress_temp

  def initialize(file_path)
    thing_info(file_path)
  end

  def thing_info(file_path)
    file = File.new(file_path, "r")
    thing_lines = file.readlines.map{|i| i.chomp}
    @dress_name = thing_lines[0]
    @dress_type = thing_lines[1]
    # @dress_temp содержит строку (-20, -5), надо её преобразовать в диапазон
    # Доделать. Необходимо оптимизировать
    @dress_temp = thing_lines[2].delete("(").delete(")").split(",").inject { |s,e| s.to_i..e.to_i }
    file.close
    return thing_lines
  end

  def dress_complect
    "#{@dress_name} (#{dress_type}) #{@dress_temp}"
  end
end