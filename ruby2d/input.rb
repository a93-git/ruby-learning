require 'ruby2d'

set title: "Input events", width: 640, height: 480, background: "white", resizable: true

s = Square.new(
  x: 0, y: 0,
  size: 25, 
  color: "red", z: 10)

on :mouse do |event|
  s.x = event.x 
  s.y = event.y 
end

on :mouse_down do |event|
  case event.button
  when :left
    puts event.x.to_s + ", " + event.y.to_s
    Square.new(
      x: event.x, y: event.y,
      size: s.size,
      color: s.color, z: s.z)
  when :right
    puts event.methods.sort
  when :middle
    s.color = 'random'
  end
end

show
