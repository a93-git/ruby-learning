class A
  class B
    def a
      begin
        raise ArgumentError, "WTF is this?"
      rescue ArgumentError => e
        puts e.message
        puts e.backtrace
      end
    end
  end
  obj = A::B.new
  obj.a()
end

