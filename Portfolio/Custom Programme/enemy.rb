

ENEMY_FREQUENCY = 0.05


class Enemy
  SPEED = 2
  attr_reader :x, :y, :radius
  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/enemy.png')
    @window = window
  end
  def draw
    @image.draw(@x - @radius, @y - @radius, 1, 1)
  end

  def move
    @y += SPEED
  end
end
