require 'gosu'
#require 'rubygems'
require_relative 'credit'

module ZOrder
  HIDDEN, BACKGROUND, MIDDLE, TOP = *0..3
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp
	def initialize(file, leftX, topY)
		@bmp = Gosu::Image.new(file)
	end
end

class Album
	attr_accessor :title, :artist, :artwork, :tracks
	def initialize (title, artist, artwork, tracks)
		@title = title
		@artist = artist
		@artwork = artwork
		@tracks = tracks
	end
end

class Track
	attr_accessor :name, :location
	def initialize(name, location)
		@name = name
		@location = location
	end
end

class Playlist
	attr_accessor :name, :location
	def initialize(name, location)
		@name = name
		@location = location
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
    #------------import end music --------------------------------
    @end_music = Gosu::Song.new('musics/end_music.mp3')
    #----------- menu 1 --------------------------------
    @menu1 = ZOrder::HIDDEN; @menu1_active = Gosu::Color::BLACK
    #----------- menu 2 --------------------------------
    @menu2 = ZOrder::HIDDEN; @menu2_active = Gosu::Color::BLACK
    #----------- menu 3 --------------------------------
    @menu3 = ZOrder::HIDDEN; @menu3_active = Gosu::Color::BLACK
    #----------- menu 4 --------------------------------
    @menu4 = ZOrder::HIDDEN; @menu4_active = Gosu::Color::BLACK
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
    #----------draw background--------------------------------
    @background_image.draw(0, 0, z = ZOrder::BACKGROUND)
    #----------draw title--------------------------------
    @title.draw_text("FLYING CLOUD", HEIGHT/2.2, 10, z = ZOrder::TOP, 1, 1, Gosu::Color::BLACK)
    #----------draw title--------------------------------
    @description.draw_text("Coder: Pandora cutie \nInspired by many DJ\nThe programme is made from ruby\nMusic name: Phong Da Hanh remix \n\n\n\n\n\n\n\n\n Press Enter to continue
      ", HEIGHT/2.2, 100, z = ZOrder::TOP, 1, 1, Gosu::Color::BLACK)
    #----------play start music-------------------------------
    @start_music.play(false)
  end

  def draw_playing
    #----------draw background---------
    @background_playing = draw_quad(0,0, COLOR, 0, HEIGHT, COLOR, WIDTH, 0, COLOR, WIDTH, HEIGHT, COLOR, z = ZOrder::BACKGROUND)
    #----------draw background title using image---------
    @background_title.draw(242,-122, 2, 1,z = ZOrder::MIDDLE)

    #----------draw title---------
    @title.draw_text("Album", HEIGHT/1.6, 10, z = ZOrder::TOP, 1, 1, Gosu::Color::BLACK)

    #----------draw exit description---------
    @description.draw_text("Exit", 735, 483, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    #----------draw exit button--------------------------------
    Gosu.draw_rect(730, 470, 50, 50, @bg_button, ZOrder::BACKGROUND, mode=:default)

    Gosu.draw_rect(730, 470, 50, 50, @bg_button, ZOrder::MIDDLE, mode=:default)
        # Draw the mouse_x position
        @info_font.draw_text("mouse_x: #{mouse_x}", 10 , HEIGHT - 20, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)
        # Draw the mouse_y position
        @info_font.draw_text("mouse_y: #{mouse_y}", 120, HEIGHT - 20, ZOrder::TOP, 1.0, 1.0, Gosu::Color::BLACK)

    #------------ draw menu 1 button ------------
    Gosu.draw_rect(2, 150, 100, 50, @menu1_active, ZOrder::MIDDLE, mode=:default)
    @description.draw_text("Abum 1", 12, 162, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    #------------ draw menu 1 background ------------
    @menu_1 = draw_quad(400,400, Gosu::Color::BLACK, 500, 400, Gosu::Color::BLACK, 500, 600, Gosu::Color::BLACK, 400, 600, Gosu::Color::BLACK, @menu1)
    #------------ draw menu 2 button ------------
    Gosu.draw_rect(2, 205, 100, 50, @menu2_active, ZOrder::MIDDLE, mode=:default)
    @description.draw_text("Abum 2", 12, 217, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    #------------ draw menu 2 background ------------
    @menu_2 = draw_quad(200,200, Gosu::Color::BLACK, 400, 200, Gosu::Color::BLACK, 400, 300, Gosu::Color::BLACK, 200, 300, Gosu::Color::BLACK, @menu2)
    #------------ draw menu 3 button ------------
    Gosu.draw_rect(2, 260, 100, 50, @menu3_active, ZOrder::MIDDLE, mode=:default)
    @description.draw_text("Abum 3", 12, 272, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    #------------ draw menu 3 background ------------
    @menu_3 = draw_quad(200,200, Gosu::Color::BLACK, 400, 200, Gosu::Color::BLACK, 400, 300, Gosu::Color::BLACK, 200, 300, Gosu::Color::BLACK, @menu3)
    #------------ draw menu 4 button ------------
    Gosu.draw_rect(2, 315, 100, 50, @menu4_active, ZOrder::MIDDLE, mode=:default)
    @description.draw_text("Abum 4", 12, 327, z = ZOrder::TOP, 1, 1, Gosu::Color::WHITE)
    #------------ draw menu 4 background ------------
    @menu_4 = draw_quad(200,200, Gosu::Color::BLACK, 400, 200, Gosu::Color::BLACK, 400, 300, Gosu::Color::BLACK, 200, 300, Gosu::Color::BLACK, @menu4)


    #------------- menu 2 --------------------
    #clip_to(70,90,700,360) do
     # Gosu.draw_rect(200, 200, 70, 70, @menu_2, ZOrder::BACKGROUND, mode=:default)
      #  end


  end



  def draw_end
    #----------draw background---------
      #----make it fix, not overflow on other contents-----
      clip_to(70,90,700,360) do
      @credits.each do |credit|
        credit.draw
        end
      end
    draw_line(0,90,Gosu::Color::BLACK,WIDTH,90,Gosu::Color::WHITE)
    @message_font.draw_text(@message,40,40,1,1,1,Gosu::Color::WHITE)
    @message_font.draw_text(@message2,40,75,1,1,1,Gosu::Color::WHITE)
    draw_line(0,450,Gosu::Color::BLACK,WIDTH,450,Gosu::Color::WHITE)
    @message_font.draw_text(@bottom_message, WIDTH / 7, 480 ,1,1,1,Gosu::Color::WHITE)
  end


  #---------- generate while playing --------------------------------
  def initialize_playing
    @scene = :playing
    #while playing
    @start_music.pause()
    @end_music.pause()


  end



  #------------generate the end ------------
  def initialize_end (fate)
    case fate
    when :escape
      @message = "You will exit right away"
    end
    @message_font = Gosu::Font.new(28)
    @bottom_message = "Press P to play the programme again, Press Q to quit"
    @credits  = []
    y = 500
      File.open('text.txt').each do |line|
        @credits.push(Credit.new(self, line.chomp, 200, y))
        y += 30
      end
    @scene = :end
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

    if button_down?(Gosu::MsLeft) && mouse_x > 1 && mouse_x < 103 && mouse_y > 149 && mouse_y < 201 #&& @menu1 = ZOrder::HIDDEN
      @menu1 = ZOrder::TOP; @menu1_active = Gosu::Color::RED
      @menu2 = ZOrder::HIDDEN; @menu2_active = Gosu::Color::BLACK
      @menu3 = ZOrder::HIDDEN; @menu3_active = Gosu::Color::BLACK
      @menu4 = ZOrder::HIDDEN; @menu4_active = Gosu::Color::BLACK
          #------------- menu 2 --------------------
    elsif button_down?(Gosu::MsLeft) && mouse_x > 2 && mouse_x < 103 && mouse_y > 204 && mouse_y < 256 && @menu1 = ZOrder::TOP && @menu2 = ZOrder::HIDDEN
      @menu1 = ZOrder::HIDDEN; @menu1_active = Gosu::Color::BLACK
      @menu2 = ZOrder::TOP; @menu2_active = Gosu::Color::RED
      @menu3 = ZOrder::HIDDEN; @menu3_active = Gosu::Color::BLACK
      @menu4 = ZOrder::HIDDEN; @menu4_active = Gosu::Color::BLACK
          #--------------- menu 3 --------------------
    elsif button_down?(Gosu::MsLeft) && mouse_x > 2 && mouse_x < 103 && mouse_y > 259 && mouse_y < 311 && @menu1 = ZOrder::TOP && @menu3 = ZOrder::HIDDEN
      @menu1 = ZOrder::HIDDEN; @menu1_active = Gosu::Color::BLACK
      @menu2 = ZOrder::HIDDEN; @menu2_active = Gosu::Color::BLACK
      @menu3 = ZOrder::TOP; @menu3_active = Gosu::Color::RED
      @menu4 = ZOrder::HIDDEN; @menu4_active = Gosu::Color::BLACK
          #----------- menu 4 --------------------------------
    elsif button_down?(Gosu::MsLeft) && mouse_x > 2 && mouse_x < 103 && mouse_y > 314 && mouse_y < 366 && @menu1 = ZOrder::TOP && @menu4 = ZOrder::HIDDEN
      @menu1 = ZOrder::HIDDEN; @menu1_active = Gosu::Color::BLACK
      @menu2 = ZOrder::HIDDEN; @menu2_active = Gosu::Color::BLACK
      @menu3 = ZOrder::HIDDEN; @menu3_active = Gosu::Color::BLACK
      @menu4 = ZOrder::TOP; @menu4_active = Gosu::Color::RED
    #else
      #@menu1 = ZOrder::HIDDEN
    end

      #------ exit when click exit button --------------------------------
      if button_down?(Gosu::MsLeft) && mouse_x > 730 && mouse_x < 780 && mouse_y > 470 && mouse_y < 520
      initialize_end(:escape)
      end
  end

  def update_end
#------ generate the end scene  --------------------------------
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
