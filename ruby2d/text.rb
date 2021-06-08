require 'ruby2d'

set title: "Text", width: 720, height: 480, resizable: true, background: "white"

Text.new("Hello",
        x: 150, y: 70,
        font: "/home/abhishek/Downloads/evil-empire-font/EvilEmpire-4BBVK.ttf",
        size: 40,
        color: "blue",
        rotate: 0,
        z: 10)

show
