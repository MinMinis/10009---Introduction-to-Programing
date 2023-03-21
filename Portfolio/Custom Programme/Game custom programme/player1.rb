class Player
  def initialize(window)
    @x1 = 750/2
    @y1 = 650
    @x2 = 1175
    @y2 = 650
    @window = window
    @ship1 = Gosu::Image.new('images/ship1.png')
    @ship2 = Gosu::Image.new('images/ship2.png')

  end

  def draw_select
    @ship1.draw_rot(@x1 , @y1 , 1, 0)
    @ship2.draw_rot(@x2 , @y2, 1, 0)
  end
end

class Ship1
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
    @ship1 = Gosu::Image.new('images/ship1_select.png')


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

