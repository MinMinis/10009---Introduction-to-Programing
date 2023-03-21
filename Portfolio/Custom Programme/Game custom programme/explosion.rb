class Explosion
  attr_reader :done
  def initialize(window, x, y)
    @x = x
    @y = y
    @radius = 40
    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
    @index = 0
    @done = false

  end

  def draw
    if @index < @images.count
      @images[@index].draw(@x - @radius, @y - @radius, 2)
      @index += 1
    else
      @done = true
    end
  end

end
