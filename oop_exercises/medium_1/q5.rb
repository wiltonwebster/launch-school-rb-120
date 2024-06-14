# Stack Machine Interpretation

class MinilangError < StandardError
end

class BadTokenError < MinilangError
end

class EmptyStackError < MinilangError
end

class Minilang
  def initialize(commands)
    @command_list = commands.split
    @stack = []
    @register = 0
  end
  
  def eval
    parse_commands
    command_list.each { |command| execute(command) }
  rescue MinilangError => error
    puts error.message
  end
  
  private
  
  attr_accessor :command_list, :stack, :register
  
  def parse_commands
    command_list.map! do |command|
      if command.to_i.to_s == command
        command.to_i
      else
        command.downcase.to_sym
      end
    end
  end
  
  def execute(command)
    if command.class == Symbol
      attempt(command)
    else
      place(command)
    end
  end
  
  def attempt(command)
    begin
      send(command)
    rescue NoMethodError
      raise BadTokenError, "Invalid token: #{command}"
    end
  end
  
  def place(num)
    self.register = num
  end
  
  def push
    self.stack.push(register)
  end
  
  def add
    self.register += pop
  end
  
  def sub
    self.register -= pop
  end
  
  def mult
    self.register *= pop
  end
  
  def div
    self.register /= pop
  end
  
  def mod
    self.register %= pop
  end
  
  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end
  
  def print
    puts register
  end
end


Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)