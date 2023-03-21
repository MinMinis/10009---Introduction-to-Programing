require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xff_555555)
BOTTOM_COLOR = Gosu::Color.new(0xff_000000)
WIDTH = 600
HEIGHT = 500
X_CORDINATE = 400

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp
	def initialize(file)
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
		@dimen = dimen
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


class MusicPlayerMain < Gosu::Window
	def initialize
	  super WIDTH, HEIGHT
	  self.caption = "Music Player"
	  @track_font = Gosu::Font.new(20)
    @track_playing = 0
	  @album = read_album()
		playTrack(@track_playing, @album)
	end


	def read_track(a_file, index)
		track_name = a_file.gets.chomp
		track_location = a_file.gets.chomp
		leftX = X_CORDINATE
		topY = 100 * index + 100
		rightX = leftX + @track_font.text_width(track_name)
		bottomY = topY + @track_font.height()
		dimen = Dimension.new(leftX, topY, rightX, bottomY)
		track = Track.new(track_name, track_location, dimen)
		return track
	end


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
		a_file = File.new("album.txt", "r")
		title = a_file.gets.chomp
		artist = a_file.gets.chomp
		artwork = ArtWork.new(a_file.gets.chomp)
		tracks = read_tracks(a_file)
		album = Album.new(title, artist, artwork.bmp, tracks)
		a_file.close()
		return album
	end

	def draw_albums(albums)
		#edit the image of the album
		@album.artwork.draw(50, 100 , z = ZOrder::PLAYER, 0.25, 0.25)
		#small loop
		@album.tracks.each do |track|
		display_track(track)
		end
	end

	def draw_current_playing(index)
		#to edit the current playing track tab bar far away from the current track
		draw_rect(@album.tracks[index].dimen.leftX - 15, @album.tracks[index].dimen.topY, 10, @track_font.height(), Gosu::Color::RED, z = ZOrder::PLAYER)
  end


	def area_clicked(leftX, topY, rightX, bottomY)
		if mouse_x > leftX && mouse_x < rightX && mouse_y > topY && mouse_y < bottomY
			return true
		end
		return false
	end


	def display_track(track)
		#to edit the font of the tracks
		@track_font.draw(track.name, X_CORDINATE, track.dimen.topY, ZOrder::PLAYER, 1, 1, Gosu::Color::WHITE)
	end

	def playTrack(track, album)
		@song = Gosu::Song.new(album.tracks[track].location)
		@song.play(false)
	end

	def draw_background()
		#draw the background
		draw_quad(0,0, TOP_COLOR, 0, HEIGHT, TOP_COLOR, WIDTH, 0, BOTTOM_COLOR, WIDTH, HEIGHT, BOTTOM_COLOR, z = ZOrder::BACKGROUND)
	end

	def update
		if not @song.playing?
			@track_playing = @track_playing
			playTrack(@track_playing, @album)
		end
	end

	def draw
		draw_background()
		draw_albums(@album)
		draw_current_playing(@track_playing)
	end

 	def needs_cursor?; true; end


	def button_down(id)
		case id
	    when Gosu::MsLeft
	    	for i in 0...@album.tracks.length()
		    	if area_clicked(@album.tracks[i].dimen.leftX, @album.tracks[i].dimen.topY, @album.tracks[i].dimen.rightX, @album.tracks[i].dimen.bottomY)
		    		playTrack(i, @album)
		    		@track_playing = i
		    		break
		    	end
		    end
	    end
	end

end


MusicPlayerMain.new.show if __FILE__ == $0
