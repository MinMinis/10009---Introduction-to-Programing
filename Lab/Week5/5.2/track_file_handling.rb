
# Look at Task 5.1 T Music Records for an example of how to create the following

class Track
	# ????
  attr_accessor :name, :location
	def initialize (name, location)
		@name = name
		@location = location
	end
end

# Returns an array of tracks read from the given file
def read_tracks music_file
	tracks = Array.new()
	count = music_file.gets().to_i

  # Put a while loop here which increments an index to read the tracks
  i = 0
  while i < count
    track = read_track(music_file)
    tracks << track
    i += 1
  end
  return tracks
end

# reads in a single track from the given file.
def read_track(aFile)
  # complete this function
	# you need to create a Track here - see 5.1 T, Music Record for this too.
  name = aFile.gets
  location = aFile.gets
  track = Track.new(name, location)
  return track
end


# Takes an array of tracks and prints them to the terminal
def print_tracks tracks

  # Use a while loop with a control variable
  # to print each track. Use tracks.length to determine how
  # many times to loop.
  i = 0
  while (i < tracks.length)
    print_track(tracks[i])
    i += 1
  end
  # Print each track
end

# Takes a single track and prints it to the terminal
def print_track track
  puts('Track title is: ' + track.name)
	puts('Track file location is: ' + track.location)
end

# Open the file and read in the tracks then print them
def main
  aFile = File.new("input.txt", "r") # open for reading
  if aFile  # if nil this test will be false
    tracks = read_tracks(aFile)
    aFile.close
  else
    puts "Unable to open file to read!"
  end
  # Print all the tracks
  print_tracks(tracks)
end

main
