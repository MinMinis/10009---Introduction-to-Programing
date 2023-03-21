require 'gosu'
require 'rubygems'
#require 'credit'
require_relative 'player1'

module ZOrder
  HIDDEN, BACKGROUND, SCENE, UI, TOP = *0..4
end

class MyGame < Gosu::Window
  HEIGHT = 800
  WIDTH = 1500
 def initialize()
  super(WIDTH,HEIGHT,false)
  self.caption = "Spaceship Hunter"
  @player = Player.new(self)
  #--------------- start point --------------------
  @scene = :start
  @start_music = Gosu::Song.new('musics/start.wav')
  @start_background = Gosu::Image.new('images/start.jpg')
  @title = Gosu::Font.new(50)
  @start_options = Gosu::Font.new(35)
  @info_font = Gosu::Font.new(15)
  @hover_options_1 = ZOrder::HIDDEN; @hover_options_2 = ZOrder::HIDDEN; @hover_options_3 = ZOrder::HIDDEN
  @error_music = Gosu::Song.new('musics/error.wav')
  @start_play_music = Gosu::Song.new('musics/start_play.wav')
  @point = Gosu::Image.new('images/pointing.png')
  #-------------- instruction -------------------------
  @instruction_background = Gosu::Image.new('images/instruction.jpg')
  @instruction_music = Gosu::Song.new('musics/instruction.wav')
  @description = Gosu::Font.new(30)
  #--------------- selecting -------------------------
  @selecting_music = Gosu::Song.new('musics/selecting.wav')
  @select_char_1 = ZOrder::HIDDEN; @select_char_2 = ZOrder::HIDDEN
  @select_color = 0xFF555555
  @ship1_sel = Gosu::Image.new('images/ship1_select.png')
  @ship2_sel = Gosu::Image.new('images/ship2_select.png')

 end

 def draw
  case @scene
    when :start
      draw_start
    when :instruction
      draw_instruction
    when :selecting
      draw_selecting
    when :playing
      draw_playing
    when :end
      draw_end
    end
  end

  def draw_start
    @start_background.draw(0, 0, z = ZOrder::BACKGROUND)
    @start_music.play(false)
    @start_music.volume()
    @title.draw_text("Spaceship hunter", 650, 50, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    @start_options.draw_text("Play \n\n\nInstructions \n\n\nExit
      ", 500, 300, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)

    @point.draw(355,305,1, @hover_options_1)
    @point.draw(355,410,1, @hover_options_2)
    @point.draw(355,510,1, @hover_options_3)

    draw_quad(490,295, Gosu::Color::BLACK, 750, 295, Gosu::Color::BLACK, 750, 340, Gosu::Color::BLACK, 490, 340, Gosu::Color::BLACK, @hover_options_1)
    draw_quad(490,400, Gosu::Color::BLACK, 750, 400, Gosu::Color::BLACK, 750, 445, Gosu::Color::BLACK, 490, 445, Gosu::Color::BLACK, @hover_options_2)
    draw_quad(490,505, Gosu::Color::BLACK, 750, 505, Gosu::Color::BLACK, 750, 550, Gosu::Color::BLACK, 490, 550, Gosu::Color::BLACK, @hover_options_3)

  end

  def draw_instruction
    @instruction_background.draw(0,0, ZOrder::BACKGROUND)
    @title.draw_text("          INSTRUCTION\n Created by Thanh Minh \n\n How to Play", 500, 50, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    @description.draw_text("Use keyboard to control:\n- ↑ or W to move up\n- ↓ or S to move down\n- → or D to move right\n- ← or A to move left\n- Space to Attack\n\n*REMEMBER: To avoid the enemy
      \nPress Q or Space to be back to the Menu",500,300, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
  end

  def draw_selecting
    @selecting_music.play(false)
    @title.draw_text("Selecting Your Player
      ", 550,50, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)

      draw_quad(0,0, Gosu::Color::BLACK, WIDTH, 0, Gosu::Color::BLACK, WIDTH, HEIGHT, Gosu::Color::BLACK, 0, HEIGHT, Gosu::Color::BLACK, ZOrder::BACKGROUND)
      draw_quad(0,0, @select_color, WIDTH/2, 0, @select_color, WIDTH/2, 1500, @select_color, 0, 1500, @select_color, @select_char_1)
      draw_quad(WIDTH/2,0, @select_color, WIDTH, 0, @select_color, WIDTH, HEIGHT, @select_color, WIDTH/2, HEIGHT, @select_color, @select_char_2)

      @title.draw_text("Chaos Eater
        ", 250,300, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
      @title.draw_text("Ship Eater
        ", 1050,300, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
      @player.draw_select

    end

  def draw_playing

  end

  def draw_end

  end

  def update

  end

  def initialize_start
    @scene = :start

  end

  def initialize_instruction
    sleep(0.5)
    @scene = :instruction
    @instruction_music.play(false)
  end

  def initialize_selecting
    @scene = :selecting
  end

  def initialize_playing
    @scene = :playing


  end

  def initialize_end
    @scene = :end

  end

  def update
    case @scene
    when :start
      update_start
    when :instruction
      update_instruction
    when :selecting
      update_selecting
    when :playing
      update_playing
    when :end
      update_end
    end
  end

  def update_start
    if (mouse_x > 489 && mouse_x < 756 && mouse_y > 294 && mouse_y < 341) or (button_down?(Gosu::KbUp) && @hover_options_2 == ZOrder::UI)
      @hover_options_1 = ZOrder::UI
      @hover_options_2 = ZOrder::HIDDEN
      @hover_options_3 = ZOrder::HIDDEN
    elsif (mouse_x > 489 && mouse_x < 756 && mouse_y > 399 && mouse_y < 446) or (button_down?(Gosu::KbUp) && @hover_options_3 == ZOrder::UI) or (button_down?(Gosu::KbDown) && @hover_options_1 == ZOrder::UI)
      @hover_options_1 = ZOrder::HIDDEN
      @hover_options_2 = ZOrder::UI
      @hover_options_3 = ZOrder::HIDDEN
      sleep(0.15)
    elsif (mouse_x > 489 && mouse_x < 756 && mouse_y > 504 && mouse_y < 556) or (button_down?(Gosu::KbDown) && @hover_options_2 == ZOrder::UI)
      @hover_options_1 = ZOrder::HIDDEN
      @hover_options_2 = ZOrder::HIDDEN
      @hover_options_3 = ZOrder::UI
    elsif (button_down?(Gosu::KbDown) && @hover_options_1 == ZOrder::HIDDEN && @hover_options_2 == ZOrder::HIDDEN && @hover_options_3 == ZOrder::HIDDEN)
      @hover_options_1 = ZOrder::UI
      @hover_options_2 = ZOrder::HIDDEN
      @hover_options_3 = ZOrder::HIDDEN
    elsif (button_down?(Gosu::KbUp) && @hover_options_1 == ZOrder::HIDDEN && @hover_options_2 == ZOrder::HIDDEN && @hover_options_3 == ZOrder::HIDDEN)
      @hover_options_1 = ZOrder::HIDDEN
      @hover_options_2 = ZOrder::HIDDEN
      @hover_options_3 = ZOrder::UI
    end

    if (button_down?(Gosu::KbUp) && @hover_options_1 == ZOrder::UI) or (button_down?(Gosu::KbDown) && @hover_options_3 == ZOrder::UI) or button_down?(Gosu::KbLeft) or button_down?(Gosu::KbRight)
      @error_music.play(true)
      sleep(0.05)
    end
  end

  def update_instruction

  end

  def update_selecting
    if mouse_x > 0 && (mouse_x < WIDTH/2) && mouse_y > 0 && mouse_y < 800
      @select_char_1 = ZOrder::BACKGROUND
      @select_char_2 = ZOrder::HIDDEN
    elsif (mouse_x > WIDTH/2) && mouse_x < WIDTH && mouse_y > 0 && mouse_y < 800
      @select_char_1 = ZOrder::HIDDEN
      @select_char_2 = ZOrder::BACKGROUND
    else
      @select_char_1 = ZOrder::HIDDEN
      @select_char_2 = ZOrder::HIDDEN
    end

  end

  def update_playing
  end

  def update_end

  end

  def button_down(id)
    case @scene
    when :start
      button_down_start(id)
    when :instruction
      button_down_instruction(id)
    when :selecting
      button_down_selecting(id)
    when :playing
      button_down_playing(id)
    when :end
      button_down_end(id)
    end
  end


  def button_down_start(id)
    if (button_down?(Gosu::MsLeft) or button_down?(Gosu::KbReturn)) && @hover_options_1 == ZOrder::UI
      initialize_selecting
      @start_play_music.play(false)
      sleep(0.2)
    elsif (button_down?(Gosu::MsLeft) or button_down?(Gosu::KbReturn)) && @hover_options_2 == ZOrder::UI
      initialize_instruction
    elsif (button_down?(Gosu::MsLeft) or button_down?(Gosu::KbReturn)) && @hover_options_3 == ZOrder::UI
      close
    end
  end

  def button_down_instruction(id)
    if button_down?(Gosu::KbQ) or button_down?(Gosu::KbSpace)
      initialize_start
    end
  end

  def button_down_selecting(id)
    if (button_down?(Gosu::KbReturn) or button_down?(Gosu::MsLeft)) && mouse_x > 0 && mouse_x < WIDTH/2 && mouse_y > 0 && mouse_y < HEIGHT && @select_char_1 == ZOrder::BACKGROUND
      initialize_playing
      @ship1_sel = Ship1.new(self)
      @ship = @ship1_sel
    elsif (button_down?(Gosu::KbReturn) or button_down?(Gosu::MsLeft)) && mouse_x > WIDTH/2 && mouse_x < WIDTH && mouse_y > 0 && mouse_y < HEIGHT && @select_char_1 == ZOrder::BACKGROUND
      @ship2_sel = Ship2.new(self)
      @ship = @ship2_sel
    end
  end

  def button_down_playing(id)


    #if id == Gosu::KbEscape or id == Gosu::KbQ
    #  draw_exit_window
    #end
  end

  def button_down_end(id)
  end

end



window = MyGame.new()
window.show()




