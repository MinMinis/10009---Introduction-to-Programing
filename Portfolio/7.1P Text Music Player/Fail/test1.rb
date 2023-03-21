require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xD6D6D6D6)
BOTTOM_COLOR = Gosu::Color.new(0x57575700)
WIDTH = 900
HEIGHT = 600
X_COR = 400

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
	attr_accessor :name, :location, :dimen

	def initialize(name, location, dimen)
		@name = name
		@location = location
		@track_dimension = dimen
	end
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
# Put your record definitions here

class MusicPlayerMain < Gosu::Window

	def initialize
	    super WIDTH, HEIGHT
	    self.caption = "Music Player"
		@track_font = Gosu::Font.new(30)
		@album = read_album()
		@track_playing = 0
		playtrack(@track_playing, @album)
		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
	end
def read_track(a_file, i)
		track_name = a_file.gets.chomp
		track_location = a_file.gets.chomp

		leftX = X_COR
		topY = 100 * i + 50
		rightX = leftX + @track_font.text_width(track_name)
		bottomY = topY + @track_font.height()
		dimen = Dimension.new(leftX, topY, rightX, bottomY)
		track = Track.new(track_name, track_location, dimen)
		return track
end
  # Put in your code here to load albums and tracks
	def read_tracks(a_file)
		count = a_file.gets.chomp.to_i
		tracks = []
		i = 0
		while i < count
			track = read_track(a_file, i)
			tracks << track
			i += 1
		end
		return tracks
	end

def read_album()
	a_file = File.new("input.txt", "r")
	title = a_file.gets.chomp
	artist = a_file.gets.chomp
	artwork = ArtWork.new(a_file.gets.chomp)
	tracks = read_tracks(a_file)
	album = Album.new(title, artist, artwork.bmp, tracks)
	a_file.close()
	return album
end
  # Draws the artwork on the screen for all the albums

  def draw_albums albums
    # complete this code
	@album.artwork.draw(50, 50, z = ZOrder::PLAYER, 0.3, 0.3)
	@album.tracks.each do |track|
	display_track(track)
	end
  end

def draw_current_playing(i)
	draw_rect(@album.tracks[i].dimen.leftX - 10, @album.tracks[i].dimen.topY, 5, @track_font.height(), Gosu::Color::RED, z = ZOrder::PLAYER)
end

  # Detects if a 'mouse sensitive' area has been clicked on
  # i.e either an album or a track. returns true or false

  def area_clicked(leftX, topY, rightX, bottomY)
     # complete this code
	if mouse_x > leftX && mouse_x < rightX && mouse_y > topY && mouse_y < bottomY
		return true
	end
	return false
  end


  # Takes a String title and an Integer ypos
  # You may want to use the following:
  def display_track(track)
  	@track_font.draw(title, X_COR, track.dimen.topY, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::WHITE)
  end


  # Takes a track index and an Album and plays the Track from the Album

  def playtrack(track, album)
  	 # complete the missing code
  		@song = Gosu::Song.new(album.tracks[track].location)
  		@song.play(false)
    # Uncomment the following and indent correctly:
  	#	end
  	# end
  end
	def playtrack(track, album)
		@song = Gosu::Song.new(album.tracks[track].location)
		@song.play(false)
	end
# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR

	def draw_background
		draw_quad(0,0, TOP_COLOR, 0, HEIGHT, TOP_COLOR, WIDTH, 0, BOTTOM_COLOR, WIDTH, HEIGHT, BOTTOM_COLOR, z = ZOrder::BACKGROUND)
	end

# Not used? Everything depends on mouse actions.

	def update
		if not @song.playing?
		@track_playing = (@track_playing + 1) % @album.tracks.length()
		playtrack(@track_playing, @album)
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
			for i in 0...@album.tracks.length()
		    	if area_clicked(@album.tracks[i].dimen.leftX, @album.tracks[i].dimen.topY, @album.tracks[i].dimen.rightX, @album.tracks[i].dimen.bottomY)
		    		playtrack(i, @album)
		    		@track_playing = i
		    		break
		    	end
		    end
	    end
	end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0
