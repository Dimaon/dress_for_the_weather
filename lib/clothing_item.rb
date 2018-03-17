class ClothingItem
  attr_reader :title, :type, :min_temp, :max_temp

  def self.from_file(file_path)
    file_line = File.readlines(file_path)
    args = {}
    args[:title] = file_line[0].chomp
    args[:type] = file_line[1].chomp
    temp_range = file_line[2].delete("() ").split(",")
    args[:min_temp] = temp_range[0].to_i
    args[:max_temp] = temp_range[1].to_i
    new(args)
  end

  def initialize(args)
    @title = args[:title]
    @type = args[:type]
    @min_temp = args[:min_temp]
    @max_temp = args[:max_temp]
  end

  def to_s
    "#{title} (#{type}) #{min_temp}..#{max_temp}"
  end

  def suitable_by_temperature?(t)
    t.between?(min_temp, max_temp)
  end
end