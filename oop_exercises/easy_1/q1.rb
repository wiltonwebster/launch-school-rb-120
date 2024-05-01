# Banner Class

# Behold this incomplete class for constructing boxed banners.

class Banner
  def initialize(message)
    @interior_length = message.length + 2
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private
  
  attr_reader :interior_length

  def horizontal_rule
    '+' + '-' * interior_length + '+'
  end

  def empty_line
    '|' + ' ' * interior_length + '|'
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
banner = Banner.new('')
puts banner