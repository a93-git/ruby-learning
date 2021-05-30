class A
  def self.hello
    @a = 1
  end

  def hello
    @a = 2
  end

  def self.show_a
    puts @a
  end

  def show_a
    puts @a
  end
end

o = A.new
o.hello
A.hello
A.show_a
o.show_a
