
require 'gosu'

COLOR_ON_TOP = Gosu::Color.new(0xff_ffffff)
COLOR_AT_BOTTOM = Gosu::Color.new(0xff_ffffff)
WIDTH = 1400
HEIGHT = 700
CURSOR_PLACE = 800

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp, :dimen
	def initialize(file, left_of_x, top_of_Y)
		@bmp = Gosu::Image.new(file)
		@dimen = Dimension.new(left_of_x, top_of_Y, left_of_x + @bmp.width(), top_of_Y + @bmp.height())
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
	attr_accessor :name, :location, :dimen, :added
	def initialize(name, location, dimen, added)
		@name = name
		@location = location
		@dimen = dimen
    @added = added
	end
end

class Playlist
	attr_accessor :name, :location, :dimen
	def initialize(name, location, dimen)
		@name = name
		@location = location
		@dimen = dimen
	end
end

class Dimension
	attr_accessor :left_of_x, :top_of_Y, :right_of_X, :bottom_of_Y
	def initialize(left_of_x, top_of_Y, right_of_X, bottom_of_Y)
		@left_of_x = left_of_x
		@top_of_Y = top_of_Y
		@right_of_X = right_of_X
		@bottom_of_Y = bottom_of_Y
	end
end

class MusicPlayer < Gosu::Window

	def initialize()
	    super WIDTH, HEIGHT, true
	    self.caption = "Music Player"
	    @font_track = Gosu::Font.new(20)
	    @albums = read_albums()
	    @played_album = -1
	    @played_track = -1
      @list_playing = -1
      @add_playlist = Gosu::Image.new("images/add.png")
      @playlist = []
      @index = 1
      @list_i = 1
	end

  def read_albums()
		music_file = File.new("album.txt", "r")
		count = music_file.gets.chomp.to_i
		albums = Array.new()
		j = 0
		while j < count
			album = read_album(music_file, j)
			albums << album
			j += 1
	  	end
		music_file.close()
		return albums
	end

  def read_album(music_file, num)
		title = music_file.gets.chomp
		artist = music_file.gets.chomp
		if num % 2 == 0
			left_of_x = 30
		else
			left_of_x = 450
		end

    if num <= 1
			top_of_Y = 30
		else
			top_of_Y = 190 * (1 * 2) + 30 + 20 * (1 * 2)
		end

		artwork = ArtWork.new(music_file.gets.chomp, left_of_x, top_of_Y)
		tracks = read_tracks(music_file)
		album = Album.new(title, artist, artwork, tracks)
		return album
	end

  def read_tracks(music_file)
		count = music_file.gets.chomp.to_i
		tracks = Array.new()
		j = 0
		while j < count
			track = read_track(music_file, j)
			tracks << track
			j += 1
		end
		return tracks
	end

  def read_track(music_file, num)
    #Track information
		track_name = music_file.gets.chomp
		track_location = music_file.gets.chomp
		#coordinate of track
		left_of_x = CURSOR_PLACE
		top_of_Y = 70 * num + 130
		right_of_X = left_of_x + @font_track.text_width(track_name)
		bottom_of_Y = top_of_Y + @font_track.height()
		dimen = Dimension.new(left_of_x, top_of_Y, right_of_X, bottom_of_Y)


    left_of_xi = left_of_x - 50
		top_of_Yi = top_of_Y + 3
		right_of_Xi = left_of_xi + 30
		bottom_of_Yi = top_of_Yi + 27
    added = Dimension.new(left_of_xi, top_of_Yi, right_of_Xi, bottom_of_Yi)

		track = Track.new(track_name, track_location, dimen, added)
		return track
	end

  def update
		if @played_album >= 0 && @song == nil
			@played_track = 0
			playTrack(0, @albums[@played_album])
		end

		if @played_album >= 0 && @song != nil && (not @song.playing?)
			@played_track = (@played_track + 1) % @albums[@played_album].tracks.length()
			playTrack(@played_track, @albums[@played_album])
		end
	end

  def playTrack(track, album)
		@song = Gosu::Song.new(album.tracks[track].location)
		@song.play(false)
	end

  def playlist(track)
    @song = Gosu::Song.new(track.location)
		@song.play(false)
	end

  def draw
    @font_track.draw_text("Click on the left of the track to add to current playlist", 700, 50, ZOrder::UI, 1.2, 1.2, Gosu::Color::RED)
    @font_track.draw_text("PLAYLIST", 1050, 400, ZOrder::UI, 1.5, 1.5, Gosu::Color::RED)
		draw_background()
		draw_albums(@albums)
		if @played_album >= 0
			draw_tracks(@albums[@played_album])
			draw_played(@played_track, @albums[@played_album])
		end
    if @playlist.length >0

      for track in @playlist
        draw_playlist(track)
      end
    end
	end

  def draw_background()
		draw_quad(0,0, COLOR_ON_TOP, 0, HEIGHT, COLOR_ON_TOP, WIDTH, 0, COLOR_AT_BOTTOM, WIDTH, HEIGHT, COLOR_AT_BOTTOM, ZOrder::BACKGROUND)
	end

  def draw_albums(albums)
		albums.each do |album|
			album.artwork.bmp.draw(album.artwork.dimen.left_of_x, album.artwork.dimen.top_of_Y , ZOrder::PLAYER)
		end
	end

  def draw_tracks(album)
		album.tracks.each do |track|
			displaying_track(track)
		end
	end

  def displaying_track(track)
		@font_track.draw(track.name, CURSOR_PLACE, track.dimen.top_of_Y, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
    @add_playlist.draw(track.added.left_of_x, track.added.top_of_Y)
	end

	def draw_played(num, album)
    draw_rect(album.tracks[num].dimen.left_of_x - 12, album.tracks[num].dimen.top_of_Y, 5, @font_track.height() + 2, Gosu::Color::BLACK, ZOrder::PLAYER)

  end

  def draw_playlist_current(x,y)
    draw_rect(x, y, 5, @font_track.height() + 2, Gosu::Color::BLACK, ZOrder::PLAYER)
  end

  def draw_playlist(track)
    @font_track.draw(track.name, track.dimen.left_of_x, track.dimen.top_of_Y, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def needs_cursor?; true; end

  def area_clicked(left_of_x, top_of_Y, right_of_X, bottom_of_Y)
		if mouse_x > left_of_x && mouse_x < right_of_X && mouse_y > top_of_Y && mouse_y < bottom_of_Y
			return true
		end
		return false
	end

  def button_down(id)
		case id
			when Gosu::KbEscape
				close
	    when Gosu::MsLeft
	    	if @played_album >= 0
		    	for j in 0...@albums[@played_album].tracks.length()
			    	if area_clicked(@albums[@played_album].tracks[j].dimen.left_of_x, @albums[@played_album].tracks[j].dimen.top_of_Y, @albums[@played_album].tracks[j].dimen.right_of_X, @albums[@played_album].tracks[j].dimen.bottom_of_Y)
			    		playTrack(j, @albums[@played_album])
			    		@played_track = j
			    		break
			    	end
			    end
			end

			for j in 0...@albums.length()
				if area_clicked(@albums[j].artwork.dimen.left_of_x, @albums[j].artwork.dimen.top_of_Y, @albums[j].artwork.dimen.right_of_X, @albums[j].artwork.dimen.bottom_of_Y)
					@played_album = j

					@song = nil
					break
				end
			end

      if @playlist.length >= 0
        for track in @playlist
          if area_clicked(track.dimen.left_of_x, track.dimen.top_of_Y, track.dimen.right_of_X, track.dimen.bottom_of_Y)
            playlist(track)
            @list_playing = j
            break
          end
        end
    end

      for j in 0...@albums[@played_album].tracks.length()
				if area_clicked(@albums[@played_album].tracks[j].added.left_of_x, @albums[@played_album].tracks[j].added.top_of_Y, @albums[@played_album].tracks[j].added.right_of_X, @albums[@played_album].tracks[j].added.bottom_of_Y)
					@song.play(true)
          name = @albums[@played_album].tracks[j].name
          location = @albums[@played_album].tracks[j].location


          if @playlist.length() > 1
            if @index > 2
              @index = 1
              @list_i += 1
            end
            left_of_x = CURSOR_PLACE - 300 + @list_i * 130 + 200
            top_of_Y = 600 + @index * 40 - 200
            @index += 1


          else
            left_of_x = CURSOR_PLACE - 300 + 200
            top_of_Y = 600 + @index * 50 - 200
            @index += 1
          end
          right_of_X = left_of_x + @font_track.text_width(name)
		      bottom_of_Y = top_of_Y + @font_track.height()
          dimen = Dimension.new(left_of_x, top_of_Y, right_of_X, bottom_of_Y)
          playlist = Playlist.new(name, location, dimen)
          @playlist.append(playlist)
				end
			end
	    end
	end

end

MusicPlayer.new.show if __FILE__ == $0
