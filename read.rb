require_relative 'post'
require_relative 'task'
require_relative 'link'
require_relative 'memo'

# id, limit, type

require 'optparse'

options = {}
# Заведем нужные нам опции
OptionParser.new do |opt|
  # Этот текст будет выводиться, когда программа запущена с опцией -h
  opt.banner = 'Usage: read.rb [options]'

  # Вывод в случае, если запросили help
  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  # Опция --type будет передавать тип поста, который мы хотим считать
  opt.on('--type POST_TYPE', 'какой тип постов показывать ' \
         '(по умолчанию любой)') { |o| options[:type] = o }

  # Опция --id передает номер записи в базе данных (идентификатор)
  opt.on('--id POST_ID', 'если задан id — показываем подробно ' \
         ' только этот пост') { |o| options[:id] = o }

  # Опция --limit передает, сколько записей мы хотим прочитать из базы
  opt.on('--limit NUMBER', 'сколько последних постов показать ' \
         '(по умолчанию все)') { |o| options[:limit] = o }

  # В конце у только что созданного объекта класс OptionParser вызываем
  # метод parse, чтобы он заполнил наш хэш options в соответствии с правилами.
end.parse!

result = Post.find(options[:limit], options[:type], options[:id])

if result.is_a? Post
  # Если результат — это один объект класса Post, значит выводим его
  puts "Запись #{result.class.name}, id = #{options[:id]}"

  # Получим строки для поста с помощью метода to_string и выведем их на экран
  result.to_strings.each { |line| puts line }
else # покажем таблицу результатов
  # Если результат — это не один пост, а сразу несколько, показываем таблицу
  # Сначала — напечатаем шапку таблицы с названиями полей
  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '|'

  result.each do |row|
    puts

    row.each do |element|
      print "| #{element.to_s.delete("\\n")[0..40]}\t"
    end
  end
end

puts
