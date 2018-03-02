class Thing
  attr_accessor :dress_name, :dress_type, :dress_temp

  def initialize(file_path)
    @file_path = file_path
    thing_info
  end

  def thing_info
    file = File.new(@file_path, "r")
    thing = file.readlines.map{|i| i.chomp}
    @dress_name = thing[0]
    @dress_type = thing[1]
    # @dress_temp содержит строку (-20, -5), надо её преобразовать в диапазон
    # Доделать. Необходимо оптимизировать
    @dress_temp = thing[2].delete("(").delete(")").split(",").inject { |s,e| s.to_i..e.to_i }
    file.close
    return thing
  end

  def dress_complect
    "#{@dress_name} (#{dress_type}) #{@dress_temp}"
  end
end