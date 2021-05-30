$g = 10
module M
  X = 1
  puts "Global variable at scope 1: #{$g}"
  puts "Constant X at scope 1: #{X}"
  class C
    X = 2
    puts "Global variable at scope 2: #{$g}"
    puts "Constant X at scope 2: #{X}"
    class D
      X = 3
      puts "Global variable at scope 3: #{$g}"
      puts "Constant X at scope 3: #{X}"
      module N
        X = 4
        puts "Global variable at scope 4: #{$g}"
        puts "Constant X at scope 4: #{X}"
      end
    end
  end
end
