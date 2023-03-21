require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end
class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@track_name = name
		@track_location = location
	end
end

class Album
	attr_accessor :title, :artist, :genre, :tracks

	def initialize (title, artist, genre, tracks)
		@title = title
		@artist = artist
		@genre = genre
		@tracks = tracks
	end
end


# Put your record definitions here
class MusicPlayerMain < Gosu::Window

	def initialize
	    super 600, 800
	    self.caption = "Music Player"
			@background =
			@player
			@music
			@title

			@play = Gosu::Image.new("play.png")
			@next = Gosu::Image.new("next.png")
			@pause = Gosu::Image.new("pause.png")

			@album_img1 = Gosu::Image.new(".png")
			@album_img2 = Gosu::Image.new(".png")
      @album_img3 = Gosu::Image.new(".png")
			@album_selection = "album1.txt"
			@index = 0
	end

		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
    #read file from terminal
	end

	def read_track(music_file)
	  track_name = music_file.gets().strip
    track_location = music_file.gets().strip
	  track = Track.new(track_name, track_location)
    return track
  end

	def read_tracks(music_file)
	  tracks = Array.new()
	  i = 0
		count = music_file.gets.to_i
    while (i < count)
    	track = read_track(music_file)
    	tracks << track
    	i += 1
    end
    return tracks
  end


  # Put in your code here to load albums and tracks
  def read_album(music_file)
    album_title = music_file.gets.chomp
    album_artist = music_file.gets.chomp
    album_genre = music_file.gets.chomp.to_i
    albums_tracks = read_tracks(music_file)
    album = Album.new(album_title, album_artist, album_genre, album_tracks)
	end

	def read_albums (music_file)
    albums = Array.new()
    count = music_file.gets()
	  i = 0
    while (i < count.to_i)
    album = read_album(i,music_file)
    albums << album
    i += 1
    end
    albums
  end

  def read_in_albums
  	music_file = File.new("album.txt","r")
    albums = read_albums(music_file)
    albums
  end
		# Draws the artwork on the screen for all the albums

  def draw_albums (albums)
    # complete this code
		@album_img1.draw(10,10,ZOrder::UI)

    if @choice > -1
      i = 0
      pY = 50
      while i < 15
      display_track(@albums[@choice].tracks[i].tname,pY)
      i += 1
      pY += 30
      end
    end
  end


  # Detects if a 'mouse sensitive' area has been clicked on
  # i.e either an album or a track. returns true or false

  def area_clicked(leftX, topY, rightX, bottomY)
     # complete this code
		 x1 = mouse_x
		 y1 = mouse_y
		 tx = leftX + rightX
		 ty = topY + bottomY

		 if (x1 >= leftX) and (x1 <= rightX) and (y1 >= topY) and (y1 <= ty)
				true
		 else
			 false
		 end

  end


  # Takes a String title and an Integer ypos
  # You may want to use the following:
  def display_track(title, ypos)
  	@track_font.draw(title, TrackLeftX, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
  end


  # Takes a track index and an Album and plays the Track from the Album

  def playTrack(track, album)
  	 # complete the missing code
  			@song = Gosu::Song.new(album.tracks[track].location)
  			@song.play(false)
    # Uncomment the following and indent correctly:
  	#	end
  	# end
  end

# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR

	def draw_background
		Gosu.draw_rect(0, 0, 1200, 800, @background, ZOrder::BACKGROUND, mode=:default)
	end

# Not used? Everything depends on mouse actions.

	def update
	end

 # Draws the album images and the track list for the selected album

	def draw
		# Complete the missing code
		draw_background
		draw_albums
    if @playingsong > -1
    @info_font.draw("Playing...#{@albums[@choice].tracks[@playingsong].tname}", 630, 550, ZOrder::UI, 1.0, 1.0, Gosu::Color::RED)

	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
	    when Gosu::MsLeft
	    	# What should happen here?
				if area_clicked(10,10,298,289)
					@choice = 0
					@background = Gosu::Color.new(0xFF1EB1FA)
	    end
	end
end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0
