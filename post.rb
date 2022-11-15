class Post
  attr_reader(:created_at, :text)

  def self.post_types
    [Memo, Link, Task]
  end

  def self.create(type_index)
    post_types[type_index].new
  end

  def initialize
    @created_at = Time.now
    @text = nil
  end

  def read_from_console
  end

  def to_strings
  end

  def save
    file = File.new(file_path, "w:UTF-8")

    to_strings.each do |item|
      file.puts(item)
    end

    file.close
  end

  def file_path
    "#{__dir__}/data/#{created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")}"
  end

end
