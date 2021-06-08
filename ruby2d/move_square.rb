require 'ruby2d'

set title: "Move Square", background: "blue", width: 720, height: 480, resizable: true

@square = Square.new(x: 10, y: 20, size: 25, color: "red")

@x_speed = 0
@y_speed = 0

on :key_down do |event|
  if event.key == 'j'
    @x_speed = -2
    @y_speed = 0
  elsif event.key == 'l'
    @x_speed = 2
    @y_speed = 0
  elsif event.key == 'i'
    @x_speed = 0
    @y_speed = -2
  elsif event.key == 'k'
    @x_speed = 0
    @y_speed = 2
  end
end

update do
  @square.x += @x_speed
  @square.y += @y_speed
end

show

