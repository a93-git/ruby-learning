require 'ruby2d'

set title: "Show image", width: 720, height: 480, background: "black", resizable: true

image_path = "/home/abhishek/Downloads/reflection.jpg"
image = Image.new(
  image_path,
  x: 0, y: 0,
  width: 720, height: 480,
  color: [1.0, 1.0, 1.0, 1.0],
  rotate: 0, z: 10)


show
