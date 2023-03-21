
class Credit
  CREDIT_SPEED = 1
  attr_reader :y

  def initialize(window, text, x, y)
    @y = @initial_y = y
    @x = x
    @font =  Gosu::Font.new(24)
    @text = text
  end

  def move
    @y -= CREDIT_SPEED
  end

  def draw
    @font.draw_text(@text, @x, @y, 1)
  end

  def reset
    @y = @initial_y
  end

end
