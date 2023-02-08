
class Memo < Post

  def read_from_console
    puts "новая заметка (все, что пишите до строчки \"end\"):"

    @text = []
    line = nil

    until line == 'end' do
      line = $stdin.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")}\n\n"

    return @text.unshift(time_string)
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text.join('\n')
      }
    )
  end

  def load_data(data_hash)
    # дергаем родительский метод для инициализации общих полей
    super(data_hash)

    # дописываем свое специфическое поле
    @text = data_hash['text'].split('\n')
  end
end
