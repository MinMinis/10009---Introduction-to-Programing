require './input_functions'

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
		@tracks = Array.new()
	end
end

class Track
	attr_accessor :name, :location
	def initialize (name, location)
		@name = name
		@location = location
	end
end
#submenu for option 1
def read_albums(music_file, albums)
  puts('Enter album filename: ')
  albums = Array.new()
  count = music_file.gets.chomp.to_i()
  i = 0
  while (i < count)
    album = read_album(music_file)
    albums << album
    i += 1
  end
  music_file.close()
  puts("File has been read. Read " + count.to_s + " have been read albums.")
  puts("Enter to continue")
  gets
  return albums
end

def read_album(music_file)
  album_title = music_file.gets()
  album_artist = music_file.gets()
  album_genre = music_file.gets()
  album_tracks = read_tracks(music_file)
  album = Album.new(album_title, album_artist, album_genre, album_tracks)
  return album
end

#read the tracks 1 by one
def read_tracks(music_file)
  count = music_file.gets().to_i()
  tracks = Array.new()
  i = 0
  while i < count
    track = read_track(music_file)
    tracks << track
    i += 1
  end
  return tracks
end

# read into single track
def read_track(music_file)
  song_name = music_file.gets
  song_location = music_file.gets
  track = Track.new(song_name, song_location)
  return track
end

#print the track 1 by one
def print_tracks(tracks)
  i = 0
  c = tracks.length
  puts("There are #{c.to_s} tracks in this album:")
  while (i < c)
    print_track(tracks[i])
    i += 1
  end
end

def print_albums(albums)
  i = 0
  c = albums.length
  while (i < c)
      puts "The following are the details of the album #{i + 1}"
      print_album(albums[i])
      i += 1
  end
  puts("Enter to continue...")
  gets()
end

#for submenu 3
def print_album_names(albums)
  puts("Play Albums")
  i = 0
  c = albums.length
  while (i < c)
    puts ("The #{i + 1} Album is:" + albums[i].title)
    index += 1
  end

  album_sel = read_integer_in_range("Select an album to play", 1, c)
  puts ("Tracks in album #{album_selection}: ")
  print_tracks(albums[album_selection - 1].tracks)

  track_sel = read_integer_in_range("Select a track to play", 1, (albums[album_sel].tracks.length + 1))
  puts ("Playing Track #{track_sel}: " + albums[album_sel - 1].tracks[track_sel - 1].name)
  sleep(2.0)
  puts("Enter to continue.")
  gets()
end

def update_album(albums)
  done = true
  while (done  == true)
      i = 0
      change_menu = true
      album_sel = change_menu(albums)
      c = albums.length

      while (i < c) && (change_menu == true)
          if (album_sel == (i + 1))
              puts ("Current Title: " + albums[i].title)
              puts ("Current Genre: " + albums[i].genre)

              puts ("1: Update Title")
              puts ("2: Update Genre")
              puts ("3: Return")
          menu_choice = read_integer_in_range("Please select an option", 1, 3)
          case menu_choice
          when 1
              albums[album_sel - 1].title = read_string("Enter updated title: ")
              puts ("Updated Title is: " + albums[album_sel - 1].title)
              change_menu = false
          when 2
              albums[album_sel - 1].genre = read_string("Enter updated genre: ")
              puts ("Updated Genre is:" + albums[album_sel - 1].genre)
              change_menu = false
          when 3
              change_menu = false
          end
      if (album_sel == (albums.length + 1))
        change_menu = false
        done = false
        end
    end
  end
  return albums
end
end


def change_menu(albums)
  puts "Change title or genre of album"
  i = 0
  c = albums.length
  while (i < c)
    puts "Albums #{i +1} Details: "
    puts ("New title for the album: " + albums[i].title)
    puts ("New genre for the album: " + albums[i].genre)
    i += 1
  end

  i = 0
  while (i < c)
      puts "#{i + 1}: " + albums[i].title.chomp
      i += 1
  end
  puts("#{i + 1}: Exit")
  album_sel = read_integer_in_range("Menu Choice: ", 1, (i + 1))
  return album_sel
end


#print one by one to the terminal
def print_track(track)
	puts("Track title is: " + track.name)
	puts("Track file location is: " + track.location)
end

def print_albums(albums)
  i = 0
  c = albums.length
  while i < c
    puts("Detail of the #{i + 1} albums:")
    print_album(albums)
    i += 1
  end
  puts("Enter to continue.")
  gets()
end

#print out the album with format
def print_album(album)
  puts 'Title is ' + album.title
  puts 'Artist is ' + album.artist
  puts 'Genre is ' + album.genre
  tracks = album.tracks
  print_tracks(album.tracks)
end

def main()
  albums = nil
	finished = false
  begin
    puts('Main Menu:')
    puts('1 Read in Albums:')
    puts('2 Display Albums:')
    puts('3 Select an Album to play:')
	  puts('4 Update an existing Album')
	  puts('5 Exit')
    choice = read_integer_in_range("Please enter your choice:", 1, 5)
    case choice
    when 1
        #read in albums
        music_file = File.new("albums.txt", "r")
        albums = read_albums(music_file, albums)
        music_file.close()
	  when 2
        #display albums
        print_albums(albums)
    when 3
        #select an album to play
        print_album_names(albums)
    when 4
        #update an existing album
        albums = update_album(albums)
    else
        #exit
        puts("Goodbye. Love you!")
        break
    end
  end until finished == true 
end

main()