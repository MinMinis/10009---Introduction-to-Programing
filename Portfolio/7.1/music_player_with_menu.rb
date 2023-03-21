require './input_functions'

# It is suggested that you put together code from your
# previous tasks to start this. eg:
# TT3.2 Simple Menu Task
# TT5.1 Music Records
# TT5.2 Track File Handling
# TT6.1 Album file handling
module Genre
  POP, CLASSIC, JAZZ, ROCK = *0..3
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :album_id, :title, :artist, :genre, :tracks
	def initialize (id, title, artist, genre, tracks)
    @album_id = id
  	@title = title
		@artist = artist
		@genre = genre
		@tracks = tracks
	end
end

class Track
	attr_accessor :track_id, :name, :location
	def initialize (id, name, location)
    @track_id = id
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
puts("Track title is: " + track.name.to_s)
puts("Track file location is: " + track.location)
end

#read album information
def read_album(music_file, i)
  album_id = i
  album_title = music_file.gets().chomp
  album_artist = music_file.gets()
  album_genre = music_file.gets.to_i()
  album_tracks = read_tracks(music_file)
  album = Album.new(album_id,album_title, album_artist, album_genre, album_tracks)
  return album
end

#read file from terminal
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


#the core for the print album
def print_album(album)
  puts("Album id: " + album.album_id.to_s)
  puts(album.title.to_s + " sang/created " + album.artist.to_s)
	puts('Genre is ' + $genre_names[album.genre].to_s )
  print_tracks(album.tracks)
end

#the core for the print albums
def print_albums(albums)
  i = 0
  while i < albums.length
    print_album(albums[i])
    i += 1
  end
end

#menu option 1 for display menu
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

#play track def for play album
def play_track(album)
	length = album.tracks.length
	i = read_integer_in_range("Enter track ID: ", 1, length)
	puts("Playing track " + album.tracks[i-1].name.chomp + " from album " + album.title.chomp)
	return i-1
end

#menu 3
def play_album(albums)
	length = albums.length
	album_index = read_integer_in_range("Enter album ID:",1,length) - 1
	album = albums[album_index]
	print_tracks(album.tracks)
    track_id = play_track(album)
    return album_index,track_id, album
end



#menu 2
def display_albums(albums)
  begin
    puts("")
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
      puts("")
      puts("Select Genre Menu")
      puts("1 Pop")
      puts("2 Classic")
      puts("3 Jazz")
      puts("4 Rock")
      song_genre = read_integer_in_range("Select Genre to play", 1, 4)
      i = 0
      c = albums.length
      while i < c
        if song_genre == albums[i].genre
          print_album(albums[i])
        end
        i += 1
      end
  end
  end
end
end


def display_menu(albums, music_file)
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
    puts("")
    puts("Select Genre Menu")
    puts("1 Pop")
    puts("2 Classic")
    puts("3 Jazz")
    puts("4 Rock")
    song_genre = read_integer_in_range("Select Genre to Play", 1, 4)
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

#menu 4
def update_album(albums)
  begin
    puts("")
	  i = read_integer_in_range("Please Enter Album ID that you want to change: ",1, albums.length)
	  album = albums[i - 1]
    puts("")
	  puts("Update Album Menu:")
    puts("1 To Update Album Title:")
    puts("2 To Update Album Genre:")
    puts("3 Exit")
	  choose = read_integer_in_range("Please enter your choice:", 1, 3)
	  case choose
    when 1
      new_title = read_string("Enter new title: ")
      album.title = new_title
	  when 2
      new_genre = read_integer_in_range("Enter new genre between 1 - 4", 1, 4)
      album.genre = new_genre
  end
  print_album(album)
  return albums
  end
end



#display main menu
def display_menu(albums, music_file, finished)
  begin
    puts("")
      puts('Main Menu:')
      puts('1 Read file:')
      puts('2 Display Album Info:')
      puts('3 Play Album Info:')
      puts('4 Update Album')
      puts('5 Exit')
    choice = read_integer_in_range("Please enter your choice:", 1, 5)
    case choice
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

