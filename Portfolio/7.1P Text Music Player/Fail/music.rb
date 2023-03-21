require_relative 'input_functions'

module Genre
    POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :title, :artist, :genre, :tracks
	def initialize (title, artist, genre, tracks)
  	@title = title
		@artist = artist
		@genre = Genre::POP
		@tracks = tracks
	end
end

class Track
	attr_accessor :name, :location
	def initialize (name, location)
		@name = name
		@location = location
	end
end

# read into single track
def read_track(music_file, i)
    track_id = i
    song_name = music_file.gets
    song_location = music_file.gets
    track = Track.new(track_id, song_name, song_location)
    return track
  end

#read the tracks 1 by one
def read_tracks(music_file)
    tracks = Array.new()
    i = 0
    count = music_file.gets.to_i()
    while i < count
      track = read_track(music_file, i + 1)
      tracks << track
      i += 1
    end
    return tracks
  end

#print the track 1 by one
def print_tracks(tracks)
    i = 0
    c = tracks.length
    puts("There are #{c.to_s} tracks in this album:")
    puts("Track List: ")
    while (i < c)
      print_track(tracks[i])
      i += 1
    end
  end


#print track with title and location
def print_track(track)
  puts("Track id is " + track.track_id.to_s)
	puts("Track title is: " + track.name_to.s)
	puts("Track file location is: " + track.location_to.s)
end

#play track
def play_track(album)
  c = album.tracks.length
  i = read_integer_in_range("Please enter track number to play: ", 1, c)
  puts("Playing track " + album.tracks[i-1].name + " from album " + album.title)
end

#menu 1
def read_albums(music_file, albums)
  albums = Array.new()
  count = music_file.gets.to_i()
  i = 0
  while (i < count)
    album = read_album(music_file, count)
    albums << album
    i += 1
  end
  music_file.close()
  return albums
end
#support for submenu 1
  def read_album(music_file, i)
    album_id = i
    album_title = music_file.gets().chomp
    album_artist = music_file.gets()
    album_genre = music_file.gets.to_i()
    album_tracks = read_tracks(music_file)
    album = Album.new(album_id,album_title, album_artist, album_genre, album_tracks)
    return album
  end

#read album out
def read_out_albums()
  albums = Array.new()
  a_file = read_string("Enter file name to read: ")
  music_file = File.new(a_file, "r")
  i = 0
  count = music_file.gets.to_i()
  while i < count
    albums << read_album(music_file, i + 1)
    i += 1
  end
  puts("The file has been loaded")
  read_string("Enter to continue...")
  return albums
  music_file.close()
end

#print all albums
def print_all_albums(albums)
    i = 0
    c = albums.length
    while (i < c)
        puts "The following are the details of the album #{i + 1}: "
        print_album(albums[i])
        i += 1
    end
    puts("Enter to continue...")
    gets()
  end

#print out the album with format
def print_album(album)
  puts("Album id: " + album.album_id.to_s)
  puts(album.title.to_s + " was sang by " + album.artist.to_s)
	puts('Genre is ' + $genre_names[album.genre].to_s )
  print_tracks(album.tracks)
end

def print_albums(albums)
  i = 0
  while i < albums.length
    print_album(albums[i])
    i += 1
  end
end

#play the album
def play_album(albums, search_album_id)
  count = albums.length
  i = 0
  while i < count
    if (albums[i].album_id == search_album_id)
      print_tracks(albums[i].tracks)
      search_album_id = read_integer_in_range("Enter Track ID", 1, count)
      play_tracks(albums[i], albums[i].tracks, search_album_id)
    end
    i+=1
  end
end

#play the track
def play_tracks(albums, tracks, search_album_id)
  i = 0
  count = tracks.length
  while i < count
    if (tracks[i].track_id == search_album_id)
      puts("Playing track: " + tracks[i].name + " from album " + albums.title + " by " + albums.artist)
    end
    i+=1
  end
end



#print album by id
def print_album_id(album)
  i = 0
  while i < album.length
      puts(album[i].title + " ID is " + album[i].album_id.to_s)
      i+=1
  end
  if (press == 3)
    search_album_id = read_integer_in_range("Enter Album ID you want to play", 1, album.length)
    play_album(album, search_album_id)
  end
  if (press == 4)
    search_album_key = read_integer_in_range("Enter Album ID you want to update", 1, album.length)
    update_album(album, search_album_id)
  end
end

#menu 4
def update_album(albums)
  begin
  album_len = albums.length
  i = read_integer_in_range("Please enter Album you want to update : ", 1, album_len)
  puts("Update Album menu")
  puts("1 Update Album Title")
  puts("2 Update Album Genre")
  puts("3 Exit")
  test = read_integer_in_range("Please enter your choice")
  case  test
  when 1  then
    new_title = read_string("Enter new title: ")
    album.title = new_title
    return album.title
  when 2 then
    new_genre = read_integer_in_range("Enter new genre between 1 - 4",1,4)
    album.genre = new_genre
    return album.genre
  end
  print_album(album, al_number)
  return albums
end
end


#menu 2
def display_albums(albums)
    begin
        puts("Display Album")
        puts("1 Display All: ")
        puts("2 Display Genre: ")
        puts("3 Exit")
        test = read_integer_in_range("Please enter your choice:", 1, 3)
    case test
    when 1
        print_all_albums(albums)
    when 2
      begin
        puts("1 Pop")
        puts("2 Classic")
        puts("3 Jazz")
        puts("4 Rock")
        song_genre = read_integer_in_range("Selec Genre to play", 1, 4)
        i = 0
        c = albums.length
        while i < c
          if song_genre == genre_names[albums[i].genre]
            print_album(albums[i])
          end
          i += 1
        end
    end
    end
end
end

#display main menu
def display_menu(albums, music_file, finished)
    begin
        puts('Main Menu:')
        puts('1 Read file:')
        puts('2 Display Album Info:')
        puts('3 Play Album Info:')
        puts('4 Update Album')
        puts('5 Exit')
      choice = read_integer_in_range("Please enter your choice:", 1, 5)
      case choice
      if albums == nil && music_file == nil && (choice > 1 && choice < 5)
      when 1
          #read in albums
          albums = read_out_albums()
      when 2
          #display albums
          if albums != nil then
          display_albums(albums)
          end
      when 3
          #select an album to play
          album, track_id = play_album(albums)
      when 4
          #update an existing album
          albums = update_album(albums)
      when 5
          #exit
          puts("Goodbye. Love you!")
          break
      end
    end until finished == true
  end


  def main()
    albums = nil
    finished = false
    music_file = nil
    display_menu(albums, music_file, finished)
  end

main()
