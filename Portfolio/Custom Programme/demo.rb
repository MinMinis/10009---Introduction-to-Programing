require 'gosu'
require 'rubygems'

class Star
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff_000000)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * 640
    @y = rand * 480
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::Stars, 1, 1, @color, :add)
  end
end
if rand(100) < 4 and @stars.size < 25 then
  @stars.push(Star.new(@star_anim))
end

class GameWindow < Gosu::Window
    def initialize
        super 640,480,false
        self.caption = "Spaceship"
        @background_image = Gosu::Image.new("media/space.png")

        @player = Player.new
        @player.warp(320, 240)

        @star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)

        @stars = Array.new

        @font = Gosu::Font.new(20)
    end

    def update
        if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then @player.turn_left end
        if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then @player.turn_right end
        if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then @player.accelerate end
        @player.move
        @player.collect_stars(@stars)

        if rand(100) < 4 and @stars.size < 25 then
            @stars.push(Star.new(@star_anim))
        end
    end

    def draw
        @player.draw
        @background_image.draw(0,0,0)
        @stars.each{ |star| star.draw}
        @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end

window = GameWindow.new
window.show
