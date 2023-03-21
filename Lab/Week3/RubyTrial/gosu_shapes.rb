require 'rubygems'
require 'gosu'
require_relative 'circle'

# The screen has layers: Background, middle, top
module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

class DemoWindow < Gosu::Window
  def initialize
    super(800, 600, false)
  end

  def draw
    # see www.rubydoc.info/github/gosu/gosu/Gosu/Color for colours
    draw_quad(0, 0, 0xff_ffffff, 800, 0, 0xff_ffffff, 0, 600, 0xff_ffffff, 800, 600, 0xff_ffffff, ZOrder::BACKGROUND)
    
   
    
    # draw_rect works a bit differently:
    

    # Circle parameter - Radius
    img2 = Gosu::Image.new(Circle.new(50))
    # Image draw parameters - x, y, z, horizontal scale (use for ovals), vertical scale (use for ovals), colour
    # Colour - use Gosu::Image::{Colour name} or .rgb({red},{green},{blue}) or .rgba({alpha}{red},{green},{blue},)
    # Note - alpha is used for transparency.
    # drawn as an elipse (0.5 width:)

    # drawn as a red circle:
    img2.draw(0, 450, ZOrder::TOP, 8.0, 3.0, 0xff_ff0000)
    # drawn as a red circle with transparency:
    
    Gosu.draw_rect(300, 350, 200, 200, 0xff_808080, ZOrder::TOP, mode=:default)
    draw_triangle(250, 350, Gosu::Color::GREEN, 550, 350, Gosu::Color::GREEN, 400, 200, Gosu::Color::GREEN, ZOrder::TOP, mode=:default)
  end
end

DemoWindow.new.show
