class Explosion
  attr_reader :finished
  def initialize (window, x, y)
    @x = x
    @y = y
    @radius = 30
    @image = Gosu::Image.new('images/explosion.png')
    @image_index = 0
    @finished = false
  end

  def draw
    if @image_index < @image.count
      @images[@image_index].draw(@x - @radius, @y - @radius, 2)
      @image_index += 1
    else
      @finished = true
    end
  end
end
