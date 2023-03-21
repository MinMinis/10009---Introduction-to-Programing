require 'gosu'

class Link

  def initialize(animation)
    @animation = animation
    @x = 300
    @y = 300
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x, @y, 1)
  end
end


class GameWindow < Gosu::Window
    def initialize(width=800, height=600, fullscreen=false)
        super
        self.caption = 'Hello Animation'
        @animation = Gosu::Image::load_tiles(self, "images/link.png", 83, 86, false)
        @links = []
   end

    def update
        @links.push(Link.new(@animation))
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end

    def draw
        @links.each {|link| link.draw}
    end
end
window = GameWindow.new
window.show
