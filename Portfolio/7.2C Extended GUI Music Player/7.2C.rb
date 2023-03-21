require 'rubygems'
require 'gosu'

COLOR_TOP = Gosu::Color.new(0xFF555555)
COLOR_BOTTOM = Gosu::Color.new(0xFF000000)
WIDTH = 600
HEIGHT = 500
CURSOR = 400

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp
	def initialize (file)
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
	attr_accessor :name, :location, :d
	def initialize(name, location, d)
		@name = name
		@location = location
		@d = d
	end
end

class Dimension
	attr_accessor :left_of_x, :top_of_y, :right_of_x, :bottom_of_y
	def initialize(left_of_x, top_of_y, right_of_x, bottom_of_y)
		@left_of_x = left_of_x
		@top_of_y = top_of_y
		@right_of_x = right_of_x
		@bottom_of_y = bottom_of_y
	end
end

# Put your record definitions here

class MusicPlayer < Gosu::Window

	def initialize
		super WIDTH, HEIGHT
		self.caption = "Music Player"
		@track_font = Gosu::Font.new(20)
   	@track_playing = 0
	  @album = read_album()
		playTrack(@track_playing, @album)
		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
	end

  # Put in your code here to load albums and tracks

  	def read_tracks(a_file)
		count = a_file.gets.chomp.to_i
		tracks = []
		j = 0
		while j < count
			track = read_track(a_file, j)
			tracks << track
			j += 1
		end
		return tracks
	end

	def read_track(a_file, index)
		track_name = a_file.gets.chomp
		track_location = a_file.gets.chomp
		left_of_x = CURSOR
		top_of_y = 100 * index + 100
		right_of_x = left_of_x + @track_font.text_width(track_name)
		bottom_of_y = top_of_y + @track_font.height()
		d = Dimension.new(left_of_x, top_of_y, right_of_x, bottom_of_y)
		track = Track.new(track_name, track_location, d)
		return track
	end


  # Draws the artwork on the screen for all the albums

  def draw_albums albums
    # complete this code
	#edit the image of the album
		@album.artwork.draw(50, 100 , z = ZOrder::PLAYER, 0.25, 0.25)
	#small loop
		@album.tracks.each do |track|
			display_track(track)
		end
  end

	def read_album()
		a_file = File.new("album.txt", "r")
		title = a_file.gets.chomp
		artist = a_file.gets.chomp
		artwork = ArtWork.new(a_file.gets.chomp)
		tracks = read_tracks(a_file)
		album = Album.new(title, artist, artwork.bmp, tracks)
		a_file.close()
		return album
	end

	def draw_current_playing(index)
		#to edit the current playing track tab bar far away from the current track
		draw_rect(@album.tracks[index].d.left_of_x - 15, @album.tracks[index].d.top_of_y, 10, @track_font.height(), Gosu::Color::RED, z = ZOrder::PLAYER)
  end

  	def display_track(track)
		#to edit the font of the tracks
			@track_font.draw(track.name, CURSOR, track.d.top_of_y, ZOrder::PLAYER, 1, 1, Gosu::Color::WHITE)
		end
  # Detects if a 'mouse sensitive' area has been clicked on
  # j.e either an album or a track. returns true or false

  def area_clicked(left_of_x, top_of_y, right_of_x, bottom_of_y)
     # complete this code
	 if mouse_x > left_of_x && mouse_x < right_of_x && mouse_y > top_of_y && mouse_y < bottom_of_y
		return true
	end
	return false
  end


  # Takes a track index and an Album and plays the Track from the Album

  def playTrack(track, album)
  			@song = Gosu::Song.new(album.tracks[track].location)
  			@song.play(false)
    # Uncomment the following and indent correctly:
  	#	end
  	# end
  end

# Draw a coloured background using COLOR_TOP and COLOR_BOTTOM

	def draw_background
		#draw the background
		draw_quad(0,0, COLOR_TOP, 0, HEIGHT, COLOR_TOP, WIDTH, 0, COLOR_BOTTOM, WIDTH, HEIGHT, COLOR_BOTTOM, z = ZOrder::BACKGROUND)
	end

# Not used? Everything depends on mouse actions.

	def update
		if not @song.playing?
			@track_playing = @track_playing
			playTrack(@track_playing, @album)
		end
	end

 # Draws the album images and the track list for the selected album

	def draw
		# Complete the missing code
		draw_background()
		draw_albums(@album)
		draw_current_playing(@track_playing)
	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
	    when Gosu::MsLeft
	    	# What should happen here?
	    	for j in 0...@album.tracks.length()
		    	if area_clicked(@album.tracks[j].d.left_of_x, @album.tracks[j].d.top_of_y, @album.tracks[j].d.right_of_x, @album.tracks[j].d.bottom_of_y)
		    		playTrack(j, @album)
		    		@track_playing = j
		    		break
		    	end
		    end
	    end
	end

end

# Show is a method that loops through update and draw

MusicPlayer.new.show if __FILE__ == $0
