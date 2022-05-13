file = File.open('../words.txt')
words = file.readlines.map(&:chomp).select { |word| word.length.between?(5,12) }
puts words[rand(0...words.length)]
file.close
