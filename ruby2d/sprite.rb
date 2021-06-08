require 'ruby2d'

set title: "Sprite animation", 
  width: 720, 
  height: 480, 
  resizable: true, 
  background: "white"

sprite_path = "/home/abhishek/Documents/sprites/clock.png"
sprite_width = 240
sprite_height = 240
center_x = (Window.width / 2) - sprite_width / 2 
center_y = (Window.height / 2) - sprite_height / 2 
clip_width = 60
animation_time = 90

sprite = Sprite.new(
  sprite_path,
  x: center_x, y: center_y,
  clip_width: clip_width,
  width: sprite_width, height: sprite_height,
  time: animation_time,
  loop: true,
  color: [1.0, 1.0, 1.0, 1.0] 
)

sprite.play

#tick = 0
#update do
#  if tick == 120
#    sprite.stop
#    close
#  end
#  tick += 1
#end

# Play once
#sprite = Sprite.new(
#  sprite_path,
#  x: center_x, y: center_y,
#  clip_width: clip_width,
#  width: sprite_width, height: sprite_height,
#  time: 30,
#  # loop: true, -> do not loop
#  color: "red"
#)
#
#sprite.play do
# puts "Animation finished" 
# close
#end

show
