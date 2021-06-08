require 'ruby2d'

set title: "Colors window", width: 720, height: 480, background: "black", resizable: true

t = Triangle.new(color: "blue",
                 x1: 45, y1: 24,
                 x2: 88, y2: 80, 
                 x3: 13, y3: 79,
                 z: 5)

s = Square.new(x: 200, y: 200, 
               size: 75,
               color: "white",
               z: 10)

q = Quad.new(
  x1: 120, y1: 156,
  x2: 90, y2: 110,
  x3: 38, y3: 126,
  x4: 42, y4: 170,
  color: "teal",
  z: 10)

r = Rectangle.new(
  x: 450, y: 320, 
  width: 200, height: 120, 
  color: "green", 
  z: 40)

l = Line.new(
  x1: 300, y1: 64,
  x2: 350, y2: 100,
  color: "red", 
  z: 10)

c = Circle.new(
  x: 500, y: 300, 
  radius: 150, sectors: 1024, 
  color: "fuchsia", 
  z: 10)

show
