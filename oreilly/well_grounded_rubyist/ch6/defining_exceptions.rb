# Custom exceptions and namespacing and ensure
begin
  class A
    begin
      class B
        begin
          module C
            class SuperDuperException < Exception
            end
            begin
              raise SuperDuperException, "Error in Module C"
            rescue SuperDuperException => e
              puts e.message
            ensure 
              puts "I got called in ensure in Module C"
            end
          end
          raise C::SuperDuperException, "Error in Class B"
        rescue C::SuperDuperException => e
          puts e.message 
        ensure 
          puts "I got called in ensure in Class B"
        end
      end
      raise B::C::SuperDuperException, "Error in Class A"
    rescue B::C::SuperDuperException => e
      puts e.message
    ensure 
      puts "I got called in ensure in Class A"
    end
  end
  raise A::B::C::SuperDuperException, "Error in <main>"
rescue A::B::C::SuperDuperException => e
  puts e.message
ensure 
  puts "I got called in ensure in <main>"
end
