# Explicitly raising error with an Exception object and a message
def a(x)
  raise ArgumentError, "Number less than 10" if x < 10
end

a(5)

