SPEED = 5
HEIGHT = 800
WIDTH = 600
ROTATION_SPEED = 3
ACCELERATION = 2
FRICTION = 0.9

class Player
  attr_reader :x, :y, :angle , :radius
  def initialize(window)
    @x = HEIGHT/2
    @y = WIDTH - 50
    @angle = 0
    @image = Gosu::Image.new('images/space1.png')
    @velocity_x = 0
    @velocity_y = 0
    @radius = 20
    @window = window

  end

  def draw
    @image.draw_rot(@x, @y,1,  @angle)
  end

  def turn_right
    @x += 10
  end

  def turn_left
    @x -= 10

  end

  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION
    if @x < @radius
      @velocity_x = 0
      @x = @radius + 20
    end
    if @x > @window.width - @radius
      @velocity_x = 0
      @x = @window.width - @radius - 30
    end
  end
end
