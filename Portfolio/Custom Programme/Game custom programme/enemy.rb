class Enemy
  SPEED = 5
  attr_reader :x, :y, :edge
  def initialize(window)
    @edge = 10
    @x = rand(window.width - 3 * @edge) + @edge
    @y = 0
    @opponent = Gosu::Image.new('images/enemy.png')
    @window = window
  end
  def draw
    @opponent.draw(@x - @edge, @y - @edge, 1)
  end

  def move
    @y += SPEED
  end
end
