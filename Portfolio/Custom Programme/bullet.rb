
class Bullet
BULLET_SPEED = 5
attr_reader :x, :y, :radius
  def initialize(window, x, y, angle)
    @window = window
    @x = x
    @y = y
    @radius = 3
    @direction = angle
    @image = Gosu::Image.new('images/bullet.png')
  end

  def move
    @x += Gosu::offset_x(@direction, BULLET_SPEED)
    @y += Gosu::offset_y(@direction, BULLET_SPEED)
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def onscreen?
    right = @window.width + @radius
    left = -@radius
    top = -@radius
    bottom = @window.height + @radius
    @x > left and @x < right and @y > top and @y < bottom
  end

end
