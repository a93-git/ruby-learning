# An infinite loop where the control is yielded back to the code block infinitely
# and it is the job of the code block to implement the exit condtion

def my_loop
  yield while true
end

c = 0

my_loop do
  print c.to_s + ", "
  c += 1
  next unless c == 10
  break
end


