require 'gosu'
require 'rubygems'
require_relative 'credit'

module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

class Dimension
	attr_accessor :leftX, :topY, :rightX, :bottomY
	def initialize(leftX, topY, rightX, bottomY)
		@leftX = leftX
		@topY = topY
		@rightX = rightX
		@bottomY = bottomY
	end
end

class MyGame < Gosu::Window
  HEIGHT = 533
  WIDTH = 800
  COLOR = Gosu::Color.new(0xFFFFFFFF)
  X_CORDINATE = 400
  def initialize()
    super(WIDTH, HEIGHT)
    self.caption = 'Music Player'
    #-----import background--------------------------------
    @background_image = Gosu::Image.new('images/background_image.jpg')
    #-----import background title--------------------------------
    @background_title = Gosu::Image.new('images/background_title.jpg')
    #----import title--------------------------------
    @title = Gosu::Font.new(50)
    #-----import description--------------------------------
    @description = Gosu::Font.new(25)
    #----- start point --------------------------------
    @scene = :start
    #--------- import start music --------------------------------
    @start_music = Gosu::Song.new('musics/start_music.mp3')
    #----------- create animation on button  --------------------------------
    @bg_button = Gosu::Color::BLACK
    #----------info cursor --------------------------------
    @info_font = Gosu::Font.new(10)
  end



  def draw
    case @scene
    when :start
      draw_start
    when :playing
      draw_playing
    when :end
      draw_end
    end
  end

  def draw_start
    #----------draw background---------
    @background_image.draw(0, 0, z = ZOrder::BACKGROUND)
    #----------draw title---------
    @title.draw("FLYING CLOUD", HEIGHT/2.2, 10, z = ZOrder::TOP, 1, 1, Gosu::Color::BLACK)
    #----------draw title---------
    @description.draw("Coder: Pandora cutie \nInspired by many DJ\nThe programme is made from ruby\nMusic name: Phong Da Hanh remix \n\n\n\n\n\n\n\n\n Press Enter to continue
      ", HEIGHT/2.2, 100, z = ZOrder::TOP, 1, 1, Gosu::Color::BLACK)
    #----------play start music---------
    @start_music.play(false)
  end

  def draw_playing
    #----------draw background---------
    @background_playing = draw_quad(0,0, COLOR, 0, HEIGHT, COLOR, WIDTH, 0, COLOR, WIDTH, HEIGHT, COLOR, z = ZOrder::BACKGROUND)
    #----------draw background title ---------
    @background_title.draw(240,-40, 2, 1,z = ZOrder::MIDDLE)
    #----------draw title---------
    @title.draw("Album", HEIGHT/1.6, 10, z = ZOrder::TOP, 1, 1, Gosu::Color::BLACK)

    #----------draw exit description---------
    @description.draw("Exit", 735, 483, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    #----------draw exit button--------------------------------
    Gosu.draw_rect(730, 470, 50, 50, @bg_button, ZOrder::BACKGROUND, mode=:default)

    Gosu.draw_rect(730, 470, 50, 50, @bg_button, ZOrder::MIDDLE, mode=:default)
        # Draw the mouse_x position
        @info_font.draw("mouse_x: #{mouse_x}", 0, 350, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        # Draw the mouse_y position
        @info_font.draw("mouse_y: #{mouse_y}", 120, 350, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)


  end



  def draw_end
    #----------draw background---------
    @credits.each do |credit|
      credit.draw
    end
    draw_line(0,140,Gosu::Color::BLACK,WIDTH,140,Gosu::Color::BLACK)
    @message_font.draw(@message,40,40,1,1,1,Gosu::Color::BLACK)
    @message_font.draw(@message2,40,75,1,1,1,Gosu::Color::BLACK)
    draw_line(0,500,Gosu::Color::BLACK,WIDTH,500,Gosu::Color::BLACK)
    @message_font.draw(@bottom_message,180,540,1,1,1,Gosu::Color::BLACK)
  end


  #---------- generate while playing --------------------------------
  def initialize_playing
    @scene = :playing
    #while playing

  end



  #------------generate the end ------------
  def initialize_end (fate)
    case fate
    when :escape
      @message = "You will exit right away"
    when :all_song_played
      @message = "All songs have been played!"
    end
    @message_font = Gosu::Font.new(28)
    @bottom_message = "Press P to play the Programme again, Press P to quit"
    @credits  = []
    y = 500
    File.open('text.txt').each do |line|
      @credits.push(Credit.new(self, line.chomp, 100, y))
      y += 30
    end
    @scene = :end
    @end_music = Gosu::Song.new('musics/end_music.mp3')
    @end_music.play(true)
  end
# ----------------- Update part --------------------------------
  def update
    case @scene
    when :playing
      update_playing
    when :end
      update_end
    end

  end

  def update_playing
=begin
    @album.each do |album|
      initialize_end(:escape) if
      initialize_end(:all_song_played) if
    end
=end
    initialize_end(:escape)
  end

  def update_end
    @credits.each do |credit|
      credit.move
    end
    if @credits.last.y < 150
      @credits.each do |credit|
        credit.reset
      end
    end
  end
  #----------- test part --------------------------------
=begin
  def dimension_click
    leftX = X_CORDINATE
		topY = 100 * 1 + 100
		rightX = leftX + 20
		bottomY = topY + 20
    dimen = Dimension.new(leftX, topY, rightX, bottomY)
  end

  def button_down(id)
		case id
	    when Gosu::MsLeft
	    	for i in 0...5
		    	if area_clicked(@album.tracks[i].dimen.leftX, @album.tracks[i].dimen.topY, @album.tracks[i].dimen.rightX, @album.tracks[i].dimen.bottomY)
		    		playTrack(i, @album)
		    		@track_playing = i
		    		break
		    	end
		    end
	    end
	end

  def needs_cursor?; true; end
=end



#-------- control the area of mouse --------------------------------
  def mouse_over_button(mouse_x, mouse_y)
    if mouse_x.between?(730, 780) && mouse_y.between?(470, 520)
      true
    else
      false
    end
  end

  def needs_cursor?; true; end
# --------------- control the mouse left function --------------------------------
  def mouse(id)
    case id
    when Gosu::MsLeft
      if mouse_over_button(mouse_x, mouse_y)
        true
      else
        false
      end
    end
  end
#--------------------control mouse button hover -------------------------------------------

  #---------- Button down part --------------------------------

  def button_down(id)
    case @scene
    when :start
      button_down_start(id)
    when :playing
      button_down_playing(id)
    when :end
      button_down_end(id)
    end

    case id
    when Gosu::MsLeft
      if mouse_over_button(mouse_x, mouse_y)
        @bg_button = Gosu::Color::RED

      else
        @bg_button = Gosu::Color::BLACK
      end
    end

  end
  def button_down_start(id)
    initialize_playing
  end

  def button_down_playing(id)
    #if id == Gosu::KbSpace
    #  @song_playing = Gosu::Song::paused(unless id == Gosu::KbSpace)
    #end
  end

  def button_down_end(id)
    if id  == Gosu::KbP
      initialize_playing
    elsif id == Gosu::KbQ
      close
     end
  end

end

window = MyGame.new()
window.show()
