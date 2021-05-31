class A
  class << self
    def test_loop(count)
      c = 0
      until c == count
        c += 1
        yield c
      end
    end
  end
end

A.test_loop(5) do |i|
  print i.to_s + " "
end

