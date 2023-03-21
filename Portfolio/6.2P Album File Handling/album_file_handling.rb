
# Task 6.1 T - use the code from last week's tasks to complete this:
# eg: 5.1T, 5.2T

module Genre
    POP, CLASSIC, JAZZ, ROCK = *1..4
  end
  
  $genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']
  
  class Album
  # NB: you will need to add tracks to the following and the initialize()
      attr_accessor :title, :artist, :genre, :tracks
  
  # complete the missing code:
      def initialize (title, artist, genre, tracks)
          # insert lines here
          @title = title
          @artist = artist
          @genre = genre
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
  
  # Reads in and returns a single track from the given file
  
  def read_track(music_file)
      # fill in the missing code
      name = music_file.gets
        location = music_file.gets
        track = Track.new(name, location)
        return track
  end
  
  # Returns an array of tracks read from the given file
  
  def read_tracks(music_file)
      
      count = music_file.gets().to_i()
        tracks = Array.new()
  
    # Put a while loop here which increments an index to read the tracks
      i = 0
      while i < count
          track = read_track(music_file)
          tracks << track
          i += 1
      end
      return tracks
  end
  
  # Takes an array of tracks and prints them to the terminal
  
  def print_tracks(tracks)
      # print all the tracks use: tracks[x] to access each track.
      i = 0
      while (i < tracks.length)
          print_track(tracks[i])
          i += 1
      end
  end
  
  # Reads in and returns a single album from the given file, with all its tracks
  
  def read_album(music_file)
  
    # read in all the Album's fields/attributes including all the tracks
    # complete the missing code
      album_title = music_file.gets
      album_artist = music_file.gets
      album_genre = music_file.gets
      album = Album.new(album_title, album_artist, album_genre, read_tracks(music_file))
      return album
  end
  
  
  # Takes a single album and prints it to the terminal along with all its tracks
  def print_album(album)
  
    # print out all the albums fields/attributes
    # Complete the missing code.
      puts(album.title)
      puts(album.artist)
      puts('Genre is ' + album.genre.to_s)
      puts($genre_names[album.genre.to_i])
      # print out the tracks
      print_tracks(album.tracks)
  end
  
  # Takes a single track and prints it to the terminal
  def print_track(track)
        puts(track.name)
      puts(track.location)
  end
  
  # Reads in an album from a file and then print the album to the terminal
  
  def main()
      music_file = File.new("album.txt", "r")
      album = read_album(music_file)
      music_file.close()
      print_album(album)
  end
  
  main()