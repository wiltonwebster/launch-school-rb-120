def contains_alphanumeric(input)
  input.count("A-Za-z0-9")
end

word = gets.chomp
puts contains_alphanumeric(word)