
class Ship2
  SPEED = 15
  BOUNCE = 30
  attr_reader :x, :y, :edge, :rotate
  def initialize(window)
    @x = 118
    @y = 800/2
    @rotate = 20
    @edge = 20
    @window = window
    @rotate = 3
    BOUNCE
    @ship1 = Gosu::Image.new('images/ship2_select.png')


  end

  def draw
    @ship1.draw_rot(@x , @y , 1, 0)
  end

  def go_up
    if @y > 60
      @y -= SPEED
    elsif @y <= 60
      @y += BOUNCE
    end
  end

  def go_down
    if @y < 740
      @y += SPEED
    elsif @y >= 740
      @y -= BOUNCE
    end
  end

  def go_right
    if @x < 1430
      @x += SPEED
    elsif @x >= 1430
      @x -= BOUNCE
    end
  end

  def go_left
    if @x > 60
      @x -= SPEED
    elsif @x <= 60
      @x += BOUNCE
    end
  end
end

