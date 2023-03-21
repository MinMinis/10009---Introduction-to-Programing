require 'gosu'

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

SCREEN_SIZE = 600

LIGHT_ON_IMG = 'on_med.png'
LIGHT_OFF_IMG = 'off_med.png'

LIGHT_SML_ON_IMG = 'on_sml.png'
LIGHT_SML_OFF_IMG = 'off_sml.png'

LIGHT_LAR_ON_IMG = 'on.png'
LIGHT_LAR_OFF_IMG = 'off.png'

class Lights < Gosu::Window

  def initialize
      super SCREEN_SIZE, SCREEN_SIZE
      self.caption = "Lights Demo"

      @on = Gosu::Image.new("./images/" + LIGHT_LAR_ON_IMG)
      @off = Gosu::Image.new("./images/" + LIGHT_LAR_OFF_IMG)
  end

  def update
	end

	def draw
    @on.draw(50, 75, ZOrder::PLAYER)
	end

 	def needs_cursor?; true; end


	def button_down(id); end


end

Lights.new.show if __FILE__ == $0
