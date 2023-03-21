class Credit
  SPEED = 3
  attr_reader :y

  def initialize(window, description, x, y)
      @x = x
      @y = @init_y = y
      @description = description
      @font = Gosu::Font.new(30)
  end

  def move
      @y -= SPEED
  end

  def draw
      @font.draw_text(@description, @x, @y, 1)
  end

  def reset
      @y = @init_y
  end
end
