class Bullet
  SPEED = 30
  attr_reader :x, :y, :radius
  def initialize(window, x, y, angle)
    @x = x
    @y = y
    @direction = 0
    @image = Gosu::Image.new('images/bullet.png')
    @window = window
    @radius = 3
  end

  def draw
    @image.draw(@x - @radius, @y - @radius,1)
  end

  def move
    @x += Gosu.offset_x(@direction,SPEED)
    @y += Gosu.offset_y(@direction,SPEED)
  end

  def onscreen?
    right = @window.width + @radius
    left = -@radius
    top = -@radius
    bottom = @window.height + @radius
    @x > left && @x < right && @y > top && @y < bottom
  end

end
