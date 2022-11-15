require_relative 'post'
require_relative 'task'
require_relative 'link'
require_relative 'memo'

puts 'Привет, это блокнот'
puts 'Что вы хотите записать в блокнот'

choices = Post.post_types

choice = -1


until choice.between?(1, choices.size)
  choices.each.with_index(1) { |type, i| puts "\t#{i}. #{type}"}

  choice = $stdin.gets.to_i
end

entry = Post.create(choice - 1)

entry.read_from_console

entry.save

puts 'Запись сохранена'
