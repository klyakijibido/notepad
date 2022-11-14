class Post
  attr_reader(:created_at, :text)

  def initialize
    @created_at = Time.now
    @text = nil
  end

  def read_from_console
    # todo
  end

  def to_strings
    # todo
  end

  def save
    file = File.new(file_path, "w:UTF-8")

    to_strings.each do |item|

    end
    file.close
  end

  def file_path
    "#{__dir__}/#{created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")}"
  end

end
