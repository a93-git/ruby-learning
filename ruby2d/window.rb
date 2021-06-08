require 'ruby2d'

set title: "Main Window", background: "blue", width: 720, height: 480, resizable: true

fps = get :fps
mx = get :mouse_x
my = get :mouse_y

tick = 0

puts fps.to_s + " FPS, " + mx.to_s + ", " + my.to_s
update do
  if tick % 60 == 0
    set background: "random"
  end
  tick += 1
end

show

